----------------------------------------------------
-- 3. Tables.
----------------------------------------------------

-- Tables = Lua's only compound data structure;
-- they are associative arrays.
-- they are hash-lookup dicts that can also be used as lists.

local empty = {} -- creates an anonymous table and assigns its reference

-- array-style/list-style
local vroom = { 'ferrari', 'bmw', 'audi', 'volkswagen' }
print(vroom[0]) -- vroom[0] returns 'nil'
print()

-- List literals (like vroom) implicitly set up int keys
-- list indices in lua start at 1 (not 0)!!!
print(vroom[1])
print(vroom[2])
print(vroom[3])
print(vroom[4])
print()

-- dictionary-style
local meow = { name = 'pussy', age = 2, colour = 'white' }
-- dict literals have string keys by default
print(meow['name'])
print(meow['age'])
print(meow['colour'])
-- string keys can use dot notation
print(meow.name)
print(meow.age)
print(meow.colour)
print()

-- explicit key syntax
local random = { ['!@$#'] = 'special', [{}] = 1729, [6.28] = 'tau' }
-- Key matching is by value for numbers and strings,
-- but by identity for tables.
print(random[6.28])
print(random['!@$#'])
-- 'nil' can never be a key in a table

print(random[{}])
print()
-- this prints 'nil' since the lookup fails.
-- It fails because the key we used is not the same object
-- as the one used to store the original value.

local empty = {}
local rand = { [empty] = "nothing" }
print(rand[empty]) -- this works because the same object is used
print()

print(vroom[3])
vroom[3] = 'tata' -- updating value of existing key
print(vroom[3])
print()
print(meow.name)
meow.name = 'tom' -- updating value of existing key
print(meow.name)
print()

vroom[5] = 'mahindra' -- adding new item
meow.enemy = 'jerry'  -- adding new item
print(vroom[5])
print(meow.enemy)
print()

-- the # operator returns the total number of "integer" items
-- i.e. it gives the length of a list/array
print(#vroom)
print()

-- removing an item from table
meow.colour = nil

-- table iteration
for key, val in pairs(meow) do
    print(key, val)
end
print()

-- here, assigning 'nil' removes the value but leaves a "hole" (gap) in the list
vroom[2] = nil
for i = 1, #vroom do
    print(vroom[i])
end
print()

-- the proper way to delete an element from a list
-- not specifying the index parameter removes the last item
table.remove(vroom, 2)
for i = 1, #vroom do
    print(vroom[i])
end
print()

-- just like with strings, a function that take exactly
-- one table literal as its parameter doesn't need parentheses when called
function h(x) print(x.key1) end

h { key1 = "lock" }
print()

local mixed = { "value1", 2, "value3", 4.567, {} }
for i = 1, #mixed do
    print(mixed[i])
end
print()

-- some other built-in functions for tables
table.insert(vroom, 'ford')      -- append an item to the end of the list
print(table.concat(vroom, ", ")) -- join a table of strings into a single string
table.insert(vroom, 4, 'royce')  -- insert at index 4 and shift later items down
print(table.concat(vroom, ", "))
table.remove(vroom, 1)           -- remove index 1 and shift subsequent items up
print(table.concat(vroom, ", "))
print()

-- _G is a special table of all the globals
print(_G['_G'] == _G)
print(_G._G == _G)
print()

-- a 'list' in lua is not a separate type of its own
-- it is just a table with consecutive integer keys starting at 1,
-- which is treated as a list
