vim.opt.completeopt = { "menu", "menuone", "noselect" }

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local client_id = event.data and event.data.client_id
    if not client_id then
      return
    end

    vim.lsp.completion.enable(true, client_id, event.buf, {
      autotrigger = true,
    })
  end,
})

-- Mason 本体设置
require("mason").setup()

-- Mason-LSPconfig：安装并自动启用 LSP 服务器
require("mason-lspconfig").setup({
  ensure_installed = {
    "clangd",       -- C / C++
    "rust_analyzer", -- Rust
  },
  automatic_enable = true,
})
