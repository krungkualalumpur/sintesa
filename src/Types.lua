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
local Icons = require(script.Parent:WaitForChild("Icons"))
--types
type Fuse = ColdFusion.Fuse
type State<T> = ColdFusion.State<T>
type ValueState<T> = ColdFusion.ValueState<T>
type CanBeState<T> = ColdFusion.CanBeState<T>

export type TypeScaleData = Typography.TypeScaleData
export type AppearanceData = {
    Symmetry : Enums.ShapeSymmetry,
    Style : Enums.ShapeStyle,
    Elevation : Enums.ElevationResting,
    Height : number,
    --SurfaceColor : Enums.ColorRole,
    IsDark : boolean,
    PrimaryColor : Color3,
    SecondaryColor : Color3,
    TertiaryColor : Color3,
    NeutralColor : Color3,
    NeutralVariantColor : Color3,

    ShadowColor : Color3
}

export type DynamicScheme = DynamicColorTypes.DynamicScheme

export type TypographyData = {
    TypeScale : TypeScaleData,
}

export type TransitionData = {
    Easing : Enums.Easing,
    Duration : Enums.TransitionDuration
}
export type IconData = Icons.IconData

export type ButtonData = {
    Name : string?,
    Selected : State<boolean>?,
    Id : (number | IconData)?,
    Badge : (number | string | boolean)?
}

export type ListData = {
    HeadlineText : string,
    SupportingText : string?,
    TrailingSupportingText : string?,
    TrailingIcon : (IconData|GuiButton)?,
    
    LeadingAvatarText : string?,
    
    LeadingIcon : (IconData|GuiButton)?,

    HasDivider : boolean?
}

--constants
--remotes
--variables
--references
--local functions
--class
local data = {}
function data.createAppearanceData(
    primaryColor : Color3,

    secondaryColor : Color3,
    tertiaryColor : Color3,

    neutralColor : Color3,
    neutralVariantColor : Color3,

    shadowColor : Color3,

    elevation : Enums.ElevationResting,
    symmetry : Enums.ShapeSymmetry,
    style : Enums.ShapeStyle,
    height : number,

    isDark : boolean
) : AppearanceData
    local data = {
        PrimaryColor = primaryColor,
        SecondaryColor = secondaryColor,
        TertiaryColor = tertiaryColor,
        NeutralColor = neutralColor,
        NeutralVariantColor = neutralVariantColor,
        ShadowColor = shadowColor,
        
        IsDark = isDark,

        Elevation = elevation or Enums.ElevationResting.Level0,
        Symmetry = symmetry or Enums.ShapeSymmetry.Full,
        Style = style or Enums.ShapeStyle.None,
        Height = height or 24
    }
    return data
end

function data.createTypographyData(
    typeScale : Typography.TypeScaleData
    ) : TypographyData
    return {
        TypeScale = typeScale
    }
end

function data.createTransitionData(
    easing : Enums.Easing,
    duration : Enums.TransitionDuration
    ) : TransitionData

    return {
        Easing = easing,
        Duration = duration,
    } 
end

function data.createFusionButtonData(
    Name : string,
    Id : (number | IconData)?,
    Selected : State<boolean>?,
    Badge : (number | string | boolean)?) : ButtonData

    return {
        Name = Name,
        Selected = Selected,
        Id = Id,
        Badge = Badge
    } 
end


function data.createFusionListInstance(
    headlineText : string,
    supportingText : string?,
    trailingSupportingText : string?,
    trailingIcon : (IconData| GuiButton)?,
    
    leadingAvatarText : string?,
    
    leadingIcon : (IconData|GuiButton)?,

    hasDivider : boolean?) : ListData

    return {
        HeadlineText = headlineText,
        SupportingText = supportingText,
        TrailingSupportingText = trailingSupportingText,
        TrailingIcon = trailingIcon,

        LeadingAvatarText = leadingAvatarText,

        LeadingIcon = leadingIcon,
        HasDivider = hasDivider
    } 
end

return data