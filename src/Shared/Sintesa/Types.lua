--!strict
local _Packages = game:GetService("ReplicatedStorage"):WaitForChild("Packages")
--services
--packages
local Maid = require(_Packages:WaitForChild("Maid"))
local ColdFusion = require(_Packages:WaitForChild("ColdFusion8"))
--modules
local Enums = require(script.Parent:WaitForChild("Enums"))
local DynamicColorTypes = require(script.Parent:WaitForChild("Styles"):WaitForChild("MaterialColor"):WaitForChild("dynamiccolor"):WaitForChild("Types"))
local Typography = require(script.Parent:WaitForChild("Styles"):WaitForChild("Typography"))
local Motions = require(script.Parent:WaitForChild("Styles"):WaitForChild("Motions"))

--types
type Fuse = ColdFusion.Fuse
type State<T> = ColdFusion.State<T>
type ValueState<T> = ColdFusion.ValueState<T>
type CanBeState<T> = ColdFusion.CanBeState<T>

export type TypeScaleData = Typography.TypeScaleData
export type AppearanceData = {
    Symmetry : CanBeState<Enums.ShapeSymmetry>,
    Style : CanBeState<Enums.ShapeStyle>,
    Elevation : CanBeState<Enums.ElevationResting>,
    Height : CanBeState<number>,
    --SurfaceColor : Enums.ColorRole,
    PrimaryColor : CanBeState<Color3>,
    SecondaryColor : CanBeState<Color3>,
    TertiaryColor : CanBeState<Color3>,
    NeutralColor : CanBeState<Color3>,
    NeutralVariantColor : CanBeState<Color3>,

    ShadowColor : CanBeState<Color3>
}

export type DynamicScheme = CanBeState<DynamicColorTypes.DynamicScheme>

export type TypographyData = {
    TypeScale : CanBeState<TypeScaleData>,
}

export type TransitionData = {
    Easing : CanBeState<Enums.Easing>,
    Duration : CanBeState<Enums.TransitionDuration>
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

    secondaryColor : CanBeState<Color3>,
    tertiaryColor : CanBeState<Color3>,

    neutralColor : CanBeState<Color3>,
    neutralVariantColor : CanBeState<Color3>,

    shadowColor : CanBeState<Color3>,
    
    elevation : CanBeState<Enums.ElevationResting>,
    symmetry : CanBeState<Enums.ShapeSymmetry>,
    style : CanBeState<Enums.ShapeStyle>,
    height : CanBeState<number>
) : AppearanceData
    local data = {
        PrimaryColor = primaryColor,
        SecondaryColor = secondaryColor,
        TertiaryColor = tertiaryColor,
        NeutralColor = neutralColor,
        NeutralVariantColor = neutralVariantColor,
        ShadowColor = shadowColor,

        Elevation = elevation or Enums.ElevationResting.Level0,
        Symmetry = symmetry or Enums.ShapeSymmetry.Full,
        Style = style or Enums.ShapeStyle.None,
        Height = height or 24
    }
    return data
end

function data.createTypographyData(
    typeScale : CanBeState<Typography.TypeScaleData>
    ) : TypographyData
    return {
        TypeScale = typeScale
    }
end

function data.createTransitionData(
    easing : CanBeState<Enums.Easing>,
    duration : CanBeState<Enums.TransitionDuration>
    ) : TransitionData

    return {
        Easing = easing,
        Duration = duration,
    } 
end

return data