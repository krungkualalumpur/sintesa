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

type IconData = Types.IconData
--constants
--variables
--references
--local functions
--class
local interface = {}

interface.ColdFusion = {}
function interface.ColdFusion.new(
    maid : Maid,
    text : CanBeState<string>,
    onClick: () -> (), 

    isDark : CanBeState<boolean>?,
    height : CanBeState<number>?,
    iconId : CanBeState<number | IconData?>?)
    local _fuse = ColdFusion.fuse(maid)
    local _new = _fuse.new
    local _import = _fuse.import
    local _bind = _fuse.bind
    local _clone = _fuse.clone
    local _Computed = _fuse.Computed
    local _Value = _fuse.Value

    local buttonState : ValueState<Enums.ButtonState>  = _Value(Enums.ButtonState.Enabled :: Enums.ButtonState) 

    local isDarkState = _import(isDark, false)
    local heightState = _import(height, 40)

    local appearanceDataState = _Computed(
        function(
            dark : boolean,
            _buttonState : Enums.ButtonState,
            _height : number
        ) 
           
        return Types.createAppearanceData(
            DynamicTheme.Color[Enums.ColorRole.Primary],
            DynamicTheme.Color[Enums.ColorRole.Secondary],
            DynamicTheme.Color[Enums.ColorRole.Tertiary],

            DynamicTheme.Color[Enums.ColorRole.Surface],
            DynamicTheme.Color[Enums.ColorRole.SurfaceDim],
            DynamicTheme.Color[Enums.ColorRole.Shadow],
 
            if _buttonState == Enums.ButtonState.Enabled then 
                Enums.ElevationResting.Level1 
            elseif _buttonState == Enums.ButtonState.Disabled then
                Enums.ElevationResting.Level0 
            elseif _buttonState == Enums.ButtonState.Hovered then
                Enums.ElevationResting.Level2 
            elseif _buttonState == Enums.ButtonState.Focused then 
                Enums.ElevationResting.Level1 
            elseif _buttonState == Enums.ButtonState.Pressed then
                Enums.ElevationResting.Level1
            else Enums.ElevationResting.Level0,

            Enums.ShapeSymmetry.Full,
            Enums.ShapeStyle.ExtraLarge,
            _height,

            dark
        )
    end, isDarkState, buttonState, heightState)
   
    local labelLarge = Styles.Typography.get(Enums.TypographyStyle.LabelLarge)
    local typographyDataState = _Value(Types.createTypographyData(
        {
            Font = labelLarge.Font,
            LineHeight = labelLarge.LineHeight, 
            Size = labelLarge.Size,
            Tracking = labelLarge.Tracking,
            Weight = labelLarge.Weight,
        }
    ))

    
    local containerColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local surfaceContainerLow = MaterialColor.Color3FromARGB(dynamicScheme:get_surfaceContainerLow())
        local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())

        return (if _buttonState == Enums.ButtonState.Enabled then surfaceContainerLow 
            elseif _buttonState == Enums.ButtonState.Disabled then onSurface
        else surfaceContainerLow)
    end, appearanceDataState, buttonState)

    local labelTextColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local primary = MaterialColor.Color3FromARGB(dynamicScheme:get_primary())
        local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())
            
        return if _buttonState == Enums.ButtonState.Enabled then primary elseif _buttonState == Enums.ButtonState.Disabled then onSurface else primary
    end, appearanceDataState, buttonState)

    local stateLayerColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local onPrimary = MaterialColor.Color3FromARGB(dynamicScheme:get_onPrimary())

        local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())
        
        return if _buttonState == Enums.ButtonState.Enabled then onPrimary elseif _buttonState == Enums.ButtonState.Disabled then onSurface elseif _buttonState == Enums.ButtonState.Hovered then onPrimary else onPrimary -- primary
    end, appearanceDataState, buttonState)

    local out = Base.ColdFusion.new(
        maid, 

        containerColorState,
        stateLayerColorState,

        appearanceDataState, 
        typographyDataState,

        buttonState,
        true,

        onClick, 
        text,
        iconId, 
        labelTextColorState,
        _Computed(function(_buttonState : Enums.ButtonState)
            return (if _buttonState == Enums.ButtonState.Pressed then 
                 0.1
                elseif _buttonState == Enums.ButtonState.Focused then 
                     0.1
                elseif _buttonState == Enums.ButtonState.Hovered then
                    0.08
            else 0)
        end, buttonState),

        labelTextColorState,
        _Computed(function(_buttonState : Enums.ButtonState)
            return (if _buttonState == Enums.ButtonState.Disabled then 
                 0.12
            else 1) 
        end, buttonState)
    )

    return out
end

return interface