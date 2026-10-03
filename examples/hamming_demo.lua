-- (7,4) 汉明码编解码与纠错演示
-- 用法：在项目根目录下运行 lua examples/hamming_demo.lua

package.path = ".\\?.lua;.\\" .. package.path

local hamming = require("modulation.hamming")

local data = {1, 0, 1, 1, 0, 0, 1, 0}
io.write("原始数据: ")
for _, b in ipairs(data) do io.write(b) end
print()

local encoded = hamming.encode(data)
io.write("编码后:   ")
for i, b in ipairs(encoded) do
    io.write(b)
    if i % 7 == 0 then io.write(" ") end
end
print()

-- 人为翻转第 3 位，模拟传输中出现 1 bit 错误
encoded[3] = 1 - encoded[3]
io.write("出错后:   ")
for i, b in ipairs(encoded) do
    io.write(b)
    if i % 7 == 0 then io.write(" ") end
end
print()

local decoded, corrected = hamming.decode(encoded)
io.write("译码后:   ")
for i, b in ipairs(decoded) do
    io.write(b)
    if i % 4 == 0 then io.write(" ") end
end
print("  (纠正 " .. corrected .. " 位)")
