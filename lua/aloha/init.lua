aloha = {}

aloha.prepare = require('aloha.prepare')
aloha.options = require('aloha.options')
aloha.mappings = require('aloha.mappings')
aloha.plugins = require('aloha.plugins')

function aloha:init()
	aloha.prepare:init()
	aloha.options:init()
	aloha.mappings:init()
	aloha.plugins:init()
end

return aloha
