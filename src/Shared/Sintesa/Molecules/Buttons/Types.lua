--!strict
--services
--packages
local Enums = require(script.Parent.Parent.Parent:WaitForChild("Enums"))
--modules
--types
export type AppearanceData = {
    Symmetry : Enums.ShapeSymmetry,
    Style : Enums.ShapeStyle,
    --SurfaceColor : Enums.ColorRole,
    PrimaryColor : Enums.ColorRole,
    Elevation : Enums.ElevationResting     
}
--constants
--remotes
--variables
--references
--local functions
--class

return {}