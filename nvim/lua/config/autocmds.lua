local group = vim.api.nvim_create_augroup("user_config", { clear = true })

-- 复制时短暂高亮
vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

-- 打开文件时回到上次光标位置
vim.api.nvim_create_autocmd("BufReadPost", {
  group = group,
  callback = function(ev)
    local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(ev.buf) then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- autoread 在 Neovim 中需要 checktime 触发，才能感知外部修改
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  group = group,
  command = "silent! checktime",
})

-- 输入满 MIN_CHARS 个字符后才自动弹出补全（需要 Neovim 0.12 的 'autocomplete'）
local MIN_CHARS = 2
local excluded_ft = { TelescopePrompt = true, ["neo-tree-popup"] = true }

-- 成员访问才立即触发：.  ->  ::
local function is_member_trigger(char, before)
  return char == "."
    or (char == ">" and before:sub(-1) == "-")
    or (char == ":" and before:sub(-1) == ":")
end

-- 进入插入模式时先关掉，避免退格等不经过 InsertCharPre 的按键触发
vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
  group = group,
  callback = function()
    vim.o.autocomplete = false
  end,
})

vim.api.nvim_create_autocmd("InsertCharPre", {
  group = group,
  callback = function()
    if vim.bo.buftype == "prompt" or excluded_ft[vim.bo.filetype] then
      vim.o.autocomplete = false
      return
    end

    local char = vim.v.char
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local before = vim.api.nvim_get_current_line():sub(1, col)

    if is_member_trigger(char, before) then
      vim.o.autocomplete = true
      return
    end

    -- 非单词字符（含空格）一律不触发；单词字符要求总长度达到 MIN_CHARS
    if vim.fn.match(char, [[^\k$]]) ~= 0 then
      vim.o.autocomplete = false
      return
    end
    local word = vim.fn.matchstr(before, [[\k*$]])
    vim.o.autocomplete = vim.fn.strchars(word) + 1 >= MIN_CHARS
  end,
})
