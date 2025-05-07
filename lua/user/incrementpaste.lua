local increment_value = 0
local increment_history = {}
local original_template = ""

function copy_value()
	local selection = vim.fn.getreg('"')
	local num = string.match(selection, "%d+")
	local value = num and tonumber(num) or 0

	local increment = vim.fn.input("Increment by how much? (current value: " .. value .. "): ")
	increment = tonumber(increment) or 100

	increment_value = value
	increment_history = { increment }
	original_template = selection

	vim.api.nvim_set_var("increment_value", increment_value)
	vim.api.nvim_set_var("increment_history", increment_history)
	vim.api.nvim_set_var("original_template", original_template)

	print("Copied value: " .. increment_value .. " with increment of " .. increment)
end

function paste_incremented_value()
	if increment_value == 0 or original_template == "" then
		print("No value copied to increment")
		return
	end

	local count = vim.v.count
	if count == 0 then
		count = 1
	end

	for _ = 1, count do
		increment_value = increment_value + increment_history[#increment_history]
		local updated = original_template:gsub("%d+", tostring(increment_value), 1)
		vim.fn.setreg('"', updated)
		vim.cmd('normal! ""p')
	end

	print("Pasted " .. count .. "x, last value: " .. increment_value)
end

function clear_increment()
	increment_value = 0
	increment_history = {}
	original_template = ""
	vim.api.nvim_set_var("increment_value", increment_value)
	vim.api.nvim_set_var("increment_history", increment_history)
	vim.api.nvim_set_var("original_template", original_template)

	print("History and increment cleared!")
end

vim.api.nvim_set_keymap("n", "<leader>p", "", { noremap = true, silent = true, desc = "Super copy and paste" })

vim.api.nvim_set_keymap(
	"n",
	"<leader>pcc",
	":lua copy_value()<CR>",
	{ noremap = true, silent = true, desc = "Copy value to paste incrementing" }
)

vim.keymap.set(
	"n",
	"<leader>pp",
	paste_incremented_value,
	{ noremap = true, silent = true, desc = "Paste the copied value incrementing the number with the typed value" }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>pcl",
	":lua clear_increment()<CR>",
	{ noremap = true, silent = true, desc = "Clear the copied value to paste incrementing" }
)
