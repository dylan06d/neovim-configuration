return {
  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false,
    priority = 1000,
    config = function()
      require('github-theme').setup({
        -- 你的配置项
		options = {
			transparent = true,  -- 开启透明背景
		}
      })
      vim.cmd('colorscheme github_dark_high_contrast')
    end,
  },
}
