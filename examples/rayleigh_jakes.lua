-- 瑞利衰落信道下 QPSK 误码率对比：无均衡 vs ZF 均衡
-- 用法：在项目根目录下运行 lua examples/rayleigh_jakes.lua

package.path = ".\\?.lua;.\\" .. package.path

local qpsk = require("modulation.qpsk")
local rayleigh = require("channel.rayleigh")

math.randomseed(os.time())

local bits = {}
for i = 1, 2000 do bits[i] = math.random(0, 1) end

local symbols = qpsk.modulate(bits)
local ch = rayleigh.jakes(#symbols, 100, 10000)
local rx = rayleigh.apply(symbols, ch)

-- 无均衡直接解调
local rx_raw = qpsk.demodulate(rx)

-- ZF 均衡后解调
local eq = rayleigh.zf(rx)
local rx_zf = qpsk.demodulate(eq)

local function ber(a, b)
    local e = 0
    for i = 1, math.min(#a, #b) do
        if a[i] ~= b[i] then e = e + 1 end
    end
    return e / math.min(#a, #b)
end

print(string.format("无均衡 BER: %.4f", ber(bits, rx_raw)))
print(string.format("ZF均衡 BER: %.4f", ber(bits, rx_zf)))
print("参数: fd=100Hz, fs=10000Hz, 2000 比特")
