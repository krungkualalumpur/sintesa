--!strict
local _Packages = game:GetService("ReplicatedStorage"):WaitForChild("Packages")
--services 
--packages
local Maid = require(_Packages:WaitForChild("Maid"))
local ColdFusion = require(_Packages:WaitForChild("ColdFusion8"))
--modules
local Base = require(script.Parent.Parent:WaitForChild("Base"))

local MaterialColor = require(
    script.Parent.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("MaterialColor")
) 
local Types = require(script.Parent.Parent.Parent.Parent:WaitForChild("Types"))

local Styles = require(script.Parent.Parent.Parent.Parent:WaitForChild("Styles"))
local Enums = require(script.Parent.Parent.Parent.Parent:WaitForChild("Enums"))

--types
type Maid = Maid.Maid

type Fuse = ColdFusion.Fuse
type State<T> = ColdFusion.State<T>
type ValueState<T> = ColdFusion.ValueState<T>
type CanBeState<T> = ColdFusion.CanBeState<T>

type AppearanceData = Types.AppearanceData
type TypographyData = Types.TypographyData
type TransitionData = Types.TransitionData

--constants
local DEFAULT_COLOR = Color3.fromRGB(200,200,200)
--variables
local TokenStates = {
    
}
--references
--local functions
--class
local interface = {}

interface.ColdFusion = {}
function interface.ColdFusion.new(
    maid : Maid,
    text : CanBeState<string>
    )
    local _fuse = ColdFusion.fuse(maid)
    local _new = _fuse.new
    local _import = _fuse.import
    local _bind = _fuse.bind
    local _clone = _fuse.clone
    local _Computed = _fuse.Computed
    local _Value = _fuse.Value

    local state : ValueState<Enums.ButtonState>  = _Value(Enums.ButtonState.Enabled :: Enums.ButtonState) 

    local elevationState : ValueState<Enums.ElevationResting> = _Value(Enums.ElevationResting.Level0 :: Enums.ElevationResting) 
    local symmetryState : ValueState<Enums.ShapeSymmetry> = _Value(Enums.ShapeSymmetry.Full :: Enums.ShapeSymmetry)
    local styleState : ValueState<Enums.ShapeStyle> = _Value(Enums.ShapeStyle.ExtraLarge :: Enums.ShapeStyle)
    local heightState : ValueState<number> = _Value(24)

    local appearanceData = Types.createAppearanceData(
        primaryColor,
        secondaryColor,
        tertiaryColor,

        neutralColor,
        neutralVariantColor,

        elevationState,
        symmetryState,
        styleState,
        heightState
    )
    local typographyData = Types.createTypographyData(
        Styles.Typography.getTypographyTypeScales()[Enums.TypographyStyle.BodyLarge]
    )

    local primaryColorState = _import(primaryColor, DEFAULT_COLOR)
    local secondaryColorState = _import(secondaryColor, DEFAULT_COLOR)
    local tertiaryColorState = _import(tertiaryColor, DEFAULT_COLOR)

    local neutralColorState = _import(neutralColor, DEFAULT_COLOR)
    local neutralVariantColorState = _import(neutralVariantColor, DEFAULT_COLOR)

    local DynamicScheme = MaterialColor.getDynamicScheme(primaryColorState:Get(), Color3.fromRGB(164, 209, 138),Color3.fromRGB(31, 101, 194),Color3.fromRGB(255,255,255),Color3.fromRGB(255,255,255))

    local base = Base.ColdFusion.new(
        maid, 
        text,

        appearanceData,
        typographyData
    )

    local out = _bind(base)({
        Name = "Elevated",
        BackgroundColor3 = primaryColorState,
        Text = text,
    })

    return out
end

return interface