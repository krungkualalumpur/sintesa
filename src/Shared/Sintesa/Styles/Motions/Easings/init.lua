--!strict
--services
--packages
--modules
local Enums = require(script.Parent.Parent.Parent:WaitForChild("Enums"))
local MathUtil = require(script.Parent.Parent.Parent:WaitForChild("Utils"):WaitForChild("MathUtil"))
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

Easing.Transitions = {}

function cubicCurveToEasingOutput(x1 : number, y1 : number, x2 : number, y2 : number)
    return MathUtil.cubicBezier(x1, y1, x2, y2)
end

function customCurveToEasingOutput(... : MathUtil.Point)
    return MathUtil.generateBezierFromPoints(table.pack(...))
end

Easing[Enums.Easings.Emphasized] = function()
    return customCurveToEasingOutput(
        {0,0}, 
        {0.05, 0}, 
        {0.133333, 0.06}, 
        {0.16666, 0.4}, 
        {0.2083333, 0.82}, 
        {0.25, 1}, 
        {1,1}
    )
end

Easing[Enums.Easings.EmphasizedDecelerate] = function()
    return cubicCurveToEasingOutput(0.05, 0.7, 0.1, 1)
end

Easing[Enums.Easings.EphasizedAccelerate] = function()
    return cubicCurveToEasingOutput(0.03, 0, 0.8, 1)
end

Easing[Enums.Easings.Standard] = function()
    return cubicCurveToEasingOutput(0.2, 0, 0, 1)
end

Easing[Enums.Easings.StandardDecelerate] = function()
    return cubicCurveToEasingOutput(0, 0, 0, 1)
end

Easing[Enums.Easings.StandardAccelerate] = function()
    return cubicCurveToEasingOutput(0.3, 0, 1, 1)
end

Easing.Transitions[Enums.TransitionDuration.Short1] = 50/1000
Easing.Transitions[Enums.TransitionDuration.Short2] = 100/1000
Easing.Transitions[Enums.TransitionDuration.Short3] = 150/1000
Easing.Transitions[Enums.TransitionDuration.Short4] = 200/1000

Easing.Transitions[Enums.TransitionDuration.Medium1] = 250/1000
Easing.Transitions[Enums.TransitionDuration.Medium2] = 300/1000
Easing.Transitions[Enums.TransitionDuration.Medium3] = 350/1000
Easing.Transitions[Enums.TransitionDuration.Medium4] = 400/1000

Easing.Transitions[Enums.TransitionDuration.Long1] = 450/1000
Easing.Transitions[Enums.TransitionDuration.Long2] = 500/1000
Easing.Transitions[Enums.TransitionDuration.Long3] = 550/1000
Easing.Transitions[Enums.TransitionDuration.Long4] = 600/1000
return Easing