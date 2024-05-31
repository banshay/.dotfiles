vim.keymap.set("n", "<leader>pv", function()
	require("telescope").extensions.file_browser.file_browser({
		path = vim.fn.expand("%:p:h"),
	})
end)

vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/.local/scripts/tmux-sessionizer<CR>")

vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

vim.keymap.set("n", "<leader>w", vim.cmd.write)

vim.keymap.set("n", "gl", vim.lsp.buf.format)

vim.keymap.set("n", "<C-S-r>", function()
	require("lazy.core.loader").reload("intellij-new-theme-nvim")
end)
vim.keymap.set("n", "gi", vim.cmd.Inspect)

vim.keymap.set("n", "<leader>o", 'o<Esc>0"_D')
vim.keymap.set("n", "<leader>O", 'O<Esc>0"_D')

vim.keymap.set("n", "<a-j>", ":m .+1<CR>")
vim.keymap.set("n", "<a-k>", ":m .-2<CR>")
vim.keymap.set("v", "<J>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<K>", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

vim.keymap.set("o", "F", "vF")
vim.keymap.set("o", "T", "vT")

vim.keymap.set("n", '<LEADER>ci"', 'ci"<C-r>"')
vim.keymap.set("n", "<LEADER>ci(", 'ci(<C-r>"')

vim.keymap.set("n", "ff", "<C-v>")

vim.keymap.set("n", "<C-W>c", "<C-W>q")

vim.keymap.set("n", "<leader>[", ":Ex<CR>j<CR>")
vim.keymap.set("n", "<leader>]", ":Ex<CR>k<CR>")

vim.keymap.set("n", "<C-p>", function()
	vim.cmd("VtrSendCommandToRunner! zig build")
end)

local function open_next_file()
	-- Get the current file name
	local current_file = vim.fn.expand("%:t")

	-- Extract the current file number
	local current_number = tonumber(current_file:match("^(%d%d%d)"))
	if not current_number then
		print("Current file does not start with a three-digit number.")
		return
	end

	-- Increment the file number
	local next_number = string.format("%03d", current_number + 1)

	-- Build the pattern for the next file
	local next_file_pattern = "exercises/" .. next_number .. "_*.zig"

	-- Find the next file
	local next_file = vim.fn.glob(next_file_pattern)
	if next_file == "" then
		print("Next file not found.")
		return
	end

	-- Open the next file
	vim.cmd("edit " .. next_file)
end

-- Create a keybind for the function
vim.keymap.set("n", "<leader>n", function()
	open_next_file()
end)
