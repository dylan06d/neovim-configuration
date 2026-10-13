-- ============================================================================
-- 选项设置（已移除与 Neovim 默认值相同的选项）
-- ============================================================================
local opt = vim.opt

-- 界面
opt.number = true            -- 显示行号
opt.cursorline = true        -- 高亮当前行
opt.scrolloff = 10           -- 光标上下各保留10行
opt.signcolumn = "yes"       -- 始终显示符号列，避免界面抖动
opt.colorcolumn = "100"      -- 在第 100 列显示参考线
opt.showmode = false         -- 不在命令行显示模式
opt.pumheight = 10           -- 补全菜单最多显示 10 行
opt.pumblend = 10            -- 补全菜单透明度
opt.fillchars = { eob = " " } -- 隐藏空行前的 "~"

-- 缩进
opt.tabstop = 4              -- Tab 显示为 4 个空格
opt.shiftwidth = 4           -- 自动缩进宽度
opt.softtabstop = 4          -- 插入/删除 Tab 时按 4 个空格处理
opt.expandtab = true         -- 用空格代替 Tab（Makefile 等会被 ftplugin 自动覆盖）

-- 搜索
opt.ignorecase = true        -- 搜索忽略大小写
opt.smartcase = true         -- 含大写字母时区分大小写
opt.inccommand = "split"     -- :s 替换时实时预览

-- 文件与撤销（undodir 使用 Neovim 默认的 stdpath("state")/undo）
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.undofile = true
opt.updatetime = 300         -- 默认 4000ms，缩短后诊断/CursorHold 更及时
opt.timeoutlen = 500         -- 组合键等待时间

-- 补全：配合 vim.lsp.completion（见 plugins/lsp.lua）
opt.autocomplete = false
opt.complete = ".,o,w,b"
opt.completeopt = "menu,menuone,noselect,fuzzy,popup"

-- 折叠：基于 Treesitter，没有解析器的缓冲区不会折叠
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99           -- 启动时展开所有折叠

-- 窗口
opt.splitbelow = true
opt.splitright = true

-- 其他
opt.mouse = "a"
opt.wildmode = "longest:full,full"
opt.diffopt:append("linematch:60")
opt.redrawtime = 10000
opt.maxmempattern = 20000
opt.path:append("**")        -- :find 可搜索子目录

-- 系统剪贴板：延迟设置，避免启动时探测剪贴板程序拖慢启动
vim.schedule(function()
  opt.clipboard:append("unnamedplus")
end)

