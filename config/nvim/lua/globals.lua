function P(k)
    print(vim.inspect(k))
    return k
end

local tbl = {
    name = "shawn"
}
P(tbl)
