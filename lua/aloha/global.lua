local global = {}

global.is_mac      = jit.os == 'OSX'
global.is_linux    = jit.os == 'Linux'
global.is_windows  = jit.os == 'Windows'
global.home        = os.getenv("HOME")
global.path_sep    = global.is_windows and '\\' or '/'
global.vim_path    = global.home .. global.path_sep .. '.config' .. global.path_sep .. 'nvim'
global.cache_dir   = global.home .. global.path_sep .. '.cache' .. global.path_sep .. 'vim' .. global.path_sep
global.modules_dir = global.vim_path .. global.path_sep .. 'modules'

return global
