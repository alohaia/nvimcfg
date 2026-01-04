local default_cmd_opts = { force = false }

local cmds = {}
cmds.DiffOrig = {
    exec = "vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis"
}

for name,cmd in pairs(cmds) do
    vim.api.nvim_create_user_command(
        name, cmd.exec,
        vim.tbl_deep_extend("force", default_cmd_opts, cmd.opts or {})
    )
end
