--!strict
--services
--packages
--modules
--types
export type Point = {
    [number] : number
}
export type Curve = {
    [number] : Point,
    GetInterpolator : (self : Curve, t : number, interval : number ?) -> number
}
--constants
--remotes
--variables
--references
--local functions
local function round(n : number, r : number)
    return math.round(n/r)*r
end

local function createPoint(x : number, y : number)
    return {
        [1] = x,
        [2] = y
    }
end

--class
local util = {}

function getInterpolator(self : Curve, t : number, int : number ?) -- Whereby x acts as t
    local interval = int or 0.01

    local function findPtByT(t: number): Point
        local p
        local maxDiff = math.huge
        for _,v in pairs(self) do
            if type(v) ~= "function" then

                local _x = v[1]
                if maxDiff > math.abs((_x - t)) then
                    maxDiff = math.abs((_x - t))
                    p = v
                   -- print(p, t)
                    --task.wait()
                end
            
            end
        end
        assert(p, "Can't find the point")
        return table.clone(p)
    end

    for _, point : Point in pairs(self) do
        if type(point) ~= "function" then
            local p = findPtByT(t) 
            local px = p[1] --math.round(x)
            local py = p[2]
            return py
        end
    end
    error("Unable to interpolate!")
    --task.wait()
end

function bp(p0 : Point, p1 : Point, t : number)
    local p : Point = {} :: any
    p[1] = util.lerp(p0[1], p1[1], t)
    p[2] = util.lerp(p0[2], p1[2], t)
    return p
end

function util.lerp(n0 : number, n1 : number, t : number)
    return (1 - t)*n0 + t*n1
end

function util.linearBezier() 
    local curve : Curve = {
        GetInterpolator = getInterpolator
    } 

    local curvePointsN = 75
    for t = 0, 1, 1/curvePointsN do
        local lp = bp(createPoint(0, 0), createPoint(1, 1), t)
        table.insert(curve, lp)
    end

    return curve
end

function util.quadraticBezier(
    x1 : number, 
    y1 : number)

    local curve : Curve = {
        GetInterpolator = getInterpolator
    }
    assert((x1 >= 0 and y1 >= 0))

    local curvePointsN = 75
    for t = 0, 1, 1/curvePointsN do
      
        local lp0 = bp(createPoint(0, 0), createPoint(x1, y1), t)
        local lp1 = bp(createPoint(x1, y1), createPoint(1, 1), t)
        local qp = bp(lp0, lp1, t)

        table.insert(curve, qp)
    end

    return curve
end

function util.cubicBezier(
    x1 : number, 
    y1 : number,
    x2 : number,
    y2 : number)
    
    local curve : Curve = {
        GetInterpolator = getInterpolator
    }
    assert((x1 >= 0 and y1 >= 0) and (x2 <= 1 and y2 <= 1))

    local curvePointsN = 75
    for t = 0, 1, 1/curvePointsN do
        local lp0 = bp(createPoint(0, 0), createPoint(x1, y1), t)
        local lp1 = bp(createPoint(x1, y1), createPoint(x2, y2), t)
        local lp2 = bp(createPoint(x2, y2), createPoint(1, 1), t)

        local qp0 = bp(lp0, lp1, t)
        local qp1 = bp(lp1, lp2, t)

        local cp = bp(qp0, qp1, t)
        table.insert(curve, cp)
    end
    return curve
end

function util.generateBezierFromPoints(
    Points : {[number] : Point}) -- this assumes max x and y is 1 and min is 0

    local function generate(
        raw_points : {[number] : Point} ?,
        lerpAlpha : number, 
        interval : number)

        local points : {Point} = raw_points or {}

        local lerpPoint = {}

        for n : number,point : Point in pairs(points) do
            local point1 = points[n]
            local point2 = points[n + 1]

            if point1 and point2 then
                --table.insert(lerpPoint, CFrame.lookAt(point1:Lerp(point2, lerpAlpha).Position, point1:Lerp(point2, lerpAlpha + interval).Position))
                table.insert(lerpPoint, bp(point1, point2, lerpAlpha))

            end
        end

        if #lerpPoint > 0 then
            local curvePoint = generate(lerpPoint, lerpAlpha, interval)
            if curvePoint then
                return curvePoint
            end
        end

        if #points == 1 then
            return points[1]
        end

        error("Cannot get the bezier point")
    end

    local curve : Curve = {
        GetInterpolator = getInterpolator
    }

    local interval = 0.01
    for i = 0,1, interval do
        local p = generate(Points, i, interval)
        table.insert(curve, p)
    end
   
    return curve
end

return util