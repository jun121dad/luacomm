local bsc = {}

function bsc.transmit(bits, p)
    local out = {}
    for i, b in ipairs(bits) do
        out[i] = (math.random() < p) and (1 - b) or b
    end
    return out
end

function bsc.count_errors(a, b)
    local e = 0
    for i = 1, math.min(#a, #b) do
        if a[i] ~= b[i] then e = e + 1 end
    end
    return e
end

function bsc.ber(a, b)
    local n = math.min(#a, #b)
    if n == 0 then return 0 end
    return bsc.count_errors(a, b) / n
end

return bsc
