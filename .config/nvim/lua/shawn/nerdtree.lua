vim.cmd([[

" Start NERDTree when Vim is started without file arguments.
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Start NERDTree when Vim starts with a directory argument.
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    " \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" close tree on open
let g:NERDTreeQuitOnOpen=1
" show hidden files by default
let g:NERDTreeShowHidden=1
" always delete old buffers when renaming or deleting files
let g:NERDTreeAutoDeleteBuffer=1

]])

--- Get the length of the longest line in the current buffer.
local function get_longest_line_length()
	local longest_length = 0
	for _, line in ipairs(vim.fn.getline(1, "$")) do
		local line_length = string.len(line)
		if line_length > longest_length then
			longest_length = line_length
		end
	end
	return longest_length
end

---Resizes the nerdtree buffer. Nerdtree should be open and is the current buffer
local function resize_nerdtree_buffer()
	local longest_line = get_longest_line_length()
	vim.cmd("vertical resize " .. longest_line)
end

local map = vim.keymap.set
map("n", "<leader>nt", function()
	vim.cmd("tabe")
	vim.cmd("NERDTree | only")
end, {
	desc = "Open Nerdtree in a new tab",
})

map("n", "<leader>nf", function()
	vim.cmd("NERDTreeFind")
	resize_nerdtree_buffer()
end, {
desc = "Open the current file in Nerdtree"
})

map("n", "<leader>nn", function()
	vim.cmd("NERDTreeToggle")
	resize_nerdtree_buffer()
end, {
desc = "Open Nerdtree"
})
