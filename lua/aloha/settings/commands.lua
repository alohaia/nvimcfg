local commands = {}

commands.DiffOrig = {
    exec = "vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis"
}

-- Packer commands
commands.PackInstall = {
    exec = function(args)
        aloha.packer:download("install", args.args)
    end,
    opts = {
        nargs = "?",
        complete = "custom,v:lua.aloha.packer.plugin_complete"
    }
}
commands.PackUpdate = {
    exec = function(args)
        aloha.packer:download('update', args.args)
    end,
    opts = {
        nargs = "?",
        complete = "custom,v:lua.aloha.packer.plugin_complete"
    }
}
commands.PackUninstall = {
    exec = function(args)
        aloha.packer:uninstall(args.args)
    end,
    opts = {
        nargs = 1,
        complete = "custom,v:lua.aloha.packer.plugin_complete"
    }
}
commands.PackClean = {
    exec = function(args)
        aloha.packer:uninstall(args.args)
    end,
    opts = {
        nargs = "?",
        complete = "custom,v:lua.aloha.packer.plugin_complete"
    }
}
commands.PackSync = {
    exec = function()
        aloha.packer:uninstall()
        aloha.packer:download('update')
    end,
    opts = {}
}
commands.PackAdd = {
    exec = function(args)
        aloha.packer:add(args.args)
    end,
    opts = {
        nargs = 1,
        complete = 'packadd'
    }
}

return commands
