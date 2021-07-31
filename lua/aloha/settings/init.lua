local settings = {}

local home_dir = os.getenv('HOME')

settings.mappings = require('aloha.settings.mappings')
settings.options = require('aloha.settings.options')
settings.plugins = require('aloha.settings.plugins')

return settings
