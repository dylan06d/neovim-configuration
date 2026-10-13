# NEOVIM configuration

## 安装neovim
```bash
sudo dnf install neovim
```

## 配置
- [使用的主题](https://github.com/projekt0n/github-nvim-theme)
```lua
-- ~/.config/nvim/lua/plugins/theme.lua
vim.cmd('colorscheme github_dark_dimmed')  -- 改成你想要的主题名
```

- [treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
如果要添加语言`nvim ~/.config/nvim/lua/plugins/treesitter.lua`
