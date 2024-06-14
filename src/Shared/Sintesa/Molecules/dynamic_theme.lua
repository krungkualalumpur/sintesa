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
    [Enums.ColorRole.Primary :: Enums.ColorRole] = Color3.new(0.713725, 0.129412, 0.945098),
    [Enums.ColorRole.Secondary] = Color3.new(0.627451, 0.549020, 0.713725),
    [Enums.ColorRole.Tertiary] = Color3.new(0.203922, 0.411765, 0.686275),
    [Enums.ColorRole.Surface] = Color3.fromRGB(220,220,220), --neutral colors in general
    [Enums.ColorRole.SurfaceDim] = Color3.fromRGB(180,180,180), -- neutral variant colors in general
    [Enums.ColorRole.Shadow] = Color3.new(0.011765, 0.011765, 0.011765)
}
--references
--local functions
local function get() : DynamicScheme
    return MaterialColor.getDynamicScheme(
        ColorState[Enums.ColorRole.Primary],
        ColorState[Enums.ColorRole.Secondary],
        ColorState[Enums.ColorRole.Tertiary],
        ColorState[Enums.ColorRole.Surface],
        ColorState[Enums.ColorRole.SurfaceDim]
    )
end
--class
local theme = {}

theme.Color = ColorState
theme.getDynamicScheme = function()
    if not DynamicScheme then
        DynamicScheme = get()
        assert(DynamicScheme)
        DynamicScheme:Set(get())
    end

    return DynamicScheme
end
theme.setDynamicScheme = function(
    primaryColor : Color3,
    secondaryColor : Color3,
    tertiaryColor : Color3,
    neutral : Color3,
    neutralVariant : Color3,
    shadowColor : Color3
    ) 
    
    Color3[Enums.ColorRole.Primary]:Set(primaryColor)
    Color3[Enums.ColorRole.Secondary]:Set(secondaryColor)
    Color3[Enums.ColorRole.Tertiary]:Set(tertiaryColor)
    Color3[Enums.ColorRole.Surface]:Set(neutral)
    Color3[Enums.ColorRole.SurfaceDim]:Set(neutralVariant)
    Color3[Enums.ColorRole.Shadow]:Set(shadowColor)

    theme.getDynamicScheme()
    return 
end


return theme 