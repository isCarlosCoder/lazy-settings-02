local dap = require("dap")

dap.adapters.node2 = {
	type = "executable",
	command = "node",
	args = {
		vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js",
	},
}

dap.configurations.javascript = {
	{
		type = "node2",
		request = "launch",
		name = "Launch file",
		cwd = vim.fn.getcwd(),
		program = "${file}",
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
	},
}
