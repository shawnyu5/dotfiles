--- get the current git branch name and return the string. Else returns "-"
local getGitBranch = function()
	local f = io.popen("git rev-parse --abbrev-ref HEAD")
	if f then
		-- read output of current line
		local branch = f:read("*l")
		f:close()
		if branch then
			return tostring(branch)
		else
			return "-"
		end
	end
end

vim.g.lightline = {
	colorscheme = "tokyonight",
	active = {
		left = { { "mode", "paste" }, { "readonly", "filename", "modified", "gitBranch" } },
	},
	component = {
		gitBranch = getGitBranch(),
	},
}
