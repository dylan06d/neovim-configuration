return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  event = "VeryLazy",
  config = function()
    local mc = require("multicursor-nvim")
    mc.setup()

    local function set(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { desc = desc })
    end

    -- 在主光标上方/下方添加或跳过光标
    set({ "n", "x" }, "<C-up>", function() mc.lineAddCursor(-1) end, "向上添加光标")
    set({ "n", "x" }, "<C-down>", function() mc.lineAddCursor(1) end, "向下添加光标")
    set({ "n", "x" }, "<leader><up>", function() mc.lineSkipCursor(-1) end, "向上跳过一行")
    set({ "n", "x" }, "<leader><down>", function() mc.lineSkipCursor(1) end, "向下跳过一行")

    -- 匹配光标下的单词/选区，添加或跳过光标
    set({ "n", "x" }, "<leader>n", function() mc.matchAddCursor(1) end, "为下一个匹配添加光标")
    set({ "n", "x" }, "<leader>s", function() mc.matchSkipCursor(1) end, "跳过下一个匹配")
    set({ "n", "x" }, "<leader>N", function() mc.matchAddCursor(-1) end, "为上一个匹配添加光标")
    set({ "n", "x" }, "<leader>S", function() mc.matchSkipCursor(-1) end, "跳过上一个匹配")
    set({ "n", "x" }, "<leader>A", mc.matchAllAddCursors, "为所有匹配添加光标")

    -- 光标操作符：gaip 为段落每一行添加光标
    set({ "n", "x" }, "ga", mc.addCursorOperator, "按范围添加光标")

    -- 可视模式：对选中的每一行插入/追加（类似块选择插入）
    set("x", "I", mc.insertVisual, "每行行首插入")
    set("x", "A", mc.appendVisual, "每行行尾追加")

    -- Ctrl + 鼠标左键 添加/移除光标
    set("n", "<c-leftmouse>", mc.handleMouse)
    set("n", "<c-leftdrag>", mc.handleMouseDrag)
    set("n", "<c-leftrelease>", mc.handleMouseRelease)

    -- 暂停/恢复光标
    set({ "n", "x" }, "<c-q>", mc.toggleCursor, "暂停/恢复多光标")

    -- 键映射层：只有存在多个光标时才生效，可以和普通映射重叠
    mc.addKeymapLayer(function(layerSet)
      -- 切换主光标
      layerSet({ "n", "x" }, "<left>", mc.prevCursor)
      layerSet({ "n", "x" }, "<right>", mc.nextCursor)

      -- 删除主光标
      layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)

      -- Esc：先恢复被暂停的光标，再按一次清除所有光标
      layerSet("n", "<esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        else
          mc.clearCursors()
        end
      end)
    end)

    -- 光标外观
    local hl = vim.api.nvim_set_hl
    hl(0, "MultiCursorCursor", { reverse = true })
    hl(0, "MultiCursorVisual", { link = "Visual" })
    hl(0, "MultiCursorSign", { link = "SignColumn" })
    hl(0, "MultiCursorMatchPreview", { link = "Search" })
    hl(0, "MultiCursorDisabledCursor", { reverse = true })
    hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
  end,
}
