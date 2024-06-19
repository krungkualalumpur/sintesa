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
--variables
--references
--local functions
--class
local interface = {}

interface.ColdFusion = {}
function interface.ColdFusion.new(
    maid : Maid,
    iconId : CanBeState<number>,
    isSelected : State<boolean>,
    onClick: () -> (), 

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

    local isDarkState = _import(isDark, false)

    local appearanceDataState = _Computed(
        function(
            dark : boolean,
            _buttonState : Enums.ButtonState
        ) 
           
        return Types.createAppearanceData(
            DynamicTheme.Color[Enums.ColorRole.Primary],
            DynamicTheme.Color[Enums.ColorRole.Secondary],
            DynamicTheme.Color[Enums.ColorRole.Tertiary],

            DynamicTheme.Color[Enums.ColorRole.Surface],
            DynamicTheme.Color[Enums.ColorRole.SurfaceDim],
            DynamicTheme.Color[Enums.ColorRole.Shadow],
 
            Enums.ElevationResting.Level0,

            Enums.ShapeSymmetry.Full,
            Enums.ShapeStyle.Full,
            40,

            dark
        )
    end, isDarkState, buttonState)
   
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

    
    local containerColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState, selected : boolean)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local secondaryContainer = MaterialColor.Color3FromARGB(dynamicScheme:get_secondaryContainer())
        local surfaceContainerHighest = MaterialColor.Color3FromARGB(dynamicScheme:get_surfaceContainerHighest())
        local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())

        return if selected then (if _buttonState == Enums.ButtonState.Enabled then 
            secondaryContainer elseif _buttonState == Enums.ButtonState.Disabled then onSurface 
        else secondaryContainer) else 
            (if _buttonState ==  Enums.ButtonState.Enabled then surfaceContainerHighest     
            elseif _buttonState == Enums.ButtonState.Disabled then onSurface 
        else surfaceContainerHighest)
    end, appearanceDataState, buttonState, isSelected)

    local iconColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState, selected : boolean)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local onSecondaryContainer = MaterialColor.Color3FromARGB(dynamicScheme:get_onSecondaryContainer())
        local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())
        local onSurfaceVariant = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurfaceVariant())

        return if selected then (if _buttonState == Enums.ButtonState.Enabled then onSecondaryContainer 
            elseif _buttonState == Enums.ButtonState.Disabled then onSurface 
        else onSecondaryContainer) else  (if _buttonState == Enums.ButtonState.Enabled then onSurfaceVariant 
            elseif _buttonState == Enums.ButtonState.Disabled then onSurface 
        else onSurfaceVariant)
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
        local onSecondaryContainer = MaterialColor.Color3FromARGB(dynamicScheme:get_onSecondaryContainer())
        local onSurfaceVariant = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurfaceVariant())

        return if selected then (if _buttonState == Enums.ButtonState.Hovered then onSecondaryContainer 
            elseif _buttonState == Enums.ButtonState.Focused then onSecondaryContainer 
            elseif _buttonState == Enums.ButtonState.Pressed then onSecondaryContainer
        else onSecondaryContainer) else (if _buttonState == Enums.ButtonState.Hovered then onSurfaceVariant 
            elseif _buttonState == Enums.ButtonState.Focused then onSurfaceVariant 
            elseif _buttonState == Enums.ButtonState.Pressed then onSurfaceVariant 
        else onSurfaceVariant) 
    end, appearanceDataState, buttonState, isSelected)

    local out = _bind(Base.ColdFusion.new(
        maid, 

        containerColorState,
        stateLayerColorState,

        appearanceDataState, 
        typographyDataState,

        buttonState,
        false,
        
        onClick,
        nil,
        iconId, 
        iconColorState,
        _Computed(function(_buttonState : Enums.ButtonState)
            return (if _buttonState == Enums.ButtonState.Pressed then 
                (1  - 0.1)
                elseif _buttonState == Enums.ButtonState.Focused then 
                    (1 - 0.1)
                elseif _buttonState == Enums.ButtonState.Hovered then
                    (1 - 0.08)
            else 1)
        end, buttonState)
    ))({
        Children = {
            _new("UIAspectRatioConstraint")({
                AspectRatio = 1
            })
        }
    })

    return out :: TextButton
end

return interface