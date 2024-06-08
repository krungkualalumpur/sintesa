--!strict
--services
--packages
--modules
--types
export type Point = {[number] : number}
--constants
--remotes
--variables
--references
--local functions
--class
local util = {}

function util.lerp(n0 : number, n1 : number, t : number)
    return (1 - t)*n0 + t*n1
end

  
local function bp(p0 : Point, p1 : Point, t : number)
    local p : Point = {}
    p[1] = util.lerp(p0[1], p1[1], t)
    p[2] = util.lerp(p0[2], p1[2], t)
    return p
end

function util.linear()
    local curve = {}

    local curvePointsN = 75
    for t = 0, 1, 1/curvePointsN do
        local lp = bp({0,0}, {1,1}, t)
        table.insert(curve, lp)
    end

    return curve
end

function util.quadratic(
    x1 : number, 
    y1 : number)

    local curve = {}
    assert((x1 >= 0 and y1 >= 0))

    local curvePointsN = 75
    for t = 0, 1, 1/curvePointsN do
      
        local lp0 = bp({0, 0}, {x1, y1}, t)
        local lp1 = bp({x1, y1}, {1, 1}, t)
        local qp = bp(lp0, lp1, t)

        table.insert(curve, qp)
    end

    return curve
end

function util.cubic(
    x1 : number, 
    y1 : number,
    x2 : number,
    y2 : number)
    
    local curve = {}
    assert((x1 >= 0 and y1 >= 0) and (x2 <= 1 and y2 <= 1))

    local curvePointsN = 75
    for t = 0, 1, 1/curvePointsN do
        local lp0 = bp({0, 0}, {x1, y1}, t)
        local lp1 = bp({x1, y1}, {x2, y2}, t)
        local lp2 = bp({x2, y2}, {1, 1}, t)

        local qp0 = bp(lp0, lp1, t)
        local qp1 = bp(lp1, lp2, t)

        local cp = bp(qp0, qp1, t)
        table.insert(curve, cp)
    end
    return curve
end

return util