----------------------------------------------------------------------------------------
--                            \ Plugin Utils and Configs /                            --
----------------------------------------------------------------------------------------

_G.aloha.plugin = {}
local plugin = _G.aloha.plugin

local utils = _G.aloha.utils
local global = _G.aloha.global

plugin.list = {}

require('aloha/plugin/config')

function plugin:init()
    -- define initialization functions
    -- add them to `config` in packer use()
    plugin.config:init()

    -- Initialization for packer.nvim
    vim.cmd[[packadd packer.nvim]]
    require('packer').startup{
        function()
            for _,package in ipairs(self.list) do
                use(package)
            end
        end,
        config = {
            ensure_dependencies   = true,     -- Should packer install plugin dependencies?
            package_root          = utils.join_paths(global.paths.home, '.config', 'nvim', 'pack'),
            compile_path          = utils.join_paths(global.paths.config, 'plugin', 'packer_compiled.vim'),
            plugin_package        = 'packer', -- The default package for plugins
            max_jobs              = 6,        -- Limit the number of simultaneous jobs. nil means no limit
            auto_clean            = true,     -- During sync(), remove unused plugins
            compile_on_sync       = true,     -- During sync(), run packer.compile()
            disable_commands      = false,    -- Disable creating commands
            opt_default           = false,    -- Default to using opt (as opposed to start) plugins
            transitive_opt        = true,     -- Make dependencies of opt plugins also opt by default
            transitive_disable    = true,     -- Automatically disable dependencies of disabled plugins
            git = {
                cmd = 'git',                    -- The base command for git operations
                subcommands = {                 -- Format strings for git subcommands
                    update         = '-C %s pull --ff-only --progress --rebase=false',
                    install        = 'clone %s %s --depth %i --no-single-branch --progress',
                    fetch          = '-C %s fetch --depth 999999 --progress',
                    checkout       = '-C %s checkout %s --',
                    update_branch  = '-C %s merge --ff-only @{u}',
                    current_branch = '-C %s branch --show-current',
                    diff           = '-C %s log --color=never --pretty=format:FMT --no-show-signature HEAD@{1}...HEAD',
                    diff_fmt       = '%%h %%s (%%cr)',
                    get_rev        = '-C %s rev-parse --short HEAD',
                    get_msg        = '-C %s log --color=never --pretty=format:FMT --no-show-signature HEAD -n 1',
                    submodules     = '-C %s submodule update --init --recursive --progress'
                },
                depth = 1,                      -- Git clone depth
                clone_timeout = 600,            -- Timeout, in seconds, for git clones
            },
            display = {
                non_interactive = false,             -- If true, disable display windows for all operations
                open_fn         = nil,               -- An optional function to open a window for packer's display
                open_cmd        = '65vnew [packer]', -- An optional command to open a window for packer's display
                working_sym     = '⟳',               -- The symbol for a plugin being installed/updated
                error_sym       = '✗',               -- The symbol for a plugin with an error in installation/updating
                done_sym        = '✓',               -- The symbol for a plugin which has completed installation/updating
                removed_sym     = '-',               -- The symbol for an unused plugin which was removed
                moved_sym       = '→',               -- The symbol for a plugin which was moved (e.g. from opt to start)
                header_sym      = '━',               -- The symbol for the header line in packer's display
                show_all_info   = true,              -- Should packer show all update details automatically?
            }
        }
    }

    return plugin
end

return plugin
