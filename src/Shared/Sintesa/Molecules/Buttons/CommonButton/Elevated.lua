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

local DynamicTheme = require(script.Parent.Parent.Parent:WaitForChild("dynamic_theme"))
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
    text : CanBeState<string>,

    isDark : CanBeState<boolean>?,
    textSize : CanBeState<number>?
    )
    local _fuse = ColdFusion.fuse(maid)
    local _new = _fuse.new
    local _import = _fuse.import
    local _bind = _fuse.bind
    local _clone = _fuse.clone
    local _Computed = _fuse.Computed
    local _Value = _fuse.Value

    local buttonState : ValueState<Enums.ButtonState>  = _Value(Enums.ButtonState.Enabled :: Enums.ButtonState) 

    local elevationState : ValueState<Enums.ElevationResting> = _Value(Enums.ElevationResting.Level0 :: Enums.ElevationResting) 
    local symmetryState : ValueState<Enums.ShapeSymmetry> = _Value(Enums.ShapeSymmetry.Full :: Enums.ShapeSymmetry)
    local styleState : ValueState<Enums.ShapeStyle> = _Value(Enums.ShapeStyle.ExtraLarge :: Enums.ShapeStyle)
    local heightState : ValueState<number> = _Value(24)

    local primaryColorState = _import(DynamicTheme.Color[Enums.ColorRole.Primary], DEFAULT_COLOR)
    local secondaryColorState = _import(DynamicTheme.Color[Enums.ColorRole.Secondary], DEFAULT_COLOR)
    local tertiaryColorState = _import(DynamicTheme.Color[Enums.ColorRole.Tertiary], DEFAULT_COLOR)
    
    local neutralColorState = _import(DynamicTheme.Color[Enums.ColorRole.Surface], DEFAULT_COLOR)
    local neutralVariantColorState = _import(DynamicTheme.Color[Enums.ColorRole.SurfaceDim], DEFAULT_COLOR)
    local shadowColorState = _import(DynamicTheme.Color[Enums.ColorRole.SurfaceDim], DEFAULT_COLOR)

    local isDarkState = _import(isDark, isDark)

    local appearanceDataState = _Value(Types.createAppearanceData(
        DynamicTheme.Color[Enums.ColorRole.Primary],
        DynamicTheme.Color[Enums.ColorRole.Secondary],
        DynamicTheme.Color[Enums.ColorRole.Tertiary],

        DynamicTheme.Color[Enums.ColorRole.Surface],
        DynamicTheme.Color[Enums.ColorRole.SurfaceDim],
        DynamicTheme.Color[Enums.ColorRole.SurfaceDim],

        Enums.ElevationResting.Level0,
        Enums.ShapeSymmetry.Full,
        Enums.ShapeStyle.ExtraLarge,
        24,

        isDarkState:Get()
    ))

    _Computed(function(dark : boolean)
        appearanceDataState:Set(Types.createAppearanceData(
            DynamicTheme.Color[Enums.ColorRole.Primary],
            DynamicTheme.Color[Enums.ColorRole.Secondary],
            DynamicTheme.Color[Enums.ColorRole.Tertiary],
    
            DynamicTheme.Color[Enums.ColorRole.Surface],
            DynamicTheme.Color[Enums.ColorRole.SurfaceDim],
            DynamicTheme.Color[Enums.ColorRole.SurfaceDim],
    
            Enums.ElevationResting.Level0,
            Enums.ShapeSymmetry.Full,
            Enums.ShapeStyle.ExtraLarge,
            24,
    
            dark
        ))
        return isDarkState
    end)
    
    --[[local typographyDataState = _Value(Types.createTypographyData(
        Styles.Typography.getTypographyTypeScales()[Enums.TypographyStyle.BodyLarge]
    ))]]
   -- local appearanceDataState = _import(appearanceData, appearanceData)
    local typographyDataState = _Value(Types.createTypographyData(
        {
            Font = Enum.Font.Roboto,
            LineHeight = 40, 
            Size = ,
            Tracking = ,
            Weight = ,
        }
    ))

    local base = Base.ColdFusion.new(
        maid, 
        text,

        appearanceDataState,
        typographyDataState,

        buttonState
    )

    local out = _bind(base)({
        Name = "Elevated",
        BackgroundColor3 = _Computed(function(appearance : AppearanceData, _state : Enums.ButtonState)
            return  MaterialColor.Color3FromARGB(MaterialColor.getDynamicScheme(
                appearance.PrimaryColor, 
                appearance.SecondaryColor, 
                appearance.TertiaryColor, 
                appearance.NeutralColor, 
                appearance.NeutralVariantColor
            ):get_surfaceContainerLow())
            
        end, appearanceDataState, buttonState),
        TextColor3 = _Computed(function(appearance : AppearanceData, _state : Enums.ButtonState)
            return MaterialColor.Color3FromARGB(MaterialColor.getDynamicScheme(
                appearance.PrimaryColor, 
                appearance.SecondaryColor, 
                appearance.TertiaryColor, 
                appearance.NeutralColor, 
                appearance.NeutralVariantColor
            ):get_primary())
        end, appearanceDataState),
    })

    return out
end

return interface