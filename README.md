# Lua 通信系统仿真

用 Lua 实现的数字通信基础仿真库，包含调制解调、信道模型、纠错编码和误码率分析。

## 功能模块

### 调制解调 (`modulation/`)
- **qpsk.lua** — QPSK 正交相移键控调制/解调
- **hamming.lua** — (7,4) 汉明码编码/解码/单比特纠错

### 信道模型 (`channel/`)
- **awgn.lua** — 加性高斯白噪声（AWGN）信道
- **rayleigh.lua** — 瑞利衰落信道（Jakes 模型）+ ZF/MMSE 均衡
- **bsc.lua** — 二进制对称信道（BSC）

### 分析工具 (`analysis/`)
- **erfc.lua** — 互补误差函数 erfc() 和 Q 函数

## 示例 (`examples/`)

| 脚本 | 功能 | 运行方式 |
|------|------|---------|
| `ber_awgn.lua` | QPSK 在 AWGN 信道下的 BER 仿真，导出 CSV | `lua examples/ber_awgn.lua` |
| `hamming_demo.lua` | 汉明码编解码与纠错演示 | `lua examples/hamming_demo.lua` |
| `bsc_demo.lua` | BSC 信道误码率测试 | `lua examples/bsc_demo.lua` |
| `text_transmission.lua` | 文本通过 QPSK+AWGN 传输 | `lua examples/text_transmission.lua` |
| `rayleigh_jakes.lua` | 瑞利衰落下无均衡 vs ZF 均衡对比 | `lua examples/rayleigh_jakes.lua` |
| `qpsk_constellation/` | QPSK 星座图实时可视化 | `love.exe examples/qpsk_constellation` |

## 环境要求

- **Lua 5.3+**（使用了 `~` 按位异或运算符）
- **LÖVE2D 11.x**（仅星座图示例需要）

## 快速开始

> **注意：所有示例必须在项目根目录下运行**（即包含 `modulation/`、`channel/` 的那一层）。

```bash
# 进入项目根目录
cd lua-comm-sim

# 运行 BER 仿真（输出 results/ber_awgn.csv）
lua examples/ber_awgn.lua

# 运行汉明码纠错演示
lua examples/hamming_demo.lua

# 查看 QPSK 星座图（需要 LÖVE2D，从根目录运行）
love examples/qpsk_constellation
```

## 项目结构

```
lua-comm-sim/
├── modulation/       # 调制与编码模块
├── channel/          # 信道模型
├── analysis/         # 数学分析工具
├── examples/         # 示例脚本
│   └── qpsk_constellation/  # LÖVE2D 星座图
├── results/          # 仿真输出（CSV，已忽略）
├── README.md
└── .gitignore
```

## 许可证

MIT
