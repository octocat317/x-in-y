----------------------------------------------------
-- 3.2 Class-like tables and inheritance.
----------------------------------------------------

-- Classes aren't built in; there are different ways
-- to make them using tables and metatables.

TableOne = {}

function TableOne:methodOne(param)
    print(param)
end

--[[
-- using a colon (:) in a function header is syntactic sugar
-- for object-oriented programming that automatically
-- adds a hidden first parameter named self to the function
--]]

-- the header in the above func is syntactic shortcut for
function TableOne.methodOne(self, param)
    print(param)
end

--[[
-- Call equivalence:
-- When you call a method using a colon (myTable:myMethod("test")),
-- Lua automatically passes myTable as the first argument (self),
-- translating it to myTable.myMethod(myTable, "test").
--]]

--[[
-- Matching Syntax: If you define a function with
-- a colon (function obj:foo()), you should call it with
-- a colon (obj:foo()) so that self is bound properly.
--]]

-- For either version to work without throwing a syntax error,
-- you must initialize the table and the property first:
MyClass = {
    name = 'classy'
}

-- Using colon syntax
function MyClass:greet(msg)
    print(self.name .. " says: " .. msg)
end

MyClass:greet("Hello")

-- Using dot syntax (equivalent)
function MyClass.greet(self, msg)
    print(self.name .. " says: " .. msg)
end

MyClass.greet(MyClass, "Hello")
print()

--[[
-- illustrating object-oriented constructs in Lua
--]]
Dog = {} -- Dog will act like a class; it's really just a table.

function Dog:new()
    local newObj = { sound = "woof" }
    self.__index = self -- self-indexing
    -- note: it is the reference to newObj that is returned, not a copy.
    return setmetatable(newObj, self)
end

-- self-indexing illustration
local Table1 = { name = 'tom' }
local Table2 = { city = 'paris' }

-- 1. Create a separate metatable
-- 2. Bind the __index behavior to look inside Table1
setmetatable(Table2, { __index = Table1 })
-- OR use ==> self-indexing <==
-- Tell Table1 to look at itself when used as a metatable
Table1.__index = Table1
setmetatable(Table2, Table1) -- Set Table1 as the metatable for Table2

print(Table2.city)           --> paris (found directly in Table2)
print(Table2.name)           --> tom   (fallback found in Table1 via __index)
print()

function Dog:makeSound()
    print("I say " .. self.sound)
end

local mrDog = Dog:new()
mrDog:makeSound()
print()

LoudDog = Dog:new()

function LoudDog:makeSound()
    local s = self.sound .. " "
    print(s .. s .. s)
end

local instaLoud = LoudDog:new()
instaLoud:makeSound()
print()

print(type(Dog))
print(type(Dog:new()))
print(type(Dog.new))
print(type(Table1.name))
print()

-- 1. LoudDog gets Dog's methods and variables.
-- 2. self has a 'sound' key from new(), see 3.
-- 3. Same as LoudDog.new(LoudDog), and converted to
--    Dog.new(LoudDog) as LoudDog has no 'new' key,
--    but does have __index = Dog on its metatable.
--    Result: instaLoud's metatable is LoudDog, and
--    LoudDog.__index = LoudDog. So instaLoud.key will
--    = instaLoud.key, LoudDog.key, Dog.key, whichever
--    table is the first with the given key.
-- 4. The 'makeSound' key is found in LoudDog; this
--    is the same as LoudDog.makeSound(instaLoud).

-- Own Example (object-orientation and inheritance)
GrandParent = {}
function GrandParent:new()
    local newObj = { surname = "", age = 90 }
    self.__index = self
    return setmetatable(newObj, self)
end

function GrandParent:greet()
    print("namaste...")
end

Parent = GrandParent:new()
function Parent:new()
    local newObj = { age = 65, hobby = "reading" }
    self.__index = self
    return setmetatable(newObj, self)
end

function Parent:greet()
    print("hello...")
end

Son = Parent:new()
function Son:new()
    local newObj = { age = 25, hobby = "football", pet = "dog" }
    self.__index = self
    return setmetatable(newObj, self)
end

function Son:greet()
    print("wassup...")
end

local sankaram = GrandParent:new()
sankaram:greet()
print(sankaram.surname)
print(sankaram.age)
print(sankaram.hobby)
print(sankaram.pet)
print()

local satya = Parent:new()
satya:greet()
print(satya.surname)
print(satya.age)
print(satya.hobby)
print(satya.pet)
print()

local vicky = Son:new()
vicky:greet()
print(vicky.surname)
print(vicky.age)
print(vicky.hobby)
print(vicky.pet)
print()
