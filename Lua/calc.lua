local calculator = {}

calculator.pi = 3.141592653589793238462643383279

function calculator.add(a, b)
    return a + b
end

function calculator.sub(a, b)
    return a - b
end

function calculator.pow(a, b)
    local result = 1
    for _ = 1, b do
        result = result * a
    end
    return result
end

return calculator
