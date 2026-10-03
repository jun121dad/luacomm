local qpsk = {}
local INV_SQRT2 = 1 / math.sqrt(2)
local MAP = {
    ["00"] = {I =  INV_SQRT2, Q =  INV_SQRT2},
    ["01"] = {I = -INV_SQRT2, Q =  INV_SQRT2},
    ["11"] = {I = -INV_SQRT2, Q = -INV_SQRT2},
    ["10"] = {I =  INV_SQRT2, Q = -INV_SQRT2},
}
function qpsk.modulate(bits)
    local symbols = {}
    for i = 1, #bits - 1, 2 do
        local key = tostring(bits[i]) .. tostring(bits[i+1])
        local p = MAP[key]
        symbols[#symbols + 1] = {I = p.I, Q = p.Q}
    end
    return symbols
end
function qpsk.demodulate(symbols)
    local bits = {}
    for _, s in ipairs(symbols) do
        -- 修改后的解调逻辑
        bits[#bits + 1] = s.Q < 0 and 1 or 0  -- 第一位由 Q 的符号决定
        bits[#bits + 1] = s.I < 0 and 1 or 0  -- 第二位由 I 的符号决定
    end
    return bits
end
return qpsk