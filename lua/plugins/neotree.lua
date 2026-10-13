return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  lazy = false, -- neo-tree 自己会懒加载
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    -- 如果安装了 Nerd Font，可以加上文件图标：
    -- "nvim-tree/nvim-web-devicons",
  },
  keys = {
    {
      "<C-x><C-f>",
      function()
        vim.cmd("stopinsert")
        vim.cmd("Neotree toggle reveal") -- 切换侧边栏，并定位到当前文件
      end,
      mode = { "n", "i", "v" },
      desc = "文件树",
    },
    { "<leader>gs", "<Cmd>Neotree float git_status<CR>", desc = "Git 状态" },
  },
  opts = {
    close_if_last_window = true, -- 只剩文件树时自动退出
    popup_border_style = "rounded",
    -- 默认图标需要 Nerd Font，这里换成纯文本；装了 Nerd Font 可删掉整个 default_component_configs
    default_component_configs = {
      icon = {
        folder_closed = "+",
        folder_open = "-",
        folder_empty = "·",
        default = "*",
      },
      git_status = {
        symbols = {
          added = "A", modified = "M", deleted = "D", renamed = "R",
          untracked = "?", ignored = "!", unstaged = "U", staged = "S", conflict = "C",
        },
      },
    },
    window = {
      width = 32,
      mappings = {
        ["<space>"] = "none", -- 让出 <space>，避免和 leader 冲突
      },
    },
    filesystem = {
      follow_current_file = { enabled = true }, -- 自动跟随当前文件
      use_libuv_file_watcher = true,            -- 文件变化时自动刷新
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = true,
      },
    },
  },
}
