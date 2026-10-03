local rayleigh = {}
function rayleigh.jakes(n, fd, fs)
    local N0 = 8
    local ch = {}
    for k = 1, n do
        local hi, hq = 0, 0
        for m = 1, N0 do
            local beta = math.pi * m / (N0 + 1)
            local w = 2 * math.pi * fd * math.cos(2 * math.pi * m / (2*N0+1))
            local phi = 2 * math.pi * math.random()
            hi = hi + math.cos(w * k / fs + phi) * math.cos(beta)
            hq = hq + math.sin(w * k / fs + phi) * math.sin(beta)
        end
        ch[k] = {I = hi / math.sqrt(N0), Q = hq / math.sqrt(N0)}
    end
    return ch
end

function rayleigh.apply(symbols, ch)
    local out = {}
    for i, s in ipairs(symbols) do
        local h = ch[((i-1) % #ch) + 1]
        out[i] = {
            I = s.I * h.I - s.Q * h.Q,
            Q = s.I * h.Q + s.Q * h.I,
            h = h
        }
    end
    return out
end

function rayleigh.zf(received)
    local out = {}
    for i, s in ipairs(received) do
        local h = s.h
        local d = h.I^2 + h.Q^2
        if d < 1e-10 then d = 1e-10 end
        out[i] = {
            I = (s.I * h.I + s.Q * h.Q) / d,
            Q = (s.Q * h.I - s.I * h.Q) / d
        }
    end
    return out
end

function rayleigh.mmse(received, noise_var)
    local out = {}
    for i, s in ipairs(received) do
        local h = s.h
        local d = h.I^2 + h.Q^2 + noise_var
        out[i] = {
            I = (s.I * h.I + s.Q * h.Q) / d,
            Q = (s.Q * h.I - s.I * h.Q) / d
        }
    end
    return out
end
return rayleigh