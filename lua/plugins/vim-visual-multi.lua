return {
	"mg979/vim-visual-multi",
	branch = "master",
	init = function()
		vim.g.VM_default_mappings = 1
		vim.g.VM_maps = {
			["Find under"] = "<C-n>",
			["Find Subword under"] = "<C-n>",
			["Select all"] = "\\a",
			["Start Regex Search"] = "\\/",
		}
	end,
}
