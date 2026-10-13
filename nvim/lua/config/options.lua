-- ============================================================================
-- 选项设置
-- ============================================================================
vim.opt.number = true        -- 显示行号
vim.opt.cursorline = true    -- 高亮当前行
vim.opt.scrolloff = 10       -- 光标上下各保留10行

vim.opt.tabstop = 4          -- Tab显示为4个空格
vim.opt.shiftwidth = 4       -- 自动缩进宽度为4个空格
vim.opt.softtabstop = 4      -- 插入或删除 tab 时按4 个空格处理
vim.opt.smartindent = true   -- 智能缩进

vim.opt.ignorecase = true    -- 搜索时忽略大小写
vim.opt.smartcase = true     -- 搜索内容包含大写时区分大小写
vim.opt.hlsearch = true      -- 高亮搜索结果
vim.opt.incsearch = true     -- 输入搜索时实时显示匹配结果

vim.opt.signcolumn = "yes"   -- 始终显示符号列
vim.opt.colorcolumn = "100"  -- 在第 100 列显示参考线
vim.opt.showmatch = true     -- 高亮匹配的括号
vim.opt.cmdheight = 1        -- 命令行区域高度为1格
vim.opt.completeopt = "menuone,noinsert,noselect"   -- 设置补全菜单行为
vim.opt.showmode = false     -- 不在命令行显示模式（可由状态栏显示）
vim.opt.laststatus = 2       -- 始终显示状态栏
vim.opt.pumheight = 10       -- 补全弹出菜单最多显示 10 行
vim.opt.pumblend = 10        -- 补全弹出菜单透明度
vim.opt.winblend = 0         -- 浮动窗口透明度
vim.opt.conceallevel = 2     -- 隐藏部分标记字符（Obsidian 等插件可能需要）
vim.opt.concealcursor = ""   -- 光标所在行不隐藏标记字符
vim.opt.synmaxcol = 300      -- 语法高亮最多处理每行前 300 列
vim.opt.fillchars = { eob = " " } -- 隐藏空行前的 "~"

local undodir = vim.fn.expand("~/.vim/undodir")
if
	vim.fn.isdirectory(undodir) == 0 -- 如果撤销目录不存在
then
	vim.fn.mkdir(undodir, "p") -- 创建撤销目录
end

vim.opt.backup = false        -- 不创建备份文件
vim.opt.writebackup = false   -- 写入文件时不创建备份
vim.opt.swapfile = false      -- 不创建交换文件
vim.opt.undofile = true       -- 保存撤销历史到文件
vim.opt.undodir = undodir     -- 设置撤销文件目录
vim.opt.updatetime = 300      -- 缩短更新时间
vim.opt.timeoutlen = 500      -- 按键映射等待时间
vim.opt.ttimeoutlen = 50      -- 键码等待时间
vim.opt.autoread = true       -- 文件在外部修改时自动重新读取
vim.opt.autowrite = false     -- 不自动保存文件

vim.opt.hidden = true         -- 允许切换缓冲区时保留未保存内容
vim.opt.errorbells = false    -- 关闭错误提示音
vim.opt.backspace = "indent,eol,start" -- 允许退格删除缩进、换行和此前输入的内容
vim.opt.autochdir = false     -- 不随当前文件自动切换工作目录
vim.opt.iskeyword:append("-") -- 将连字符视为单词的一部分
vim.opt.path:append("**")     -- 搜索路径包含子目录
vim.opt.selection = "inclusive" -- 选区包含光标所在字符
vim.opt.mouse = "a"           -- 在所有模式中启用鼠标
vim.opt.clipboard:append("unnamedplus") -- 使用系统剪贴板
vim.opt.modifiable = true     -- 允许修改缓冲区内容

-- 折叠：运行时需要 Treesitter；不可用时可能无法按预期折叠
vim.opt.foldmethod = "expr"   -- 使用表达式计算折叠
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- 使用 Treesitter 折叠表达式
vim.opt.foldlevel = 99        -- 启动时展开所有折叠

vim.opt.splitbelow = true     -- 水平分屏时在下方打开新窗口
vim.opt.splitright = true     -- 垂直分屏时在右侧打开新窗口

vim.opt.wildmenu = true       -- 启用命令行补全菜单
vim.opt.wildmode = "longest:full,full" -- 先补全最长公共部分，再显示并循环浏览候选项
vim.opt.diffopt:append("linematch:60") -- 改善差异对比显示
vim.opt.redrawtime = 10000    -- 增加重绘超时时间
vim.opt.maxmempattern = 20000 -- 增加模式匹配可使用的最大内存
