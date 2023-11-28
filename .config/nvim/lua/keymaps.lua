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

vim.keymap.set("n", "<C-R>", function() require("lazy.core.loader").reload("intellij-new-theme-nvim") end)
vim.keymap.set("n", "gi", vim.cmd.Inspect)
