local replace_file_name = function(str)
	local file_name = vim.fn.expand("%")
	if file_name then
		return string.gsub(str, "%%", file_name)
	end
	return str
end

vim.keymap.set("c", "help", "vert bo help", { noremap = true })
vim.cmd.cabbrev("h", "vert bo h")

vim.keymap.set("n", "<leader>pv", function()
	require("telescope").extensions.file_browser.file_browser({
		path = vim.fn.expand("%:p:h"),
	})
end)

vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/.local/scripts/tmux-sessionizer<CR>")

-- vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

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

--copy all
vim.keymap.set("n", "<leader>yh", ":ma a<CR>:silent %y+<CR>'a")

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

vim.keymap.set("n", "/", "/\\v\\c")
vim.keymap.set("n", "?", "?\\v\\c")

vim.keymap.set("n", "<leader>so", function()
	require("telescope.builtin").lsp_document_symbols({ symbols = "function" })
end, { desc = "[S]earch [O]utline" })

-- VTR bindings
vim.keymap.set("n", "<leader>ja", function()
	vim.cmd("VtrAttachToPane")
end)

vim.keymap.set("n", "<leader>jp", function()
	local buildCommand = replace_file_name(vim.g.VTRBUILD)
	vim.cmd("write")
	if buildCommand then
		vim.cmd("VtrSendCommandToRunner!" .. buildCommand)
	else
		vim.cmd("VtrSendCommandToRunner! zig build")
	end
end)

vim.keymap.set("n", "<leader>jf", function()
	local fileName = vim.fn.expand("%")
	vim.cmd("VtrSendCommandToRunner! zig test " .. fileName)
end)

vim.keymap.set("n", "<leader>jt", function()
	vim.cmd("write")
	vim.cmd("VtrSendCommandToRunner! zig build test --summary all")
end)

vim.keymap.set("n", "<leader>jr", function()
	local runCommand = replace_file_name(vim.g.VTRRUN)
	vim.cmd("write")
	if runCommand then
		vim.cmd("VtrSendCommandToRunner! " .. runCommand)
	else
		vim.cmd("VtrSendCommandToRunner! zig build run")
	end
end)

vim.keymap.set("n", "<leader>jc", function()
	vim.cmd("VtrSendCtrlC")
end)

vim.keymap.set("v", "<leader>jr", function()
	local vstart = vim.fn.getpos("v")
	local vend = vim.fn.getpos(".")

	local temp = vstart[2]
	local start_line = vstart[2]
	local end_line = vend[2]

	if start_line > end_line then
		start_line = end_line
		end_line = temp
	end

	local lines = vim.fn.getline(start_line, end_line)
	if type(lines) == "string" then
		lines = { lines }
	end
	local concat = table.concat(lines, "")
	vim.cmd("VtrSendCommandToRunner! " .. concat)
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
