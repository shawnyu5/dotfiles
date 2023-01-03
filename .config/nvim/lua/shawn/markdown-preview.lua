-- set to 1, nvim will open the preview window after entering the markdown buffer
vim.g.mkdp_auto_start = 0

-- set to 1, the nvim will auto close current preview window when change
-- from markdown buffer to another buffer
vim.g.mkdp_auto_close = 0

-- set to 1, the vim will refresh markdown when save the buffer or
-- leave from insert mode, default 0 is auto refresh markdown as you edit or
-- move the cursor
vim.g.mkdp_refresh_slow = 1

-- specify browser to open preview page
vim.g.mkdp_browser = "google-chrome-stable"
local utils = require("shawn.utils")
local system_config = utils.get_system_config()
if system_config.windows then
	vim.g.mkdp_browser = "C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome"
end

-- use a custom markdown style must be absolute path
-- like '/Users/username/markdown.css' or expand('~/markdown.css')
-- let g:mkdp_highlight_css = expand("~/retro.css")
