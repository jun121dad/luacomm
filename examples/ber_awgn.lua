-- QPSK 在 AWGN 信道下的误码率（BER）仿真
-- 用法：在项目根目录下运行 lua examples/ber_awgn.lua
-- 输出：results/ber_awgn.csv + 控制台打印

package.path = ".\\?.lua;.\\" .. package.path

local qpsk = require("modulation.qpsk")
local awgn = require("channel.awgn")
local erfc = require("analysis.erfc")

math.randomseed(12345)

local function gen_bits(n)
    local b = {}
    for i = 1, n do b[i] = math.random(0, 1) end
    return b
end

local function count_errors(a, b)
    local e = 0
    for i = 1, math.min(#a, #b) do
        if a[i] ~= b[i] then e = e + 1 end
    end
    return e
end

local N = 50000
local tx_bits = gen_bits(N)
local symbols = qpsk.modulate(tx_bits)

os.execute("mkdir results 2>nul")
local f, err = io.open("results/ber_awgn.csv", "w")
if not f then
    print("无法打开输出文件: " .. tostring(err))
    os.exit(1)
end

f:write("SNR_dB,BER_sim,BER_theory\n")
for snr = 0, 20, 1 do
    local noisy = awgn.add(symbols, snr)
    local rx = qpsk.demodulate(noisy)
    local err_count = count_errors(tx_bits, rx)
    local ber_sim = err_count / N
    local snr_lin = 10^(snr / 10)
    local eb_n0 = snr_lin / 2
    local ber_theory = erfc.Q(math.sqrt(2 * eb_n0))
    f:write(string.format("%d,%.8f,%.8f\n", snr, ber_sim, ber_theory))
    print(string.format("SNR=%2ddB  sim=%.6f  theory=%.6f", snr, ber_sim, ber_theory))
end
f:close()
print("已导出 results/ber_awgn.csv")
