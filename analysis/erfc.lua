local erfc = {}
function erfc.erfc(x)
    local z = math.abs(x)
    local t = 1 / (1 + z / 2)
    local ans = t * math.exp(-z*z - 1.26551223 +
            t * (1.00002368 + t * (0.37409196 + t * (0.09678418 +
                    t * (-0.18628806 + t * (0.27886807 + t * (-1.13520398 +
                            t * (1.48851587 + t * (-0.82215223 + t * 0.17087277)))))))))
    if x >= 0 then return ans else return 2 - ans end
end
function erfc.Q(x) return 0.5 * erfc.erfc(x / math.sqrt(2)) end
return erfc