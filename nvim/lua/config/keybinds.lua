-- 打开文件浏览器
vim.keymap.set({"n", "i", "v"}, "<C-x><C-f>", function()
  if vim.fn.mode() ~= "n" then
    vim.cmd("stopinsert")
  end
  vim.cmd("Ex")
end, { desc = "打开文件浏览器" })

-- 撤销
vim.keymap.set("n", "<C-z>", "u", { desc = "撤销" })
vim.keymap.set("i", "<C-z>", "<Esc>u", { desc = "撤销" })

-- 保存
vim.keymap.set({"n", "i"}, "<C-x><C-s>", function()
  if vim.fn.mode() ~= "n" then
    vim.cmd("stopinsert")
  end
  vim.cmd("w")
end, { desc = "保存文件" })

-- 保存并退出
vim.keymap.set({"n", "i"}, "<C-x><C-c>", function()
  if vim.fn.mode() ~= "n" then
    vim.cmd("stopinsert")
  end
  vim.cmd("x")
end, { desc = "保存并退出" })

-- 行首
vim.keymap.set({"n", "v"}, "<C-a>", "^", { desc = "跳到行首" })
vim.keymap.set("i", "<C-a>", "<Esc>^i", { desc = "跳到行首" })

-- 行尾
vim.keymap.set({"n", "v"}, "<C-e>", "$", { desc = "跳到行尾" })
vim.keymap.set("i", "<C-e>", "<Esc>$a", { desc = "跳到行尾" })
