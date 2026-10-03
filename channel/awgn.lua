local awgn = {}
local function gaussian()
    local u1 = math.random()
    local u2 = math.random()
    while u1 == 0 do u1 = math.random() end
    return math.sqrt(-2 * math.log(u1)) * math.cos(2 * math.pi * u2)
end
function awgn.add(symbols, snr_db)
    local snr = 10^(snr_db / 10)
    local sigma = math.sqrt(1 / snr / 2)
    local out = {}
    for i, s in ipairs(symbols) do
        out[i] = {I = s.I + gaussian()*sigma, Q = s.Q + gaussian()*sigma}
    end
    return out
end
return awgn