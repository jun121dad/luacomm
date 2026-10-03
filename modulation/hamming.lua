local hamming = {}
function hamming.encode(bits)
    local out = {}
    for i = 1, #bits - 3, 4 do
        local d1, d2, d3, d4 = bits[i], bits[i+1], bits[i+2], bits[i+3]
        local p1 = d1 ~ d2 ~ d4
        local p2 = d1 ~ d3 ~ d4
        local p4 = d2 ~ d3 ~ d4
        out[#out+1] = p1; out[#out+1] = p2; out[#out+1] = d1
        out[#out+1] = p4; out[#out+1] = d2; out[#out+1] = d3; out[#out+1] = d4
    end
    return out
end

function hamming.decode(bits)
    local out = {}
    local corrected = 0
    for i = 1, #bits - 6, 7 do
        local c = {bits[i], bits[i+1], bits[i+2], bits[i+3],
                   bits[i+4], bits[i+5], bits[i+6]}
        local s1 = c[1] ~ c[3] ~ c[5] ~ c[7]
        local s2 = c[2] ~ c[3] ~ c[6] ~ c[7]
        local s4 = c[4] ~ c[5] ~ c[6] ~ c[7]
        local syn = s1 + s2 * 2 + s4 * 4
        if syn ~= 0 then
            c[syn] = 1 - c[syn]
            corrected = corrected + 1
        end
        out[#out+1] = c[3]; out[#out+1] = c[5]
        out[#out+1] = c[6]; out[#out+1] = c[7]
    end
    return out, corrected
end
return hamming
