--[[
Desktop notifications when a CodeCompanion chat finishes a turn.

`on_completed` is the right hook: it fires once from `Chat:finish`, which the
agent loop only reaches after the LLM stops asking for tools. `on_ready` is
wrong, because it also fires between tool rounds. `on_cancelled` is separate,
since stopping a request goes through `Chat:stop` and never reaches `finish`.
]]

local M = {}

local DEFAULTS = {
    enabled = true,
    on_success = true,
    on_error = true,
    -- Don't interrupt when you're already looking at the chat
    only_when_unfocused = true,
    -- "auto" | "kitten" | "notify-send" | "vim"
    backend = "auto",
    -- How much of the reply to include in the body
    max_chars = 240,
}

M.opts = vim.deepcopy(DEFAULTS)

---Has a usable desktop notification service?
---@return boolean
local function has_notifier()
    if vim.fn.executable("notify-send") ~= 1 then
        return false
    end
    return (vim.env.DISPLAY ~= nil and vim.env.DISPLAY ~= "")
        or (vim.env.WAYLAND_DISPLAY ~= nil and vim.env.WAYLAND_DISPLAY ~= "")
end

---@return string
local function resolve_backend()
    if M.opts.backend ~= "auto" then
        return M.opts.backend
    end
    -- `kitten notify` works over SSH and is what kitty users want
    if vim.fn.executable("kitten") == 1 and (vim.env.KITTY_WINDOW_ID or vim.env.KITTY_LISTEN_ON) then
        return "kitten"
    end
    if has_notifier() then
        return "notify-send"
    end
    return "vim"
end

---Is the buffer visible in the window you're typing in?
---@param bufnr number
---@return boolean
local function is_focused(bufnr)
    local win = vim.api.nvim_get_current_win()
    return vim.api.nvim_win_get_buf(win) == bufnr
end

---@param cmd string[]
---@param opts table
---@return boolean started
local function spawn(cmd, opts)
    local ok, handle = pcall(vim.fn.jobstart, cmd, opts)
    -- `jobstart` returns 0 or -1 for an unusable command rather than throwing
    return ok and type(handle) == "number" and handle > 0
end

---@param title string
---@param body string
---@param level number
local function send(title, body, level)
    local backend = resolve_backend()

    if backend == "kitten" then
        -- `kitten notify` talks to the OS notification service through kitty, so
        -- it needs a controlling terminal. `vim.system` provides none; a
        -- `jobstart` with `tty` does.
        if spawn({ "kitten", "notify", title, body }, { tty = true, detach = true }) then
            return
        end
        backend = has_notifier() and "notify-send" or "vim"
    end

    if backend == "notify-send" then
        local urgency = level >= vim.log.levels.ERROR and "critical" or "normal"
        local started = spawn({
            "notify-send",
            "--app-name=Neovim",
            "--urgency=" .. urgency,
            "--expire-time=8000",
            title,
            body,
        }, { detach = true })
        if started then
            return
        end
    end

    -- Last resort: an in-editor message still tells you the turn ended
    vim.notify(title .. "\n" .. body, level, { title = "CodeCompanion" })
end

---Turn a message's content into plain text
---@param content any
---@return string
local function as_text(content)
    if type(content) == "string" then
        return content
    end
    if type(content) ~= "table" then
        return ""
    end
    local parts = {}
    for _, part in ipairs(content) do
        if type(part) == "string" then
            table.insert(parts, part)
        elseif type(part) == "table" and part.type == "text" and part.text then
            table.insert(parts, part.text)
        end
    end
    return table.concat(parts, "\n")
end

---The LLM's last reply, flattened and shortened for a notification body
---@param chat CodeCompanion.Chat
---@return string
local function last_reply(chat)
    for i = #chat.messages, 1, -1 do
        local msg = chat.messages[i]
        if msg.role == "assistant" then
            local text = as_text(msg.content)
            if text ~= "" then
                -- Drop fenced code, which is meaningless in a notification
                text = text:gsub("```.-```", "[code]")
                text = text:gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
                if #text > M.opts.max_chars then
                    text = text:sub(1, M.opts.max_chars) .. "…"
                end
                return text
            end
        end
    end
    return ""
end

---A short name for the chat: its title, else the first thing you asked
---@param chat CodeCompanion.Chat
---@return string
local function chat_label(chat)
    if chat.title and chat.title ~= "" then
        return chat.title
    end
    for _, msg in ipairs(chat.messages) do
        if msg.role == "user" then
            local text = as_text(msg.content):gsub("%s+", " ")
            if text ~= "" then
                return #text > 40 and (text:sub(1, 40) .. "…") or text
            end
        end
    end
    return string.format("Chat %d", chat.id)
end

---Per-chat bookkeeping, reset on every submit
---@type table<number, { tools: number, started: number }>
local turn = {}

---@param chat CodeCompanion.Chat
---@param data { status?: string, error?: string }
local function on_completed(chat, data)
    if not M.opts.enabled then
        return
    end

    local status = data and data.status or ""
    local failed = status == "error" or (data and data.error ~= nil)

    if failed and not M.opts.on_error then
        return
    end
    if not failed and not M.opts.on_success then
        return
    end
    if M.opts.only_when_unfocused and is_focused(chat.bufnr) then
        return
    end

    local state = turn[chat.id] or {}
    turn[chat.id] = nil

    local elapsed = ""
    if state.started then
        local secs = (vim.uv.hrtime() - state.started) / 1e9
        elapsed = secs >= 60 and string.format(" (%.0f min)", secs / 60) or string.format(" (%.0f s)", secs)
    end

    local tools = (state.tools or 0) > 0 and string.format(", %d tool call%s", state.tools, state.tools == 1 and "" or "s")
        or ""

    local label = chat_label(chat)

    if failed then
        local reason = (data and data.error) or "The request failed"
        reason = tostring(reason):gsub("%s+", " ")
        if #reason > M.opts.max_chars then
            reason = reason:sub(1, M.opts.max_chars) .. "…"
        end
        send("CodeCompanion: failed" .. elapsed, string.format("%s\n%s", label, reason), vim.log.levels.ERROR)
        return
    end

    if status == "success" or status == "" then
        local body = last_reply(chat)
        send(
            "CodeCompanion: done" .. elapsed,
            body ~= "" and string.format("%s%s\n%s", label, tools, body) or (label .. tools),
            vim.log.levels.INFO
        )
    end
end

---Register the callbacks and the per-chat state tracking
---@param opts? table
function M.setup(opts)
    M.opts = vim.tbl_deep_extend("force", M.opts, opts or {})

    vim.api.nvim_create_autocmd("User", {
        group = vim.api.nvim_create_augroup("codecompanion.notify", { clear = true }),
        pattern = "CodeCompanionChatCreated",
        desc = "CodeCompanion: notify when a chat finishes a turn",
        callback = function(args)
            local chat = require("codecompanion").buf_get_chat(args.data.bufnr)
            if not chat then
                return
            end

            chat:add_callback("on_submitted", function(c)
                turn[c.id] = { tools = 0, started = vim.uv.hrtime() }
            end)

            chat:add_callback("on_tool_output", function(c)
                local state = turn[c.id] or { tools = 0, started = vim.uv.hrtime() }
                state.tools = (state.tools or 0) + 1
                turn[c.id] = state
            end)

            chat:add_callback("on_completed", on_completed)

            -- Stopping a request never reaches `finish`, so clear the state here
            chat:add_callback("on_cancelled", function(c)
                turn[c.id] = nil
            end)
        end,
    })
end

---Toggle notifications, or preview one
---@param args? { fargs?: string[] }
function M.command(args)
    local sub = args and args.fargs and args.fargs[1]

    if sub == "toggle" then
        M.opts.enabled = not M.opts.enabled
        return vim.notify(
            string.format("CodeCompanion notifications %s", M.opts.enabled and "enabled" or "disabled"),
            vim.log.levels.INFO,
            { title = "CodeCompanion" }
        )
    end

    if sub == "test" then
        return send(
            "CodeCompanion: test",
            string.format("Backend: %s", resolve_backend()),
            vim.log.levels.INFO
        )
    end

    vim.notify(
        string.format(
            "notifications: %s\nbackend: %s\non_success: %s, on_error: %s, only_when_unfocused: %s",
            tostring(M.opts.enabled),
            resolve_backend(),
            tostring(M.opts.on_success),
            tostring(M.opts.on_error),
            tostring(M.opts.only_when_unfocused)
        ),
        vim.log.levels.INFO,
        { title = "CodeCompanion" }
    )
end

return M