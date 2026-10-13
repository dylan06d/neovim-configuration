return {
  "akinsho/toggleterm.nvim",
  version = "*",
  cmd = { "ToggleTerm", "TermExec", "TermNew", "TermSelect" },
  keys = {
    {
      "<C-x>t",
      function()
        vim.cmd("stopinsert")
        -- 支持计数：2<C-x>t 打开/关闭 2 号终端
        vim.cmd(vim.v.count1 .. "ToggleTerm")
      end,
      mode = { "n", "i" },
      desc = "切换终端窗口",
    },
  },
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return math.floor(vim.o.columns * 0.4)
      end
    end,
    direction = "horizontal", -- 默认在底部打开
    shade_terminals = false,  -- 主题已开启透明背景，关闭终端自动变暗，避免色块
    start_in_insert = true,
    persist_mode = true,
    close_on_exit = true,
    float_opts = { border = "rounded" },
  },
}
