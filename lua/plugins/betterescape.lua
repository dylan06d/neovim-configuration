return {
    { 
        "max397574/better-escape.nvim", 
        opts = {
            timeout = 200,
            default_mappings = false,
            mappings =  {
                i = {
                    f = {
                        f = "<Esc>",
                    },
                    s = {
                        s = function()
                            vim.api.nvim_input("<Esc>")
                            vim.cmd("write")
                        end,
                    },
                },
            },
        },
    },
}
