return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    -- 异步安装解析器，已安装的会自动跳过（需要 tree-sitter-cli 和 C 编译器）
    require("nvim-treesitter").install({
      "bash", "c", "cpp", "rust", "cmake", "make", "toml",
      "diff", "html", "javascript", "json", "yaml",
      "lua", "luadoc", "vim", "vimdoc", "query",
      "markdown", "markdown_inline",
    })

    -- 有对应解析器时启用 Treesitter 高亮
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if lang then
          pcall(vim.treesitter.start, args.buf, lang)
          -- 可选：Treesitter 缩进（实验性）
          -- vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
