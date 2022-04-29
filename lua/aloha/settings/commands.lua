return {
    ["PackInstall"] = {
        exec = function(args)
            aloha.packer:download("install", args.args)
        end,
        opts = {
            nargs = "?",
            complete = "custom,v:lua.aloha.packer.plugin_complete"
        }
    },
    ["PackUpdate"] = {
        exec = function(args)
            aloha.packer:download('update', args.args)
        end,
        opts = {
            nargs = "?",
            complete = "custom,v:lua.aloha.packer.plugin_complete"
        }
    },
    ["PackUninstall"] = {
        exec = function(args)
            aloha.packer:uninstall(args.args)
        end,
        opts = {
            nargs = 1,
            complete = "custom,v:lua.aloha.packer.plugin_complete"
        }
    },
    ["PackClean"] = {
        exec = function(args)
            aloha.packer:uninstall(args.args)
        end,
        opts = {
            nargs = "?",
            complete = "custom,v:lua.aloha.packer.plugin_complete"
        }
    },
    ["PackSync"] = {
        exec = function()
            aloha.packer:clean()
            aloha.packer:download('update')
        end,
        opts = {}
    },
}
