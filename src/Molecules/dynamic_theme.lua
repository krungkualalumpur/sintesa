--!strict
local _Packages = game:GetService("ReplicatedStorage"):WaitForChild("Packages")
--services 
--packages
local Maid = require(_Packages:WaitForChild("Maid"))
local ColdFusion = require(_Packages:WaitForChild("ColdFusion8"))
--modules
local Enums = require(script.Parent.Parent:WaitForChild("Enums"))
local Styles = require(script.Parent.Parent:WaitForChild("Styles"))
local MaterialColor = require(
    script.Parent.Parent:WaitForChild("Styles")
).MaterialColor
local Types = require(script.Parent.Parent:WaitForChild("Types"))
--types
type Maid = Maid.Maid

type Fuse = ColdFusion.Fuse
type State<T> = ColdFusion.State<T>
type ValueState<T> = ColdFusion.ValueState<T>
type CanBeState<T> = ColdFusion.CanBeState<T>

type DynamicScheme = Types.DynamicScheme
--constants
--remotes
--variables
local _fuse = ColdFusion.fuse()
local _new = _fuse.new
local _Value = _fuse.Value 

local DynamicScheme: DynamicScheme-- = _Value(MaterialColor.getDynamicScheme(Color3))
local ColorState = {
    [Enums.ColorRole.Primary :: Enums.ColorRole] = Color3.new(0.639216, 0.341176, 0.666667),
    [Enums.ColorRole.Secondary] = Color3.new(0.400000, 0.392157, 0.780392),
    [Enums.ColorRole.Tertiary] = Color3.new(0.384314, 0.564706, 0.800000),
    [Enums.ColorRole.Surface] = Color3.new(0.580392, 0.580392, 0.580392), --neutral colors in general
    [Enums.ColorRole.SurfaceDim] = Color3.new(0.368627, 0.368627, 0.368627), -- neutral variant colors in general
    [Enums.ColorRole.Shadow] = Color3.new(0.011765, 0.011765, 0.011765)
}
--references
--local functions
--class
local theme = {
    StateLayerOpacity = 0.08
}

theme.Color = ColorState

return theme 