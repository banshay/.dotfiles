return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			["*"] = {
				keys = {
					{
						"gr",
						function()
							require("telescope.builtin").lsp_references()
						end,
						desc = "Lsp References",
					},

					{
						"<leader>ca",
						function()
							LazyVim.lsp.action.source()
						end,
						desc = "Source Action",
						has = "codeAction",
					},
					{ "<leader>ca", false, mode = "x" },
					{
						"<leader>cA",
						vim.lsp.buf.code_action,
						desc = "Code Action",
						mode = { "n", "x" },
						has = "codeAction",
					},
				},
			},
			zls = {
				settings = {
					zls = {
						inlay_hints_show_builtin = false,
						inlay_hints_show_parameter_name = true,
						inlay_hints_hide_redundant_param_names = true,
						inlay_hints_hide_redundant_param_names_last_token = true,
						inlay_hints_show_variable_type_hints = false,
						inlay_hints_show_struct_literal_field_type = false,
					},
				},
			},
		},
	},
}
