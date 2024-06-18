--!strict
--services
--packages
local Enums = require(script.Parent.Parent:WaitForChild("Enums"))
--modules
--types
--constants
--remotes
--variables
local ShapeStyles = {
    [Enums.ShapeStyle.Full :: Enums.ShapeStyle] = 999999999,
    [Enums.ShapeStyle.ExtraLarge :: Enums.ShapeStyle] = 28,
    [Enums.ShapeStyle.Large] = 16,
    [Enums.ShapeStyle.Medium] = 12,
    [Enums.ShapeStyle.Small] = 8,
    [Enums.ShapeStyle.ExtraSmall] = 4,
    [Enums.ShapeStyle.None] = 0
}
--references
--local functions
--class
local Shape = {}


function Shape.get(shapeStyle : Enums.ShapeStyle)
    return ShapeStyles[shapeStyle]
end

function Shape.getShapeStyles()
    return table.freeze(table.clone(ShapeStyles))
end


return Shape