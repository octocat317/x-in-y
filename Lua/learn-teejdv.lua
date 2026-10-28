local list = { "first", 2, false, function() print("Fourth!") end }
print("Yup, 1-indexed:", list[1])
print("Fourth is 4 ...", list[4]()) -- calling function on an element from list
print()

local t = {
    literal_key = "a string",
    ["an_expre$$ion"] = "also works",
    [function() end] = true
}

print("literal_key   :", t.literal_key)
print("an_expre$$ion :", t["an_expre$$ion"])
print("function() end:", t[function() end])
print()

local fav_acc = { "teej_dv", "ThePrimeagen", "terminaldotshop" }
for index, value in ipairs(fav_acc) do -- ipairs <==> integer pairs
    print(index, value)
end
print()

function BoolCheck(value)
    if value then
        print(tostring(value) .. " is true")
    elseif not value then
        print(tostring(value) .. " is falsy")
    end
end

BoolCheck(0)  -- true
BoolCheck({}) -- true
BoolCheck("") -- true
BoolCheck()   -- actual param becomes 'nil'
BoolCheck("hello")
BoolCheck(false)
print()

local variable_arguments = function(...)
    local arguments = { ... }
    for i, v in ipairs({ ... }) do print(i, v) end
    return table.unpack(arguments)
end

print("1:", variable_arguments("hello", "world", "!"))
print("2:", variable_arguments("hello", "world", "!"), "<lost>")
print()

-- a common way to set or pass default args in Lua
local setup = function(opts)
    if opts.default == nil then
        opts.default = 17
    end
    print(opts.default, opts.other)
end
-- calling without parentheses only works for literal strings and literal tables
setup { default = 12, other = false }
setup { other = true }
print()

local vector_meta = {}
function vector_meta.__add(left, right)
    return setmetatable({
        left[1] + right[1],
        left[2] + right[2],
        left[3] + right[3]
    }, vector_meta)
end

local v1 = setmetatable({ 1, -3, 5 }, vector_meta)
local v2 = setmetatable({ -1, 8, -9 }, vector_meta)
local v3 = v1 + v2

print(v3[1], v3[2], v3[3])
print((v3 + v3)[2])
print(getmetatable(v3))
print(getmetatable(v3).__add)
