print("print() function exists\n")
print("one-line comments start with double hyphen -- ")
-- print("one-line comments")

print("one-line comments can be written ...")
print("...following a statement on the same line") -- one-line comment
print()
--[[
    this
    is a
    multi-line
    comment
]]

-- multi-line comments use --[[ and ]]
-- but, multi-line comments popularly use --[[ and --]] instead

multi = [[
          multi-line
          strings
          use
          Double
          brackets
]]
print(multi)

print("using 'single' quotes inside string")
print('using "double" quotes inside string')
print()

print("string concatenation " .. "operator " .. "is ..")
print()

local val = 100
print(val, type(val))
-- assigning 'nil' undefines that variable
-- Lua has garbage collection
local val = nil
print(val, type(val))

print("\nprinting some undefined var:", someUndefinedVar)
print()
moo = someUndefinedVar
print("assigning some undefined variable returns:", moo)
print()

boot = true
boof = false
print("the boolean values:", boot, boof)
print()

if 1 then
    print([[implicit conversion to boolean exists
    all integers evaluate to 'true' including zero]])
end
print()

if 0 then
    print("!!! number 0 evaluates to 'true' !!!")
else
    print(whatever)
end

if "" then
    print("!!! empty string \"\" evaluates to 'true' !!!")
else
    print(whatever)
end
print()

if nil then
    print(whatever)
else
    print("'nil' has boolean value 'false'")
end
print("only 'nil' and 'false' are falsy")
print()

print([[ternary operator uses boolean 'and' and 'or'
        USAGE: condt. and statement1 or statement2
      same as: condt.  ?  statement1 :  statement2
]])
tern1 = 0 and "yes 0" or "no 0"
tern1x = 0.0 and "yes 0.0" or "no 0.0"
tern2 = "" and "yes empty" or "no empty"
tern3 = "lua" and "yes non-empty" or "no non-empty"
tern4 = nil and "yes nil" or "no nil"
print("ternary:")
print("", tern1)
print("", tern1x)
print("", tern2)
print("", tern3)
print("", tern4)
print()

a, b = 10, 12
print((a > b) and "a = 10 is greater" or "b = 12 is greater")
print()

num = 42
fum = 3.141592653589793238462643383279
print("numbers can be integer or floating-point")
print(num, type(num))
print(fum, type(fum))
print()

print("numeric for loop takes 'start', 'stop', 'step' values")
print("numeric for loop is inclusive of both 'start' and 'stop'")
for i = 2, 10, 2 do
    io.write(i, " ")
end
print('\n')

val = 3
while val > 0 do
    print("while loop exists")
    val = val - 1
end
print()
val = 3
repeat
    print("there is a loop construct called repeat-until")
    val = val - 1
until val == 0
print("repeat-until loop repeats 'until' the condition becomes true")
print()

for i = 1, 3 do
    if i == 1 then
        print("hello from 'if'...")
    elseif i == 2 then
        print("hello from 'elseif'...")
    else
        print("hello from 'else'...")
    end
end
print()

print("multiple assignments in a single line")
local x, y, z = 10, 20, 30, 40
print("x =", x)
print("y =", y)
print("z =", z)
print("40 is ignored")

local q, r, s = 100, 200
print("q =", q)
print("r =", r)
print("s =", s)
print()
