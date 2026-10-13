return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    current_line_blame = false, -- 需要时用 <leader>hB 开关
    current_line_blame_opts = { delay = 500 },
    on_attach = function(bufnr)
      local gs = require("gitsigns")

      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
      end

      -- 在改动块（hunk）之间跳转
      map("n", "]h", function() gs.nav_hunk("next") end, "下一个改动块")
      map("n", "[h", function() gs.nav_hunk("prev") end, "上一个改动块")

      -- 暂存 / 还原（可视模式下作用于选中的行）
      map("n", "<leader>hs", gs.stage_hunk, "暂存/取消暂存改动块")
      map("n", "<leader>hr", gs.reset_hunk, "还原改动块")
      map("v", "<leader>hs", function()
        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "暂存选中的行")
      map("v", "<leader>hr", function()
        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "还原选中的行")

      -- 查看
      map("n", "<leader>hp", gs.preview_hunk, "预览改动块")
      map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "当前行 blame")
      map("n", "<leader>hB", gs.toggle_current_line_blame, "开关行尾 blame")
      map("n", "<leader>hd", gs.diffthis, "与索引对比")
    end,
  },
}
