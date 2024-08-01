--!strict
local _Packages = game:GetService("ReplicatedStorage"):WaitForChild("Packages")
--services 
--packages
local Maid = require(_Packages:WaitForChild("Maid"))
local ColdFusion = require(_Packages:WaitForChild("ColdFusion8"))
--modules
local Base = require(script.Parent:WaitForChild("Base"))

local MaterialColor = require(
    script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("MaterialColor")
) 
local Types = require(script.Parent.Parent.Parent:WaitForChild("Types"))
local Icons = require(script.Parent.Parent.Parent:WaitForChild("Icons"))

local Styles = require(script.Parent.Parent.Parent:WaitForChild("Styles"))
local Enums = require(script.Parent.Parent.Parent:WaitForChild("Enums"))

local DynamicTheme = require(script.Parent.Parent:WaitForChild("dynamic_theme"))
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
    isSelected : State<boolean>,
    onClick: () -> (), 

    isDark : CanBeState<boolean>?,
    height : CanBeState<number>?)

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
                Enums.ElevationResting.Level3 
            elseif _buttonState == Enums.ButtonState.Hovered then
                Enums.ElevationResting.Level4
            elseif _buttonState == Enums.ButtonState.Focused then 
                Enums.ElevationResting.Level3
            elseif _buttonState == Enums.ButtonState.Pressed then
                Enums.ElevationResting.Level3
            else Enums.ElevationResting.Level3,

            Enums.ShapeSymmetry.Full,
            Enums.ShapeStyle.Medium,
            _height,

            dark
        )
    end, isDarkState, buttonState, heightState)
    
    local iconColorState =  _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState, selected : boolean)
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
        local onSurfaceVariant = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurfaceVariant())

        return if (selected == true ) then 
            (if _buttonState == Enums.ButtonState.Enabled then ( primary)
                elseif _buttonState == Enums.ButtonState.Disabled then onSurface
                elseif _buttonState == Enums.ButtonState.Hovered then (primary)    
                elseif _buttonState == Enums.ButtonState.Focused then (primary) 
                elseif _buttonState == Enums.ButtonState.Pressed then (primary)
            else primary) 
        else  (if _buttonState == Enums.ButtonState.Enabled then ( onSurfaceVariant)
            elseif _buttonState == Enums.ButtonState.Disabled then onSurface 
            elseif _buttonState == Enums.ButtonState.Hovered then ( onSurface)    
            elseif _buttonState == Enums.ButtonState.Focused then (onSurface)
            elseif _buttonState == Enums.ButtonState.Pressed then (onSurface)
        else onSurface) 
    end, appearanceDataState, buttonState, isSelected)


    local stateLayerColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState, selected : boolean)
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
        local errorColor = MaterialColor.Color3FromARGB(dynamicScheme:get_error())

        return if (selected == true ) then (primary) 
        else onSurface 
    end, appearanceDataState, buttonState, isSelected)

    local iconId = _Computed(function(selected : boolean) 
        return if selected == true then Icons.toggle.radio_button_checked else Icons.toggle.radio_button_unchecked 
    end, isSelected) 
    local base = _bind(Base.ColdFusion.new(
        maid, 

        stateLayerColorState:Tween(),

        appearanceDataState, 

        buttonState,
        true,
        onClick,

        iconId, 
        iconColorState:Tween(),
        _Computed(function(_buttonState : Enums.ButtonState)
            return (if _buttonState == Enums.ButtonState.Pressed then 
                    0.1
                elseif _buttonState == Enums.ButtonState.Focused then 
                   0.1
                elseif _buttonState == Enums.ButtonState.Hovered then
                    0.08
            else 0)
        end, buttonState)
    ))({
        Children = {
            _new("UIAspectRatioConstraint")({
                AspectRatio = 1
            })
        }
    })

    return base :: TextButton
end

return interface