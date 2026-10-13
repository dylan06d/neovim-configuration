-- Emacs 风格快捷键
local map = vim.keymap.set

-- 先离开插入模式，再执行命令
local function leave_then(cmd)
  return function()
vim.cmd("stopinsert")
    vim.cmd(cmd)
  end
end

-- 窗口管理（Emacs 风格）
map({ "n", "i" }, "<C-x>2", leave_then("split"), { desc = "水平分屏" })
map({ "n", "i" }, "<C-x>3", leave_then("vsplit"), { desc = "垂直分屏" })
map({ "n", "i" }, "<C-x>c", function()
  vim.cmd("stopinsert")
  pcall(vim.cmd, "close") -- 只剩最后一个窗口时静默忽略
end, { desc = "关闭当前窗口" })

map({ "n", "i" }, "<C-x>4", leave_then("tabnew"), { desc = "新标签页" })
map("n", "gd", "<Cmd>tabnext<CR>", { desc = "下一个标签页" })
map("n", "gD", "<Cmd>tabprevious<CR>", { desc = "上一个标签页" })

-- M-, 对应 Emacs 的 xref-go-back：返回上一个跳转位置
map({ "n", "i" }, "<M-,>", function()
  vim.cmd("stopinsert")
  pcall(vim.cmd, "pop") -- tag 栈为空时静默忽略
end, { desc = "返回跳转前的位置" })

-- 终端
map("t", "<C-k>", [[<C-\><C-n>]], { desc = "终端模式回到普通模式" })

-- C-c + 方向键切换窗口
map({ "n", "i" }, "<C-Left>", "<Cmd>wincmd h<CR>", { desc = "切换到左边窗口" })
map({ "n", "i" }, "<C-Down>", "<Cmd>wincmd j<CR>", { desc = "切换到下边窗口" })
map({ "n", "i" }, "<C-Up>", "<Cmd>wincmd k<CR>", { desc = "切换到上边窗口" })
map({ "n", "i" }, "<C-Right>", "<Cmd>wincmd l<CR>", { desc = "切换到右边窗口" })

-- 文件浏览器 / 保存 / 保存并退出
map("n",  "<leader>fe", leave_then("Ex"), { desc = "打开文件浏览器" })
map({ "n", "i" }, "<C-x><C-s>", leave_then("w"), { desc = "保存文件" })
map({ "n", "i" }, "<C-x><C-k>", leave_then("xa"), { desc = "保存全部并退出" })

-- 撤销（插入模式下使用 <C-o> 不会退出插入模式）
map("n", "<C-z>", "u", { desc = "撤销" })
map("i", "<C-z>", "<C-o>u", { desc = "撤销" })

-- 行首 / 行尾
map({ "n", "v" }, "<C-a>", "^", { desc = "跳到行首" })
map("i", "<C-a>", "<C-o>^", { desc = "跳到行首" })
map({ "n", "v" }, "<C-e>", "$", { desc = "跳到行尾" })
map("i", "<C-e>", "<C-o>$", { desc = "跳到行尾" })

-- 清除搜索高亮
map("n", "<Esc>", "<Cmd>nohlsearch<CR>", { desc = "清除搜索高亮" })

-- 窗口交换模式：按 <C-w> 后接方向键交换窗口
local swap_mode = false

-- 交换当前窗口与指定方向的窗口
local function swap_window(direction)
  local current = vim.api.nvim_get_current_win()

  -- 移动到目标方向的窗口
  if direction == "h" then vim.cmd("wincmd h")
  elseif direction == "j" then vim.cmd("wincmd j")
  elseif direction == "k" then vim.cmd("wincmd k")
  elseif direction == "l" then vim.cmd("wincmd l")
  end

  local target = vim.api.nvim_get_current_win()
  if target ~= current then
    -- 交换两个窗口的缓冲区
    local current_buf = vim.api.nvim_win_get_buf(current)
    local target_buf = vim.api.nvim_win_get_buf(target)
    vim.api.nvim_win_set_buf(current, target_buf)
    vim.api.nvim_win_set_buf(target, current_buf)
    -- 光标回到原窗口
    vim.api.nvim_set_current_win(current)
  end
end

-- 进入交换模式，只监听方向键
vim.keymap.set("n", "<C-w>", function()
  swap_mode = true

  local function do_swap(direction)
    if swap_mode then
      swap_window(direction)
      swap_mode = false
      for _, key in ipairs({ "<Left>", "<Down>", "<Up>", "<Right>" }) do
        pcall(vim.keymap.del, "n", key)
      end
    end
  end

  vim.keymap.set("n", "<Left>", function() do_swap("h") end, { buffer = true })
  vim.keymap.set("n", "<Down>", function() do_swap("j") end, { buffer = true })
  vim.keymap.set("n", "<Up>", function() do_swap("k") end, { buffer = true })
  vim.keymap.set("n", "<Right>", function() do_swap("l") end, { buffer = true })
end, { desc = "窗口交换模式（接方向键）" })

vim.keymap.set("i", "<C-j>", "<Esc>", { desc = "退出插入模式" })
