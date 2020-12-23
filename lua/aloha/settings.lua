-- Settings which may be frequently changed.

local settings = {}

-- Global variables
settings.home 		 		= os.getenv('HOME')
settings.vim_config_path 	= settings.home .. '/.config/nvim'
settings.plugin_config_path	= settings.home .. '/.config/nvim/lua/plugins_config'
settings.plugin_path 		= settings.home .. '/.config/nvim/plugins'

settings.mapleader = ' '

return settings
