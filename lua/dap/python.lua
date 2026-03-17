return {
	type = "executable",
	command = vim.g.python_path(),
	args = { "-m", "debugpy.adapter" },
}
