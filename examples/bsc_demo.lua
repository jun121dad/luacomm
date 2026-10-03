-- 二进制对称信道（BSC）误码率测试
-- 用法：在项目根目录下运行 lua examples/bsc_demo.lua

package.path = ".\\?.lua;.\\" .. package.path

local bsc = require("channel.bsc")

math.randomseed(os.time())

local bits = {}
for i = 1, 1000 do bits[i] = math.random(0, 1) end

print("BSC 信道误码率测试（1000 比特）")
print("--------------------------------")
for _, p in ipairs({0.01, 0.05, 0.1, 0.2}) do
    local rx = bsc.transmit(bits, p)
    local err = bsc.count_errors(bits, rx)
    print(string.format("p=%.2f  错误=%d/1000  BER=%.4f", p, err, err / 1000))
end
