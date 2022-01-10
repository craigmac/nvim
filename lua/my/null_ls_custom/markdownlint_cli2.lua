local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")

return {
	name = "markdownlint-cli2",
	method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
	filetypes = { "markdown", "liquid" },
	generator = helpers.generator_factory({
		command = "markdownlint-cli2",
		args = { "$FILENAME" },
		to_stdin = false,
		from_stderr = true,
		format = "line",
		check_exit_code = { 0, 1, 2 },
		on_output = helpers.diagnostics.from_patterns({
			{
				pattern = [[:(%d+):(%d+) ([%w-/]+) (.*)]],
				groups = { "row", "col", "code", "message" },
			},
			{
				pattern = [[:(%d+) ([%w-/]+) (.*)]],
				groups = { "row", "code", "message" },
			},
		}),
	}),
}
