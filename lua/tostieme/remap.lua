vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- NvimTreeToogle
vim.keymap.set("n", "<leader>e", "<cmd>:NvimTreeToggle<CR>")

-- Oil Hotkey
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- Create new panes
vim.keymap.set("n", "<leader><Down>","<cmd>:split<CR>")
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

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- go to definition
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")

-- Define the autocmd using vim.api.nvim_create_autocmd
vim.api.nvim_create_autocmd("BufNewFile", {
  desc = "Bash Header when opening new .sh file",
  group = aug,
  pattern = "*.sh",
  callback = function(params)
    local header_lines = {
      '#!/bin/bash',
    }
    vim.api.nvim_buf_set_lines(0, 0, 0, false, header_lines)
  end,
})

-- Run go.fmt and go.import when saving
local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimports()
  end,
  group = format_sync_grp,
})

-- Run :GoIfErr in normale and insert mode
vim.keymap.set({"n", "i"}, "<C-s>", "<cmd>:GoIfErr<CR>")

-- Keymaps for mardown preview
vim.keymap.set("n", "md", "<cmd>:MarkdownPreview<CR>")
vim.keymap.set("n", "mds", "<cmd>:MarkdownPreviewStop<CR>")
vim.keymap.set("n", "ftmd", "<cmd>:set filetype=markdown<CR>")

-- Keymap for error floating window
vim.keymap.set("n", "<leader>de", "<cmd>:lua vim.diagnostic.open_float()<CR>")

-- Keymap for getting current filepath
vim.keymap.set("n", "fp", "<cmd>:let @+=@%<CR>")

