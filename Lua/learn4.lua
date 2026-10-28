----------------------------------------------------
-- 4. Modules.
----------------------------------------------------

-- Custom Paths	You can dynamically expand where Lua looks
-- by modifying the path variable at the very top of your main script:
-- package.path = package.path .. ";/home/admin/Coding/Lua/?.lua"

-- Standard default paths in package.path:
print(package.path)
print()

for key, _ in pairs(package) do
    print(key)
end
print()

-- Lua processes external files as isolated function blocks,
-- preventing internal variables from leaking into the global scope
-- while allowing selected code to be exported and cached

local mod = require("mod")

-- Lua treats the entire mod.lua file as the body of
-- an invisible function: (function() ... end)().
-- Any variable declared as local inside mod.lua is
-- entirely invisible to the file importing it,
-- preventing global namespace pollution.

-- local mod = (function ()
--   <contents of mod.lua>
-- end)()

-- Immediately Invoked Function Expression (IIFE), or anonymous function call
-- The Wrapper (...): This tells Lua, "Hey, look at this
-- whole chunk of code inside here as a single value (a function)."
-- The Trigger (): The final pair of parentheses
-- at the very end is what actually executes that value.

local iffy = (function()
    print("This is an Immediately Invoked Function Expression")
    return "anonymous"
end)()
print(iffy)
print()

mod.leet()
-- mod.greet() -- error. greet is not a part of the returned table.
print()

-- By default,
-- Lua looks inside the current working directory for calculator.lua.
-- If the module is inside a folder (e.g., src/calculator.lua),
-- import it using a dot: require("src.calculator").
local calc = require("calc")

print(calc.add(100, 20))
print(calc.sub(321, 123))
print(calc.pow(2, 10))
print(calc.pi)
print()

--[[
-- 'require' is the standard way to load reusable library modules,
-- while 'dofile' is a utility function used
-- to run standalone scripts or load raw data files repeatedly.
--]]
local greet = require("hello")

-- 'require' caches modules in the package.loaded table.
-- Calling require a second time returns the cached version
-- instead of re-running the file.
local praise = require("awe")
local praiseAgain = require("awe") -- doesn't print again
print()

-- unlike 'require,' 'dofile' doesn't cache the module
local greet = dofile("hello.lua")
local greetAgain = dofile("hello.lua") -- prints again
print()

local a = require("config") -- prints "config file executed!"
local b = require("config")

local c = dofile("config.lua") -- prints "config file executed!"
local d = dofile("config.lua") -- prints "config file executed!" again
print()

print(a.theme)
print(b.theme)
print(c.theme)
print(d.theme)
print()

-- ==> require vs dofile <==
-- Caching Mechanism:
-- 'require' caches the result in package.loaded so the file executes only once.
-- 'dofile' re-loads and re-executes the file every single time it is called.

-- Path Searching:
-- 'require' searches through predefined patterns
-- in package.path (and package.cpath for binaries).
-- 'dofile' requires an exact file path
-- (absolute or relative to where the host application is running).

-- File Extensions:
-- by default, 'require' assumes the extension, i.e., .lua or .so
-- 'dofile' requires the explicit file name extension.

-- ==> loadfile and load <==
-- 'loadfile' loads a file but doesn't run it yet.
-- loadfile is a lower-level primitive that compiles a file
-- into a reusable function without executing it immediately
-- No caching (re-reads and re-compiles every time).
local file = loadfile("hello.lua") -- Call file() to run it.
file()

local f = loadfile("config.lua")
f()
print()
local foo = f()
print(foo)
print(foo.theme)
print()

-- 'load' is 'loadfile' but for strings
-- input source: A string, or a reader function that yields string pieces.
local moo = load("print('lualualua')")
moo()

local bar = load("return { size = 10 }")
bar()
local boo = bar()
print(boo.size)
print()
