-- leader 必须在任何使用它的映射/插件加载之前设置
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.options")
require("config.keybinds")
require("config.autocmds")
require("config.lazy")
