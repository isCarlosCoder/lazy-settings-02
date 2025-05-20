local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "x", '"_x')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save file and quit
keymap.set("n", "<Leader>w", ":update<Return>", opts)
keymap.set("n", "<Leader>q", ":quit<Return>", opts)
keymap.set("n", "<Leader>Q", ":qa<Return>", opts)

-- Tabs
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
keymap.set("n", "tw", ":tabclose<Return>", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-h>", "<C-w><")
keymap.set("n", "<C-l>", "<C-w>>")
keymap.set("n", "<C-k>", "<C-w>+")
keymap.set("n", "<C-j>", "<C-w>-")

-- Diagnostics
-- keymap.set("n", "<C-j>", function()
--	vim.diagnostic.goto_next()
-- end, opts)

-- fasts
for i = string.byte("a"), string.byte("z") do
	local letter = string.char(i)
	keymap.set("n", "gm" .. letter, "`" .. letter, opts)
	keymap.set("n", "mm" .. letter, ":delmarks " .. letter .. "<Return>", opts)
end

-- lsp
local function customOpts(desc)
	return {
		noremap = true,
		silent = true,
		desc = desc,
	}
end

keymap.set("n", "<leader>ck", vim.lsp.buf.hover, customOpts("Hover"))
keymap.set("n", "<leader>cj", vim.lsp.buf.definition, customOpts("Go to definition"))
keymap.set("n", "<leader>cJ", vim.lsp.buf.declaration, customOpts("Go to declaration"))
keymap.set("n", "<leader>cr", vim.lsp.buf.rename, customOpts("Rename variable"))

-- Debug - DAP
keymap.set("n", "<leader>db", function()
	require("dap").toggle_breakpoint()
end, customOpts("Toggle Breakpoint"))

keymap.set("n", "<leader>dB", function()
	require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, customOpts("Toggle Breakpoint"))

keymap.set("n", "<leader>dc", function()
	require("dap").continue()
end, customOpts("Continue"))

keymap.set("n", "<leader>do", function()
	require("dap").step_over()
end, customOpts("Step over"))

keymap.set("n", "<leader>di", function()
	require("dap").step_into()
end, customOpts("Step into"))

keymap.set("n", "<leader>df", function()
	require("dap").step_out()
end, customOpts("Step out"))

keymap.set("n", "<leader>da", function()
	require("dapui").toggle()
end, customOpts("DAPUI toggle"))

keymap.set("n", "<leader>dr", function()
	require("dap").repl.open()
end, customOpts("Open DAP REPL"))

keymap.set("n", "<leader>dl", function()
	require("dap").run_last()
end, customOpts("Run last debug"))

keymap.set("n", "<leader>dq", function()
	require("dap").terminate()
end, customOpts("Terminate debug"))

keymap.set("n", "<leader>dh", function()
	require("dap.ui.widgets").hover()
end, customOpts("Hover over variable"))

keymap.set("n", "<leader>dC", function()
	require("dap").clear_breakpoints()
end, customOpts("Clear all breakpoints"))
