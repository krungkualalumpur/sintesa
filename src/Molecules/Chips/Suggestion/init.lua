--!strict
local _Packages = game:GetService("ReplicatedStorage"):WaitForChild("Packages")
--services 
--packages
local Maid = require(_Packages:WaitForChild("Maid"))
local ColdFusion = require(_Packages:WaitForChild("ColdFusion8"))
--modules
local MaterialColor = require(
    script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("MaterialColor")
) 
local Types = require(script.Parent.Parent.Parent:WaitForChild("Types"))

local Styles = require(script.Parent.Parent.Parent:WaitForChild("Styles"))
local Enums = require(script.Parent.Parent.Parent:WaitForChild("Enums"))

local DynamicTheme = require(script.Parent.Parent:WaitForChild("dynamic_theme"))

local TextLabel = require(script.Parent.Parent:WaitForChild("Util"):WaitForChild("TextLabel"))
local StandardIconButton = require(script.Parent.Parent:WaitForChild("Buttons"):WaitForChild("IconButton"):WaitForChild("Standard"))
local ButtonBase =  require(script.Parent.Parent:WaitForChild("Buttons"):WaitForChild("Base"))

--types
type Maid = Maid.Maid

type Fuse = ColdFusion.Fuse
type State<T> = ColdFusion.State<T>
type ValueState<T> = ColdFusion.ValueState<T>
type CanBeState<T> = ColdFusion.CanBeState<T>

type AppearanceData = Types.AppearanceData
type TypographyData = Types.TypographyData
type TransitionData = Types.TransitionData

type ButtonData = Types.ButtonData
--constants
--remotes
--variables
--references
--local functions
--class
local interface = {}
interface.ColdFusion = {}

function interface.ColdFusion.new(
    maid : Maid,
    text : CanBeState<string>,
    onClick : () -> (),
    isDark : CanBeState<boolean>,
    shapeStyle : CanBeState<Enums.ShapeStyle>?)
    
    local _fuse = ColdFusion.fuse(maid)
    local _new = _fuse.new
    local _import = _fuse.import
    local _bind = _fuse.bind
    local _clone = _fuse.clone
    local _Computed = _fuse.Computed
    local _Value = _fuse.Value


    local isDarkState = _import(isDark, false)

    local isSelectedState = _Value(false :: boolean?)

    local shapeStyleState = _import(shapeStyle, Enums.ShapeStyle.Small :: Enums.ShapeStyle)

    local buttonState = _Value(Enums.ButtonState.Enabled :: Enums.ButtonState)

    local appearanceDataState = _Computed(
        function(
            dark : boolean,
            _buttonState : Enums.ButtonState,
            shapeStyle : Enums.ShapeStyle
        ) 
           
        return Types.createAppearanceData(
            DynamicTheme.Color[Enums.ColorRole.Primary],
            DynamicTheme.Color[Enums.ColorRole.Secondary],
            DynamicTheme.Color[Enums.ColorRole.Tertiary],

            DynamicTheme.Color[Enums.ColorRole.Surface],
            DynamicTheme.Color[Enums.ColorRole.SurfaceDim],
            DynamicTheme.Color[Enums.ColorRole.Shadow],
            
            if _buttonState == Enums.ButtonState.Enabled then Enums.ElevationResting.Level1 
                elseif _buttonState == Enums.ButtonState.Disabled then Enums.ElevationResting.Level0
                elseif _buttonState == Enums.ButtonState.Hovered then Enums.ElevationResting.Level2
                elseif _buttonState == Enums.ButtonState.Focused then Enums.ElevationResting.Level1
                elseif _buttonState == Enums.ButtonState.Pressed then Enums.ElevationResting.Level1
                elseif _buttonState == Enums.ButtonState.Dragged then Enums.ElevationResting.Level4
            else Enums.ElevationResting.Level1,

            Enums.ShapeSymmetry.Full,
            shapeStyle,
            32,

            dark
        )
    end, isDarkState, buttonState, shapeStyleState)

    local labelTextColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState, selected : boolean?)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local onSurfaceVariant = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurfaceVariant())
        local onSecondaryContainer = MaterialColor.Color3FromARGB(dynamicScheme:get_onSecondaryContainer())
        local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())
            
        return if selected == nil then 
            (if _buttonState == Enums.ButtonState.Enabled then onSurfaceVariant
                elseif _buttonState == Enums.ButtonState.Disabled then onSurface 
                elseif _buttonState == Enums.ButtonState.Hovered then onSurfaceVariant
                elseif _buttonState == Enums.ButtonState.Focused then onSurfaceVariant
                elseif _buttonState == Enums.ButtonState.Pressed then onSurfaceVariant
                elseif _buttonState == Enums.ButtonState.Dragged then onSurfaceVariant
            else onSurfaceVariant)
        else (if selected == true then
            onSecondaryContainer
        else
            onSurface
        )
    end, appearanceDataState, buttonState, isSelectedState)

    local outlineColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState, selected : boolean?)
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
        local onSurfaceVariant = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurfaceVariant())
            
        return if _buttonState == Enums.ButtonState.Enabled then outline 
            elseif _buttonState == Enums.ButtonState.Disabled then onSurface
            elseif _buttonState == Enums.ButtonState.Focused then onSurfaceVariant
        else outline    
    end, appearanceDataState, buttonState, isSelectedState)

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

    local stateLayerColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState, selected : boolean?)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local onSurfaceVariant = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurfaceVariant())

        local onSecondaryContainer = MaterialColor.Color3FromARGB(dynamicScheme:get_onSecondaryContainer())

        local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())
            
        return  onSurfaceVariant
      
    end, appearanceDataState, buttonState, isSelectedState)

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

    local opacityState = _Computed(function(_buttonState : Enums.ButtonState, selected : boolean?)
        return
            (if _buttonState == Enums.ButtonState.Pressed then 
                0.1
            elseif _buttonState == Enums.ButtonState.Focused then 
                0.1
            elseif _buttonState == Enums.ButtonState.Hovered then
                0.08
            elseif _buttonState == Enums.ButtonState.Dragged then
                0.16
        else 0)
    end, buttonState, isSelectedState)
    
    local base = ButtonBase.ColdFusion.new(
        maid, 
        containerColorState, 
        stateLayerColorState,
        appearanceDataState,
        typographyDataState,
        buttonState,
        true,
        onClick,
        text,
        nil,
        nil,
        opacityState,
        labelTextColorState,
        _Computed(function(_buttonState : Enums.ButtonState)
            return (if _buttonState == Enums.ButtonState.Disabled then 
                 0.12
            else 1) 
        end, buttonState)
    )

     
    local canvasGroup = base:FindFirstChild("CanvasGroup")
    local mainFrame = if canvasGroup then canvasGroup:FindFirstChild("Main") else nil

    _new("UIStroke")({
        Parent = mainFrame,
        Thickness = 1,
        Color = outlineColorState,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Transparency =  0
    })
    return base
end
return interface