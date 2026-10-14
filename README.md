# Neovim 配置

需要 **Neovim 0.11+**（`nvim --version` 检查）。

## 依赖
fedora:
```bash
sudo dnf install neovim git gcc make tree-sitter-cli ripgrep fd-find
```
debian:
```bash
sudo apt update
sudo apt install git gcc make ripgrep fd-find
curl -fLO "https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-x64.gz"
gunzip -f tree-sitter-linux-x64.gz
chmod +x tree-sitter-linux-x64
sudo mv tree-sitter-linux-x64 /usr/local/bin/tree-sitter
```
`tree-sitter-cli` 与 `gcc` 用于编译 Treesitter 解析器（nvim-treesitter `main` 分支必需）。

## 安装
```bash
git clone <本仓库> ~/.config/nvim
nvim   # 首次启动会自动安装插件
```

## 结构
```
init.lua                  入口（先设置 leader）
lua/config/options.lua    编辑器选项
lua/config/keybinds.lua   快捷键
lua/config/autocmds.lua   自动命令
lua/config/lazy.lua       lazy.nvim 引导
lua/plugins/theme.lua     主题：github-nvim-theme（github_dark_high_contrast，透明背景）
lua/plugins/treesitter.lua  Treesitter；新增语言请修改 install 列表
lua/plugins/lsp.lua       LSP：mason + 原生补全；新增服务器请改 ensure_installed
lua/plugins/telescope.lua 搜索插件
lua/plugins/toggleteerm.lua 终端工具
lua/plugins/whichkey.lua   查看快捷键
lua/plugins/neotree.lua    文件树
lua/plugins/autopairs.lua  自动补全成对的符号
lua/plugins/gitsigns.lua   把git状态直接集成到编辑器缓冲区
lua/plugins/rendermd.lua    Neovim 中 Markdown 的显示效果
lua/plugins/betterescape.lua    设置按键映射
lua/plugins/multicursor.lua    多光标
```

## 快捷键
| 按键 | 功能 |
|---|---|
| `C-x C-f` | 打开neo文件浏览器 |
| `C-x C-s` | 保存 |
| `C-x C-k` | 保存全部并退出 |
| `C-x 2` | 水平分屏 |
| `C-x 3` | 垂直分屏 |
| `C-x 4` | 新标签页 |
| `C-x c` | 关闭当前窗口 |
| `C-x t` | 打开终端 |
| `C-k` | 终端回到普通模式 |
| `C-方向` | 切换光标到对应方向的窗口 |
| `C-w 方向` | 交换对应方向的窗口 |
| `C-S-方向` | 改变窗口大小 |
| `C-z` | 撤销 |
| `C-a` / `C-e` | 行首 / 行尾 |
| `gd` | 下一个标签页 |
| `gD` | 上一个标签页 |
| `jk` | 退出插入模式 |
| `M-.` | 跳转到标签页（LSP） |
| `M-,` | 返回跳转前的位置（LSP） |
| `]h` | 下一个改动块 |
| `[h` | 上一个改动块 |
| `<leafer>fe` | 打开neovim自带的文件浏览器 |
| `<leader>cf` | 格式化（LSP） |
| `<leader>e` | 显示诊断 |
| `<leader>ff` | 查找文件 |
| `<leader>fg` | 全局搜索文本 |
| `<leader>fw` | 搜索光标处单词 |
| `<leader>fb` | 缓冲区列表 |
| `<leader>fr` | 最近文件 |
| `<leader>fh` | 帮助文档 |
| `<leader>fk` | 快捷键列表 |
| `<leader>fd` | 诊断列表 |
| `<leader>f/` | 当前文件内搜索 |
| `<leader>f.` | 恢复上次搜索 |
| `<leader>gs` | 浮动窗口显示git status |
| `<leader>hs` | 暂存/取消暂存改动块（可视模式下作用于选中的行） |
| `<leader>hr` | 还原改动块（可视模式作用于选中行） |
| `<leader>hp` | 预览改动块 |
| `<leader>hb` | 显示当前行完整的blame |
| `<leader>hB` | 开关行尾blame提示 |
| `<leader>hd` | 与索引对比（diff） |

|multicursor | 多光标快捷键 |
|---|---|
| `↑` | 向上添加光标（普通、可视模式） |
| '↓' | 向下添加光标 （普通、可视模式） |
| `<leader>↑ / <leader>↓` | 向上 / 向下跳过一行 |
| `<leader>n / <leader>N` |	为下一个 / 上一个匹配添加光标 |
| `<leader>s / <leader>S` |	跳过下一个 / 上一个匹配 |
| `<leader>A` |	为文件中所有匹配添加光标 |
| `ga + 范围` |	按范围添加光标（如 gaip） |
| `I / A（可视模式）` |	每行行首插入 / 行尾追加 |
| `Ctrl + 鼠标左键` | 添加 / 移除光标 |
| `C-q` | 暂停 / 恢复多光标 |
| `← / →（多光标时）` |	切换主光标 |
| `<leader>x（多光标时）` |	删除主光标 |
| `Esc（多光标时）` | 恢复暂停的光标，再按一次清除所有光标 |
补全菜单：`C-n`/`C-p` 选择，`C-y` 确认。
