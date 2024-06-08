--!strict
--services
--packages
--modules
local Enums = require(script.Parent.Parent.Parent:WaitForChild("Enums"))
local MathUtil = require(script.Parent.Parent.Parent:WaitForChild("MathUtil"))
--types
--constants
--remotes
--variables
--references
--local functions
local function pointToVector2(point : MathUtil.Point)
    return Vector2.new(point[1] or 0, point[2] or 0)
end
--class
local Easing = {}

function cubicCurveToV2s(x1 : number, y1 : number, x2 : number, y2 : number)
    local curve = MathUtil.cubic(x1, y1, x2, y2)
    local curveInV2 = {}
    for _,point in pairs(curve) do
        table.insert(curveInV2, pointToVector2(point))
    end
    return curveInV2
end

Easing[Enums.Easings.Emphasized] = function()
  
    return 
end

Easing[Enums.Easings.EmphasizedDecelerate] = function()
    return cubicCurveToV2s(0.05, 0.7, 0.1, 1)
end

Easing[Enums.Easings.EphasizedAccelerate] = function()
    return cubicCurveToV2s(0.03, 0, 0.8, 1)
end

Easing[Enums.Easings.Standard] = function()
    return cubicCurveToV2s(0.2, 0, 0, 1)
end

Easing[Enums.Easings.StandardDecelerate] = function()
    return cubicCurveToV2s(0, 0, 0, 1)
end

Easing[Enums.Easings.StandardAccelerate] = function()
    
end

return Easing