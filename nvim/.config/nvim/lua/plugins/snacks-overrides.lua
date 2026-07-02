_G.LazygitEdit = function(path)
	for _, w in ipairs(vim.api.nvim_list_wins()) do
		if vim.bo[vim.api.nvim_win_get_buf(w)].filetype == "snacks_terminal" then
			pcall(vim.api.nvim_win_close, w, true)
		end
	end
	vim.cmd.edit(vim.fn.fnameescape(path))
end

_G.LazygitEditLine = function(path, line)
	LazygitEdit(path)
	pcall(vim.api.nvim_win_set_cursor, 0, { tonumber(line) or 1, 0 })
end

return {
	"folke/snacks.nvim",
	opts = {
		scroll = {
			enabled = false, -- Disable scrolling animations
		},
		notifier = {
			timeout = 10000,
		},
		dashboard = {
			enabled = false,
		},
		words = {
			enabled = false,
		},
		picker = {
			enabled = false,
		},
		lazygit = {
			configure = true,
			config = {
				os = {
					editPreset = "nvim-remote",
					edit = 'nvim --server "$NVIM" --remote-expr "v:lua.LazygitEdit(\'{{filename}}\')"',
					editAtLine = 'nvim --server "$NVIM" --remote-expr "v:lua.LazygitEditLine(\'{{filename}}\', {{line}})"',
				},
			},
		},
	},
}
