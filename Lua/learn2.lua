----------------------------------------------------
-- 2. Functions.
----------------------------------------------------

-- Lua functions return nil by default
local print_return = print("print function returns 'nil'")
print("print_return:", print_return)
print()

function Void()
    -- function that explicitly returns nothing implicitly returns 'nil'
    print("returns nothing")
end

local voo = Void()
print("Void_return:", voo)
print()

print("Closures and anonymous functions exist")

function Adder(x)
    return function(y) return x + y end
end

local a1 = Adder(100)
local a2 = Adder(123)
print(a1(21))
print(a2(321))
print()

print("==> --> Functions are first-class <-- <==")
print("--> functions can be local or global just like variables <--")
print()

--[[
--  returns, function calls, assignments
--  all work with listings
--  that may be mismatched in length.
--  unmatched receivers become 'nil'
--  unmatched senders are discarded
--]]

function Lalula(p, o, t)
    print(p, o, t)
    return 2, 3, 5, 7, 11, 13
end

local m, n = Lalula("boom")
print(m, n)
local t, u, v = Lalula("doom", "loom")
print(t, u, v)
local a1, a2, a3, a4, a5, a6, a7 = Lalula("six", "seven")
print(a1, a2, a3, a4, a5, a6, a7)
print()

print("there are two ways of defining a named function")
function Sq(x)
    return x * x
end

Sq = function(x)
    return x * x
end
print()

-- Without the Forward Declaration
local g = function(x) return math.sin(x) end
g(10)
--[[
--  The above line actually fails to self-reference.
--  When Lua reads local g = ...,
--  the variable g is not officially created in
--  the local scope until the entire line is finished.
--
--  Because the local g doesn't exist yet,
--  the g(x) inside the function body
--  looks outside for a variable named g.
--  If there isn't one, the function will
--  crash with a "nil value" error when called.
--]]

print("there are two ways to 'properly' define a local function")
-- With Forward Declaration
local g; g = function(x) return math.sin(x) end
-- the 'local g' decl (before assignment) makes g-self-references possible.
g(10)

-- The "Shortcut" syntax
local function g(x) return math.sin(x) end
--[[
--  Under the hood, Lua automatically compiles
--  the line above into the exact two-step process
--  as in "With Forward Declaration"
--]]
print()

print("sin(pi / 2) = " .. g(3.141592 / 2))
print("trig functions take radian values")
print()

print("function calls with one string param don't need parentheses")
print "hello without parentheses"
