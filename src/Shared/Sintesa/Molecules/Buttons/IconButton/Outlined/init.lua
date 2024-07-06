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
    iconId : CanBeState<number | IconData>,
    isSelected : State<boolean>,
    onClick: () -> (), 

    isDark : CanBeState<boolean>?,
    height : CanBeState<number>?,
    badge : CanBeState<number | string | boolean>?)

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
 
            Enums.ElevationResting.Level0,

            Enums.ShapeSymmetry.Full,
            Enums.ShapeStyle.Full,
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

    local containerColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState, selected : boolean)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local inverseSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_inverseSurface())
        local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())

        return if selected then (if _buttonState == Enums.ButtonState.Enabled then 
            inverseSurface elseif _buttonState == Enums.ButtonState.Disabled then onSurface 
        else inverseSurface) else inverseSurface
    end, appearanceDataState, buttonState, isSelected)

    local outlineColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState, selected : boolean)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor,  
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local outline = MaterialColor.Color3FromARGB(dynamicScheme:get_outline())
        local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())

        return if selected then outline else 
            (if _buttonState ==  Enums.ButtonState.Enabled then outline     
            elseif _buttonState == Enums.ButtonState.Disabled then onSurface 
        else outline)
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
        local inverseOnSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_inverseOnSurface())
        local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())
        local onSurfaceVariant = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurfaceVariant())

        return if selected then (if _buttonState == Enums.ButtonState.Enabled then inverseOnSurface 
            elseif _buttonState == Enums.ButtonState.Disabled then onSurface 
            elseif _buttonState == Enums.ButtonState.Pressed then inverseOnSurface
        else inverseOnSurface) else  (if _buttonState == Enums.ButtonState.Enabled then onSurfaceVariant 
            elseif _buttonState == Enums.ButtonState.Disabled then onSurface 
            elseif _buttonState == Enums.ButtonState.Pressed then onSurface
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
        local inverseOnSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_inverseOnSurface())
        local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())
        local onSurfaceVariant = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurfaceVariant())

        return if selected then (if _buttonState == Enums.ButtonState.Hovered then inverseOnSurface 
            elseif _buttonState == Enums.ButtonState.Focused then inverseOnSurface 
            elseif _buttonState == Enums.ButtonState.Pressed then inverseOnSurface
        else inverseOnSurface) else (if _buttonState == Enums.ButtonState.Hovered then inverseOnSurface 
            elseif _buttonState == Enums.ButtonState.Focused then onSurfaceVariant 
            elseif _buttonState == Enums.ButtonState.Pressed then onSurface 
        else onSurfaceVariant) 
    end, appearanceDataState, buttonState, isSelected)

    local base = _bind(Base.ColdFusion.new(
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
                0.1
                elseif _buttonState == Enums.ButtonState.Focused then 
                    0.08
                elseif _buttonState == Enums.ButtonState.Hovered then
                    0.08
            else 0)
        end, buttonState),
        nil,
        _Computed(function(selected : boolean)
            return if selected then 1 else 0
        end, isSelected),
        badge
    ))({
        Children = {
            _new("UIAspectRatioConstraint")({
                AspectRatio = 1
            })
        }
    })

    local canvasGroup = base:FindFirstChild("CanvasGroup")
    local mainFrame = if canvasGroup then canvasGroup:FindFirstChild("Main") else nil

    _new("UIStroke")({
        Name = "Shadow",
        Enabled = _Computed(function(selected : boolean)
            return not selected
        end, isSelected),
        Parent = mainFrame,
        Thickness = 1,
        Color = outlineColorState,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Transparency =  0
    })
    

    return base :: TextButton
end

return interface