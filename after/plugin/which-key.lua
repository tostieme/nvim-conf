local wk = require("which-key")

wk.add({
    { "<leader>s",  desc = "Replace string" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
    { "<leader>fs", desc = "Grep files",             mode = "n" },
    {
        "<leader>x",
        group = "Trouble",
        mode = "n",
        { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Diagnostics", },
        { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics", },
        { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                  desc = "Location List", },
        { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                   desc = "Quickfix List", },
    },
    {
        "<leader>g",
        group = "Goto Preview",
        mode = "n",
        { "<leader>gd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",      desc = "Preview Definition" },
        { "<leader>gr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>",      desc = "Preview References" },
        { "<leader>gt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", desc = "Preview Type Definition" },
        { "<leader>gi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",  desc = "Preview Implementation" },
        { "<leader>gD", "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>",     desc = "Preview Declaration" },
        { "<leader>gP", "<cmd>lua require('goto-preview').close_all_win()<CR>",                desc = "Close All Previews" },
    },

})
