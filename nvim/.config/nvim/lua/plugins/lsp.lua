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
