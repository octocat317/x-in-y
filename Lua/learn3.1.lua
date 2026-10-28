----------------------------------------------------
-- 3.1 Metatables and metamethods.
----------------------------------------------------
--[[
--  analogy: metatables as "instruction manuals" and
--  metamethods as the "specific rules" inside that manual
--  that tell Lua how to handle a table when it does something unusual
--]]

--[[
--  For example, If you try to add two tables together (tableA + tableB),
--  Lua errors out because it doesn't know how to add them.
--  A metatable fixes this by giving the table custom behaviors
--]]

-- A table can have a metatable that gives the table
-- operator-overloading-like behavior.
-- When Lua encounters an operator applied to tables (like a + b),
-- it ==> checks if either table <== has a metatable containing
-- the corresponding metamethod function.
-- If found, it runs that function instead of throwing a runtime error.

--[[

Category	Metamethod	Corresponding Operator / Event
Arithmetic	
            __add	Addition (+)
            __sub	Subtraction (-)
            __mul	Multiplication (*)
            __div	Division (/)
            __mod	Modulo (%)
            __pow	Exponentiation (^)
            __unm	Unary Minus / Negation (-x)
            __idiv	Floor Division (//) (Lua 5.3+)
Bitwise	
    __band / __bor / __bxor	Bitwise AND (&), OR (|), XOR (~) (Lua 5.3+)
    __bnot / __shl / __shr	Bitwise NOT (~), Shift Left (<<), Shift Right (>>)
Relational	
            __eq	Equal to (==)
            __lt	Less than (<)
            __le	Less than or equal to (<=)
String & Misc	
            __concat	Concatenation (..)
            __len	    Length operator (#)
            __tostring	Controls how the table prints via print()
            __call	    Allows the table to be called like a function: table()
--]]

local frac1 = { p = 1, q = 2 }
local frac2 = { p = 2, q = 3 }

local function gcd(m, n)
    while n ~= 0 do
        m, n = n, m % n
    end
    return m
end

local metafraction = {}
function metafraction.__add(f1, f2)
    local sum = {}
    sum.q = f1.q * f2.q
    sum.p = f1.p * f2.q + f2.p * f1.q

    local g = gcd(sum.p, sum.q)
    sum.p, sum.q = sum.p / g, sum.q / g

    return sum
end

setmetatable(frac1, metafraction)
setmetatable(frac2, metafraction)

local s = frac1 + frac2 -- calls __add(f1, f2) on f1's metatable
print(s.p .. " / " .. s.q)
print()

-- f1, f2 have no key for their metatable,
-- ??? unlike prototypes in js, ???
-- so you must retrieve it as in getmetatable(f1).
-- The metatable is a normal table
-- with keys that Lua knows about, like __add.

-- local t = s + s
-- the above line fails, because 's' doesn't have a metatable like f1 and f2
-- error: lua: attempt to perform arithmetic on a table value (local 's')

-- The __index metamethod in Lua
--[[
    The __index metamethod controls what happens when you
    try to read a key that does not exist in a table

    Normally, looking up a missing key returns nil.
    If a table has a metatable with an __index field,
    Lua checks that field instead
    The __index field can be set to either a table or a function
--]]

local defaultSpecs = { size = 'big', color = 'pink', style = 'cool' }
local specs = { size = 'small', style = 'crazy' }

setmetatable(specs, { __index = defaultSpecs })
print(specs.size)
print(specs.style)
print(specs.color)

-- Direct table lookups that fail will retry using
-- the metatable's __index value, and this is recursive.

local supDefault = { shape = 'oval' }
setmetatable(defaultSpecs, { __index = supDefault })
print(specs.shape)
print()

-- An __index value can also be a function(tbl, key)
-- for more customized lookups.
-- setting __index to a function allows you to
-- dynamically calculate values, intercept keys,
-- implement lazy loading, or create default behaviors on the fly.

-- When __index is a function, Lua automatically passes it two parameters:
-- 1. table: The original table that was indexed.
-- 2. key: The name of the missing key being requested

-- Example 1: Dynamic Calculation (Upper-casing Keys)
local meta = {
    __index = function(tbl, key)
        if type(key) == "string" then
            return string.upper(key)
        end
        return nil
    end
}

-- The setmetatable function returns the first argument
-- passed to it, which is the original target table itself.
local tbl = setmetatable({}, meta)
print(tbl.hello)
print(tbl.world)
print()

-- Example 2: Lazy Initialization with Caching (rawset)
local squares = setmetatable({}, {
    __index = function(tbl, key)
        print("generating value for " .. tostring(key) .. "...")
        local genValue = key * key
        rawset(tbl, key, genValue)
        return genValue
    end
})

print(squares[6])
print(squares[8])
print(squares[6], squares[8])
print(squares[17])
print()

-- Example 3: Conditional Fallbacks
local normalDefaults = { speed = 100, power = 15 }
local eliteDefaults = { speed = 250, power = 500 }

local playerMeta = {
    __index = function(tbl, key)
        if tbl.isElite then
            return eliteDefaults[key]
        else
            return normalDefaults[key]
        end
    end
}

local playerA = setmetatable({ isElite = false }, playerMeta)
local playerB = setmetatable({ isElite = true }, playerMeta)

print(playerA.speed, playerA.power)
print(playerB.speed, playerB.power)
print()

-- The __newindex method in Lua
--[[
-- The __newindex metamethod does for table updates
-- what __index does for table accesses.
-- When you assign a value to an absent index in a table,
-- the interpreter looks for a __newindex metamethod:
-- If there is one, the interpreter calls it instead of making the assignment.
-- Like __index, if the metamethod is a table,
-- the interpreter does the assignment in that table,
-- instead of in the original one.
-- Moreover, there is a raw function that allows you to
-- bypass the metamethod: The call rawset(t, k, v) sets
-- the value v in key k of table t without invoking any metamethod.
--]]

local newMeta = {}
local newTable = setmetatable({ greet = "hello" }, {
    __newindex = newMeta,
    __index = newMeta
})

newTable.newKey = "naya"

print(newTable.newKey)
print(newMeta.newKey)
print(rawget(newTable, "newKey"))
print(rawget(newMeta, "newKey"))
