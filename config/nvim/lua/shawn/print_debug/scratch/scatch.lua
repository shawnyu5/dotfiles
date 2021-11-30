-- local string = "hello <message>"
-- -- string = string:gsub('%b<>', '')
-- string = string:gsub("<message>", "hello world")
-- print('' .. string)

-- local tbl = {
    -- shawn = 15,
    -- john = 20
-- }

local opts = {
    cpp = 'std::cout << "<message>" << <variable> << \'\n\';',
    javascript = 'console.log("<message>, <variable>");',
    python = 'print("<message>", <variable>)',
    lua = 'print("<message>" .. <variable>)'
}

local string = "hello (world)"
local result = string:gsub('%b()', '')
print(result)
