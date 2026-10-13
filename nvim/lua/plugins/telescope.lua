return {
  "nvim-telescope/telescope.nvim",
  version = "*", -- 官方推荐固定到最新 release tag
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- 原生排序器，大幅提升排序性能（需要 make 和 gcc）
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  keys = {
    { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "查找文件" },
    { "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "全局搜索文本" },
    { "<leader>fw", function() require("telescope.builtin").grep_string() end, desc = "搜索光标处单词" },
    { "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "缓冲区列表" },
    { "<leader>fr", function() require("telescope.builtin").oldfiles() end, desc = "最近打开的文件" },
    { "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "帮助文档" },
    { "<leader>fk", function() require("telescope.builtin").keymaps() end, desc = "快捷键列表" },
    { "<leader>fd", function() require("telescope.builtin").diagnostics() end, desc = "诊断列表" },
    { "<leader>f/", function() require("telescope.builtin").current_buffer_fuzzy_find() end, desc = "当前文件内搜索" },
    { "<leader>f.", function() require("telescope.builtin").resume() end, desc = "恢复上次搜索" },
  },
  config = function()
    require("telescope").setup({
      defaults = {
        file_ignore_patterns = { "^%.git/", "node_modules/", "target/" },
        mappings = {
          i = {
            ["<C-h>"] = "which_key", -- 默认的 <C-/> 在很多终端里按不出来
          },
        },
      },
      pickers = {
        find_files = { hidden = true }, -- 显示隐藏文件（.git 已被上面的规则忽略）
      },
    })

    pcall(require("telescope").load_extension, "fzf")
  end,
}
