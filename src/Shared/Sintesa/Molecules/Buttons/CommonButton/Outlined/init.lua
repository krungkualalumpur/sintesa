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
    iconId : CanBeState<number | IconData?>?,
    isSelected : CanBeState<boolean?>,
    shapeStyle : CanBeState<Enums.ShapeStyle?>, 

    appearenceData : CanBeState<AppearanceData> ?,
    typographyData : CanBeState<TypographyData> ?,
    
    givenOutlineColorState : State<Color3>?,
    givenTextColorState : State<Color3>?,

    state : ValueState<Enums.ButtonState> ?)
    local _fuse = ColdFusion.fuse(maid)
    local _new = _fuse.new
    local _import = _fuse.import
    local _bind = _fuse.bind
    local _clone = _fuse.clone
    local _Computed = _fuse.Computed
    local _Value = _fuse.Value

    local buttonState : ValueState<Enums.ButtonState>  = state or _Value(Enums.ButtonState.Enabled :: Enums.ButtonState)  

    local isDarkState = _import(isDark, false)

    local isSelectedState = _import(isSelected, isSelected)

    local shapeStyleState = _import(shapeStyle, Enums.ShapeStyle.ExtraLarge :: Enums.ShapeStyle)

    local height = _import(height, 40)

    local appearanceDataState = _import(appearenceData, _Computed(
        function(
            dark : boolean,
            _buttonState : Enums.ButtonState,
            shapeStyle : Enums.ShapeStyle,
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
            shapeStyle,
            _height,

            dark
        )
    end, isDarkState, buttonState, shapeStyleState))
   
    local labelLarge = Styles.Typography.get(Enums.TypographyStyle.LabelLarge)
    local typographyDataState = _import(typographyData, Types.createTypographyData(
        {
            Font = labelLarge.Font,
            LineHeight = labelLarge.LineHeight,  
            Size = labelLarge.Size,
            Tracking = labelLarge.Tracking,
            Weight = labelLarge.Weight,
        }
    )) 
    
    local outlineColorState = _import(givenOutlineColorState,  _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState, selected : boolean?)
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
        local primary = MaterialColor.Color3FromARGB(dynamicScheme:get_primary())
        local secondaryContainer = MaterialColor.Color3FromARGB(dynamicScheme:get_secondaryContainer())

        return if selected == nil then (if _buttonState == Enums.ButtonState.Enabled then outline 
            elseif _buttonState == Enums.ButtonState.Disabled then onSurface
            elseif _buttonState == Enums.ButtonState.Focused then primary
        else outline) else (
            secondaryContainer
        )
    end, appearanceDataState, buttonState, isSelectedState))

    local labelTextColorState = _import(givenTextColorState, _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState, selected : boolean?)
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
        local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())
            
        return if selected == nil then 
            (if _buttonState == Enums.ButtonState.Enabled then primary elseif _buttonState == Enums.ButtonState.Disabled then onSurface else primary)
        else (if selected == true then
            onSecondaryContainer
        else
            onSurface
        )
    end, appearanceDataState, buttonState, isSelectedState))

    local stateLayerColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState, selected : boolean?)
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

        local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())
            
        return if selected == nil then 
            (if _buttonState == Enums.ButtonState.Hovered then primary elseif _buttonState == Enums.ButtonState.Disabled then onSurface else primary) 
        else
            (if selected == true then
                (onSecondaryContainer) 
            else (onSurface)) 
    end, appearanceDataState, buttonState, isSelectedState)

    local opacityState = _Computed(function(_buttonState : Enums.ButtonState, selected : boolean?)
        return
            (if _buttonState == Enums.ButtonState.Enabled then 
                if selected == true then
                    0.1
                else
                    0
            elseif _buttonState == Enums.ButtonState.Pressed then 
            0.1
            elseif _buttonState == Enums.ButtonState.Focused then 
                0.1
            elseif _buttonState == Enums.ButtonState.Hovered then
                0.08
        else 0)
    end, buttonState, isSelectedState)

    local constantBackground = _Computed(function()
        return Color3.fromRGB(255,255,255)
    end)
    

    local base = Base.ColdFusion.new(
        maid, 

        constantBackground,
        stateLayerColorState,

        appearanceDataState, 
        typographyDataState,

        buttonState,
        false,
        onClick,

        text,
        iconId, 
        labelTextColorState,
        opacityState,
        labelTextColorState,
        0
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