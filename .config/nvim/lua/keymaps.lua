vim.keymap.set("n", "<leader>pv", function () 
  require "telescope".extensions.file_browser.file_browser({
    path = vim.fn.expand("%:p:h")
  })
end)

vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/.local/scripts/tmux-sessionizer<CR>")

vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

vim.keymap.set("n", "<leader>w", vim.cmd.write)

vim.keymap.set("n", "gl", vim.lsp.buf.format)

vim.keymap.set("n", "<C-S-r>", function() require("lazy.core.loader").reload("intellij-new-theme-nvim") end)
vim.keymap.set("n", "gi", vim.cmd.Inspect)

vim.keymap.set("n", "<leader>o", 'o<Esc>0"_D')
vim.keymap.set("n", "<leader>O", 'O<Esc>0"_D')

vim.keymap.set("n", "<a-j>" ,":m .+1<CR>")
vim.keymap.set("n", "<a-k>" ,":m .-2<CR>")
vim.keymap.set("v", "<J>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<K>", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>y",'\"+y')
vim.keymap.set("v", "<leader>y", '\"+y')
vim.keymap.set("n", "<leader>Y", '\"+Y')

vim.keymap.set("o", "F", "vF")
vim.keymap.set("o", "T", "vT")

vim.keymap.set("n", '<LEADER>ci"', 'ci"<C-r>"')
vim.keymap.set("n", "<LEADER>ci(", 'ci(<C-r>"')

vim.keymap.set("n", "ff", "<C-v>")

vim.keymap.set("n", "<C-W>c", "<C-W>q")
