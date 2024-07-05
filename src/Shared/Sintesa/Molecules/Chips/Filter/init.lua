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
local Icons = require(script.Parent.Parent.Parent:WaitForChild("Icons"))

local Styles = require(script.Parent.Parent.Parent:WaitForChild("Styles"))
local Enums = require(script.Parent.Parent.Parent:WaitForChild("Enums"))

local DynamicTheme = require(script.Parent.Parent:WaitForChild("dynamic_theme"))

local TextLabel = require(script.Parent.Parent:WaitForChild("Util"):WaitForChild("TextLabel"))
local ImageLabel = require(script.Parent.Parent:WaitForChild("Util"):WaitForChild("ImageLabel"))
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
type IconData = Types.IconData
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
    isSelected : CanBeState<boolean>,

    leadingIcon : CanBeState<number | IconData>,
    trailingIcon : CanBeState<number | IconData>?,

    shapeStyle : CanBeState<Enums.ShapeStyle>?)
    
    local _fuse = ColdFusion.fuse(maid)
    local _new = _fuse.new
    local _import = _fuse.import
    local _bind = _fuse.bind
    local _clone = _fuse.clone
    local _Computed = _fuse.Computed
    local _Value = _fuse.Value


    local isDarkState = _import(isDark, false)
    local textState = _import(text, text)

    local isSelectedState = _import(isSelected, isSelected)

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
        local onSurfaceVariant = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurfaceVariant())
            
        return if not selected then(if _buttonState == Enums.ButtonState.Enabled then outline 
                elseif _buttonState == Enums.ButtonState.Disabled then onSurface
                elseif _buttonState == Enums.ButtonState.Focused then onSurfaceVariant
            else outline)
        else outline
    end, appearanceDataState, buttonState, isSelectedState)

    local labelTextColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState, selected : boolean)
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
            
        return 
            if selected then  (if _buttonState == Enums.ButtonState.Enabled then onSecondaryContainer
                    elseif _buttonState == Enums.ButtonState.Disabled then onSurface 
                    elseif _buttonState == Enums.ButtonState.Hovered then onSecondaryContainer
                    elseif _buttonState == Enums.ButtonState.Focused then onSecondaryContainer
                    elseif _buttonState == Enums.ButtonState.Pressed then onSecondaryContainer
                    elseif _buttonState == Enums.ButtonState.Dragged then onSecondaryContainer
                else onSecondaryContainer)
            else (if _buttonState == Enums.ButtonState.Enabled then onSurfaceVariant
                elseif _buttonState == Enums.ButtonState.Disabled then onSurface 
                elseif _buttonState == Enums.ButtonState.Hovered then onSurfaceVariant
                elseif _buttonState == Enums.ButtonState.Focused then onSurfaceVariant
                elseif _buttonState == Enums.ButtonState.Pressed then onSurfaceVariant
                elseif _buttonState == Enums.ButtonState.Dragged then onSurfaceVariant
            else onSurfaceVariant)

        
    end, appearanceDataState, buttonState, isSelectedState)

    local containerColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState, selected : boolean)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        --local surfaceContainerLow = MaterialColor.Color3FromARGB(dynamicScheme:get_surfaceContainerLow())
        local secondaryContainer = MaterialColor.Color3FromARGB(dynamicScheme:get_secondaryContainer())
        local surfaceContainerLow = MaterialColor.Color3FromARGB(dynamicScheme:get_surfaceContainerLow())

        local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())

        return if selected then  (if _buttonState == Enums.ButtonState.Enabled then secondaryContainer 
                elseif _buttonState == Enums.ButtonState.Disabled then onSurface    
            else secondaryContainer)
        else
            (if _buttonState == Enums.ButtonState.Enabled then surfaceContainerLow 
                elseif _buttonState == Enums.ButtonState.Disabled then onSurface    
            else surfaceContainerLow)
    end, appearanceDataState, buttonState, isSelectedState)

    local stateLayerColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState, selected : boolean)
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

    local trailingIconState = _import(trailingIcon, trailingIcon)
    local leadingIconColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState, selected : boolean, icon : number? | IconData?)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local primary = MaterialColor.Color3FromARGB(dynamicScheme:get_primary())
        local onSecondaryContainer = MaterialColor.Color3FromARGB(dynamicScheme:get_onSecondaryContainer())
        local onSurfaceVariant = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurfaceVariant())

        local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())
            
        return 
            if selected then (if _buttonState == Enums.ButtonState.Enabled then (if trailingIcon then onSecondaryContainer else onSecondaryContainer)
                    elseif _buttonState == Enums.ButtonState.Disabled then onSurface 
                    elseif _buttonState == Enums.ButtonState.Hovered then (if trailingIcon then onSecondaryContainer else onSecondaryContainer)
                    elseif _buttonState == Enums.ButtonState.Focused then onSecondaryContainer
                    elseif _buttonState == Enums.ButtonState.Pressed then onSecondaryContainer
                    elseif _buttonState == Enums.ButtonState.Dragged then onSecondaryContainer
                else primary) 
            else (if _buttonState == Enums.ButtonState.Enabled then (if trailingIcon then primary else onSurfaceVariant)
                elseif _buttonState == Enums.ButtonState.Disabled then onSurface 
                elseif _buttonState == Enums.ButtonState.Hovered then (if trailingIcon then primary else onSurfaceVariant)
                elseif _buttonState == Enums.ButtonState.Focused then (if trailingIcon then primary else onSurfaceVariant)
                elseif _buttonState == Enums.ButtonState.Pressed then (if trailingIcon then primary else onSurfaceVariant)
                elseif _buttonState == Enums.ButtonState.Dragged then (if trailingIcon then primary else onSurfaceVariant)
            else onSurfaceVariant) 
    end, appearanceDataState, buttonState, isSelectedState, trailingIconState)

    local trailingIconColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState, selected : boolean)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local primary = MaterialColor.Color3FromARGB(dynamicScheme:get_primary())
        local onSecondaryContainer = MaterialColor.Color3FromARGB(dynamicScheme:get_onSecondaryContainer())
        local onSurfaceVariant = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurfaceVariant())

        local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())
            
        return 
            if selected then (if _buttonState == Enums.ButtonState.Enabled then onSecondaryContainer
                    elseif _buttonState == Enums.ButtonState.Disabled then onSurface 
                    elseif _buttonState == Enums.ButtonState.Hovered then onSecondaryContainer
                    elseif _buttonState == Enums.ButtonState.Focused then onSecondaryContainer
                    elseif _buttonState == Enums.ButtonState.Pressed then onSecondaryContainer
                    elseif _buttonState == Enums.ButtonState.Dragged then primary
                else onSecondaryContainer) 
            else (if _buttonState == Enums.ButtonState.Enabled then onSurfaceVariant
                elseif _buttonState == Enums.ButtonState.Disabled then onSurface 
                elseif _buttonState == Enums.ButtonState.Hovered then onSurfaceVariant
                elseif _buttonState == Enums.ButtonState.Focused then onSurfaceVariant
                elseif _buttonState == Enums.ButtonState.Pressed then onSurfaceVariant
                elseif _buttonState == Enums.ButtonState.Dragged then primary
            else onSurfaceVariant) 
    end, appearanceDataState, buttonState, isSelectedState)
    
    local opacityState = _Computed(function(_buttonState : Enums.ButtonState, selected : boolean)
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
        leadingIcon,
        --Icons.image.image,
        leadingIconColorState,
        opacityState,
        labelTextColorState
    )
     
    local canvasGroup = base:FindFirstChild("CanvasGroup")
    local mainFrame = if canvasGroup then canvasGroup:FindFirstChild("Main") else nil

    local trailingImage = _bind(ImageLabel.ColdFusion.new(
        maid,

        3,
        trailingIcon,
        --Icons.navigation.close,

        trailingIconColorState
    ))({
        Parent = mainFrame,
        Size = _Computed(function(appearance : AppearanceData, _text : string?)
            return if text then UDim2.new(0, appearance.Height/2, 0 ,appearance.Height/2) else UDim2.new(0, appearance.Height, 0 ,appearance.Height)
        end, appearanceDataState, textState),
        Children = {
            _new("UIAspectRatioConstraint")({
                AspectRatio = 1
            })
        }
    })

    _new("UIStroke")({
        Parent = mainFrame,
        Thickness = _Computed(function(selected : boolean)
            return if selected then 0 else 1
        end, isSelectedState),
        Color = outlineColorState,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Transparency = _Computed(function(_buttonState : Enums.ButtonState)
            return if _buttonState == Enums.ButtonState.Enabled then 1 - 1 
                elseif Enums.ButtonState.Disabled then 1 - 0.12 
            else 1
        end, buttonState)
    })
    return base
end
return interface