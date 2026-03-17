return {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/local-lua-debugger-vscode/extension/debugAdapter.js" },
}
