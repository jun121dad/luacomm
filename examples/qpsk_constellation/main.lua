-- QPSK 星座图可视化（LÖVE2D）
-- 用法：在本目录下运行 love.exe .
-- 操作：↑↓ 调整 SNR，ESC 退出

package.path = package.path .. ";../../?.lua;../../?/init.lua"

local qpsk = require("modulation.qpsk")
local awgn = require("channel.awgn")

local ideal, noisy = {}, {}
local snr = 15

local function regen()
    math.randomseed(os.time())
    local bits = {}
    for i = 1, 400 do bits[i] = math.random(0, 1) end
    ideal = qpsk.modulate(bits)
    noisy = awgn.add(ideal, snr)
end

function love.load()
    regen()
end

function love.draw()
    local w, h = love.graphics.getDimensions()
    local cx, cy, scale = w / 2, h / 2, 250

    -- 坐标轴
    love.graphics.setColor(0.3, 0.3, 0.3)
    love.graphics.line(cx, 0, cx, h)
    love.graphics.line(0, cy, w, cy)

    -- 理想星座点（绿色）
    love.graphics.setColor(0, 1, 0)
    for _, s in ipairs(ideal) do
        love.graphics.circle("fill", cx + s.I * scale, cy - s.Q * scale, 3)
    end

    -- 加噪后接收点（橙色半透明）
    love.graphics.setColor(1, 0.5, 0, 0.6)
    for _, s in ipairs(noisy) do
        love.graphics.circle("fill", cx + s.I * scale, cy - s.Q * scale, 2)
    end

    -- 文字提示
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("SNR = " .. snr .. " dB", 10, 10)
    love.graphics.print("Up/Down: adjust SNR  ESC: quit", 10, 30)
end

function love.keypressed(key)
    if key == "up" then
        snr = snr + 1
        regen()
    elseif key == "down" then
        snr = snr - 1
        regen()
    elseif key == "escape" then
        love.event.quit()
    end
end
