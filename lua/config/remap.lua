vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- Normal and Insert mode mappings
local opts = { noremap = true, silent = true }

-- NvimTreeToogle
vim.keymap.set("n", "<leader>e", "<cmd>:NvimTreeToggle<CR>")

-- Oil Hotkey
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Create new panes
-- vim.keymap.set("n", "<leader>h","<cmd>:split<CR>")
-- vim.keymap.set("n", "<leader>v", "<cmd>:vsplit<CR>")
vim.keymap.set("n", "<leader><Down>", "<cmd>:split<CR>")
vim.keymap.set("n", "<leader><Right>", "<cmd>:vsplit<CR>")
vim.keymap.set("n", "<leader>q", "<cmd>:q<CR>")

-- Resize Windows
vim.keymap.set("n", "<leader>h", "<cmd>:vertical resize +5<CR>")
vim.keymap.set("n", "<leader>l", "<cmd>:vertical resize -5<CR>")
vim.keymap.set("n", "<leader>k", "<cmd>:resize -5<CR>")
vim.keymap.set("n", "<leader>j", "<cmd>:resize +5<CR>")

-- Indent in visual mode but stay in visual mode
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Format File
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>sx", "<cmd>!chmod +x %<CR>", { silent = true })

-- go to definition
vim.keymap.set("n", "gd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>")
vim.keymap.set("n", "gr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>")
vim.keymap.set("n", "gt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>")
vim.keymap.set("n", "gi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
vim.keymap.set("n", "gD", "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>")
vim.keymap.set("n", "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>")
--
-- Promote preview window to full buffer with cursor position preserved
vim.keymap.set('n', '<leader>pp', function()
    -- Look for preview windows
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local config = vim.api.nvim_win_get_config(win)
        -- Check if it's a floating window (preview) or has preview option set
        if config.relative ~= '' or vim.wo[win].previewwindow then
            local preview_buf = vim.api.nvim_win_get_buf(win)

            -- Get cursor position from preview window
            local cursor_pos = vim.api.nvim_win_get_cursor(win)

            -- Close the preview window
            vim.api.nvim_win_close(win, false)

            -- Open the preview buffer in the current window
            vim.api.nvim_set_current_buf(preview_buf)

            -- Restore cursor position (using current window, not the closed one)
            vim.api.nvim_win_set_cursor(0, cursor_pos)
            break
        end
    end
end, { desc = "Promote preview window to current buffer with cursor position" })


-- vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
-- vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")


-- Define the autocmd using vim.api.nvim_create_autocmd
vim.api.nvim_create_autocmd("BufNewFile", {
    desc = "Write Bash header when opening new .sh file",
    group = aug,
    pattern = "*.sh",
    callback = function(params)
        local header_lines = {
            '#!/bin/bash',
        }
        vim.api.nvim_buf_set_lines(0, 0, 0, false, header_lines)
    end,
})

--- Run go.fmt and go.import when saving
local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        require('go.format').goimports()
    end,
    group = format_sync_grp
})

-- Run :AddGoTags
vim.keymap.set("v", "<leader>at", ":AddGoTags<CR>", { desc = "Add Go struct tags", silent = true })
vim.keymap.set("v", "<leader>rt", ":RemoveGoTags<CR>", { desc = "Remove Go struct tags", silent = true })
