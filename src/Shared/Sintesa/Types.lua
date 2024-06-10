--!strict
local _Packages = game:GetService("ReplicatedStorage"):WaitForChild("Packages")
--services
--packages
local Maid = require(_Packages:WaitForChild("Maid"))
local ColdFusion = require(_Packages:WaitForChild("ColdFusion8"))
--modules
local Enums = require(script.Parent:WaitForChild("Enums"))
--types
type Fuse = ColdFusion.Fuse
type State<T> = ColdFusion.State<T>
type ValueState<T> = ColdFusion.ValueState<T>
type CanBeState<T> = ColdFusion.CanBeState<T>

export type AppearanceData = {
    Symmetry : Enums.ShapeSymmetry,
    Style : Enums.ShapeStyle,
    --SurfaceColor : Enums.ColorRole,
    PrimaryColor : CanBeState<Color3>,
    SecondaryColor : CanBeState<Color3>?,
    TertiaryColor : CanBeState<Color3>?,

    Elevation : Enums.ElevationResting
}

export type TransitionData = {

}

--constants
--remotes
--variables
--references
--local functions
--class
local data = {}
function data.createAppearanceData(
    primaryColor : CanBeState<Color3>,

    secondaryColor : CanBeState<Color3>?,
    tertiaryColor : CanBeState<Color3>?,
    
    elevation : Enums.ElevationResting?,
    symmetry : Enums.ShapeSymmetry?,
    style : Enums.ShapeStyle?
) : AppearanceData
    local data = {
        PrimaryColor = primaryColor,
        SecondaryColor = secondaryColor,
        TertiaryColor = tertiaryColor,

        Elevation = elevation or Enums.ElevationResting.Level0,
        Symmetry = symmetry or Enums.ShapeSymmetry.None,
        Style = style or Enums.ShapeStyle.None
    }
    return data
end
return data