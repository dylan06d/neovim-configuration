-- 由 lazy.nvim 统一管理（原 vim.pack + packages/ 目录已合并到这里）
-- 需要 Neovim 0.11+
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      vim.diagnostic.config({
        severity_sort = true,
        virtual_text = { spacing = 2, prefix = "●" },
        float = { border = "rounded" },
      })

      -- 单个服务器的自定义设置
      vim.lsp.config("clangd", {
        cmd = { "clangd", "--background-index", "--clang-tidy" },
      })

      require("mason-lspconfig").setup({
        ensure_installed = {
          "clangd",        -- C / C++
          "rust_analyzer", -- Rust
        },
        automatic_enable = true,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("user_lsp", { clear = true }),
        callback = function(ev)
            local client = vim.lsp.get_client_by_id(ev.data.client_id)

            -- 补全触发交给 'autocomplete'，LSP 作为 'complete' 里的 "o" 来源；
            -- 这里仍调用 enable，是为了保留 LSP 补全项确认后的 snippet 展开、自动导入等处理
            if client and client:supports_method("textDocument/completion") then
                vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
                vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
            end

          local function map(lhs, rhs, desc)
              vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, desc = desc })
          end
          vim.keymap.set({ "n", "i" }, "<M-.>", function()
              vim.cmd("stopinsert")
              vim.lsp.buf.definition()
          end, { buffer = ev.buf, desc = "跳转到定义" })
          map("<leader>cf", function() vim.lsp.buf.format({ async = true }) end, "格式化")
          map("<leader>e", vim.diagnostic.open_float, "显示诊断")
        end,
      })
    end,
  },
}
