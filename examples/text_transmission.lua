-- 文本通过 QPSK + AWGN 传输测试
-- 用法：在项目根目录下运行 lua examples/text_transmission.lua

package.path = ".\\?.lua;.\\" .. package.path

local qpsk = require("modulation.qpsk")
local awgn = require("channel.awgn")

local function text_to_bits(s)
    local bits = {}
    for i = 1, #s do
        local byte = s:byte(i)
        for k = 7, 0, -1 do
            bits[#bits + 1] = math.floor(byte / 2^k) % 2
        end
    end
    return bits
end

local function bits_to_text(bits)
    local bytes = {}
    for i = 1, #bits, 8 do
        local b = 0
        for j = 0, 7 do
            b = b * 2 + (bits[i + j] or 0)
        end
        bytes[#bytes + 1] = string.char(b)
    end
    return table.concat(bytes)
end

local function count_errors(a, b)
    local e = 0
    for i = 1, math.min(#a, #b) do
        if a[i] ~= b[i] then e = e + 1 end
    end
    return e
end

math.randomseed(os.time())

local text = "HELLO QPSK"
local tx_bits = text_to_bits(text)
print("原始文本: " .. text)
print("比特数: " .. #tx_bits)

local symbols = qpsk.modulate(tx_bits)

for _, snr in ipairs({0, 5, 10, 15, 20}) do
    local noisy = awgn.add(symbols, snr)
    local rx_bits = qpsk.demodulate(noisy)
    local rx_text = bits_to_text(rx_bits)
    local err = count_errors(tx_bits, rx_bits)
    print(string.format("SNR=%2ddB  BER=%.4f  接收: %s", snr, err / #tx_bits, rx_text))
end
