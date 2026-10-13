return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",

    config = function()
      -- 使用默认设置；可以省略 setup()，这里显式指定安装目录
      require("nvim-treesitter").setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      -- 安装需要的语法解析器
      require("nvim-treesitter").install({
        "bash",
        "c",
		"cpp",
        "diff",
        "html",
        "javascript",
        "json",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "query",
        "vim",
        "vimdoc",
        "yaml",
      })

      -- 开启 Neovim 内置的 Treesitter 语法高亮
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local filetype = args.match

          -- 已安装对应解析器时才启动 Treesitter
          local lang = vim.treesitter.language.get_lang(filetype)
          if lang and pcall(vim.treesitter.start, args.buf, lang) then
            -- 可选：让缩进也使用 Treesitter
            -- vim.bo[args.buf].indentexpr =
            --   "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}

