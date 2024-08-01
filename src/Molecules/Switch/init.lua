--!strict
local _Packages = game:GetService("ReplicatedStorage"):WaitForChild("Packages")
--services 
--packages
local Maid = require(_Packages:WaitForChild("Maid"))
local ColdFusion = require(_Packages:WaitForChild("ColdFusion8"))
--modules
local MaterialColor = require(
    script.Parent.Parent:WaitForChild("Styles"):WaitForChild("MaterialColor")
) 
local Types = require(script.Parent.Parent:WaitForChild("Types"))
local Icons = require(script.Parent.Parent:WaitForChild("Icons"))

local ShapeStyle = require(script.Parent.Parent:WaitForChild("Styles"):WaitForChild("Shape"))

local Styles = require(script.Parent.Parent:WaitForChild("Styles"))
local Enums = require(script.Parent.Parent:WaitForChild("Enums"))

local DynamicTheme = require(script.Parent:WaitForChild("dynamic_theme"))

local TextLabel = require(script.Parent:WaitForChild("Util"):WaitForChild("TextLabel"))
local ImageLabel = require(script.Parent:WaitForChild("Util"):WaitForChild("ImageLabel"))

local StandardIconButton = require(script.Parent:WaitForChild("Buttons"):WaitForChild("IconButton"):WaitForChild("Standard"))
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
    isSelected : CanBeState<boolean>,
    isDark : CanBeState<boolean>,
    onClick : () -> (),
    shapeStyle : CanBeState<Enums.ShapeStyle>?)
    
    local _fuse = ColdFusion.fuse(maid)
    local _new = _fuse.new
    local _import = _fuse.import
    local _bind = _fuse.bind
    local _clone = _fuse.clone
    local _Computed = _fuse.Computed
    local _Value = _fuse.Value

    local isDarkState = _import(isDark, false)

    local isSelectedState =_import(isSelected, isSelected)

    local shapeStyleState = _import(shapeStyle, Enums.ShapeStyle.Full :: Enums.ShapeStyle)

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
            16,

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
            
        return if _buttonState == Enums.ButtonState.Enabled then outline 
            elseif _buttonState == Enums.ButtonState.Disabled then onSurface
            elseif _buttonState == Enums.ButtonState.Focused then onSurfaceVariant
        else outline    
    end, appearanceDataState, buttonState, isSelectedState)

    local trackColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState, selected : boolean)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local primary = MaterialColor.Color3FromARGB(dynamicScheme:get_primary())
        local surfaceContainerHighest = MaterialColor.Color3FromARGB(dynamicScheme:get_surfaceContainerHighest())

        local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())

        return if selected then (if _buttonState == Enums.ButtonState.Enabled then primary 
            elseif _buttonState == Enums.ButtonState.Disabled then onSurface
            elseif _buttonState == Enums.ButtonState.Hovered then primary
            elseif _buttonState == Enums.ButtonState.Focused then primary
            elseif _buttonState == Enums.ButtonState.Pressed then primary
            
            else primary) 
        else (if _buttonState == Enums.ButtonState.Enabled then surfaceContainerHighest 
            elseif _buttonState == Enums.ButtonState.Disabled then surfaceContainerHighest
            elseif _buttonState == Enums.ButtonState.Hovered then surfaceContainerHighest
            elseif _buttonState == Enums.ButtonState.Focused then surfaceContainerHighest
            elseif _buttonState == Enums.ButtonState.Pressed then surfaceContainerHighest
            
        else primary) 
    end, appearanceDataState, buttonState, isSelectedState)

    local handleColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState, selected : boolean)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local onPrimary = MaterialColor.Color3FromARGB(dynamicScheme:get_onPrimary())
        local outline = MaterialColor.Color3FromARGB(dynamicScheme:get_outline())
        local surface = MaterialColor.Color3FromARGB(dynamicScheme:get_surface())
        local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())
        local primaryContainer = MaterialColor.Color3FromARGB(dynamicScheme:get_primaryContainer())
        local onSurfaceVariant = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurfaceVariant())
        local primary = MaterialColor.Color3FromARGB(dynamicScheme:get_primary())
        local surfaceContainerHighest = MaterialColor.Color3FromARGB(dynamicScheme:get_surfaceContainerHighest())

        return if selected then (if _buttonState == Enums.ButtonState.Enabled then onPrimary 
                elseif _buttonState == Enums.ButtonState.Disabled then surface
                elseif _buttonState == Enums.ButtonState.Hovered then primaryContainer
                elseif _buttonState == Enums.ButtonState.Focused then primary
                elseif _buttonState == Enums.ButtonState.Pressed then primaryContainer 
            else primary) 
        else (if _buttonState == Enums.ButtonState.Enabled then outline 
            elseif _buttonState == Enums.ButtonState.Disabled then onSurface
            elseif _buttonState == Enums.ButtonState.Hovered then onSurfaceVariant
            elseif _buttonState == Enums.ButtonState.Focused then surfaceContainerHighest
            elseif _buttonState == Enums.ButtonState.Pressed then onSurfaceVariant
        else primary) 
    end, appearanceDataState, buttonState, isSelectedState)

    local iconColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState, selected : boolean)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local onPrimaryContainer = MaterialColor.Color3FromARGB(dynamicScheme:get_onPrimaryContainer())
        local surfaceContainerHighest = MaterialColor.Color3FromARGB(dynamicScheme:get_surfaceContainerHighest())
        local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())

        return if selected then (if _buttonState == Enums.ButtonState.Enabled then onPrimaryContainer 
                elseif _buttonState == Enums.ButtonState.Disabled then onSurface
                elseif _buttonState == Enums.ButtonState.Hovered then onPrimaryContainer
                elseif _buttonState == Enums.ButtonState.Focused then onPrimaryContainer
                elseif _buttonState == Enums.ButtonState.Pressed then onPrimaryContainer 
            else onPrimaryContainer) 
        else (if _buttonState == Enums.ButtonState.Enabled then surfaceContainerHighest 
            elseif _buttonState == Enums.ButtonState.Disabled then surfaceContainerHighest
            elseif _buttonState == Enums.ButtonState.Hovered then surfaceContainerHighest
            elseif _buttonState == Enums.ButtonState.Focused then surfaceContainerHighest
            elseif _buttonState == Enums.ButtonState.Pressed then surfaceContainerHighest
        else surfaceContainerHighest) 
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
    
    local handleSize = _Value(UDim2.fromOffset(24, 24))
    local out = _new("TextButton")({
        BackgroundTransparency = _Computed(function(selected : boolean, _buttonState : Enums.ButtonState)
            return if _buttonState ~= Enums.ButtonState.Disabled then 1 - 1 else 1 - 0.12 
        end, isSelectedState, buttonState),
        BackgroundColor3 = trackColorState:Tween(),
        Size = UDim2.fromOffset(52,32),
        Children = {
            _new("UIPadding")({
                PaddingTop = UDim.new(0,5),
                PaddingBottom = UDim.new(0,5),
                PaddingLeft = UDim.new(0,5),
                PaddingRight = UDim.new(0,5),

            }),
            _new("UIListLayout")({
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Center
            }),
            _new("UIStroke")({
                Color = outlineColorState,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                Thickness = _Computed(function(selected : boolean)
                    return if not selected then 2 else 0
                end, isSelectedState):Tween(),--2,
            }),
            _new("UICorner")({
                CornerRadius = _Computed(function(appearance : AppearanceData) 
                    return UDim.new(
                        0,  
                        ShapeStyle.get(appearance.Style)
                    )
                end, appearanceDataState),
            }),
            _new("Frame")({
                LayoutOrder = 1,
                BackgroundTransparency = 1,
               -- BackgroundColor3 = iconColorState,
                Size = _Computed(function(selected : boolean, size : UDim2)
                    return if selected then 
                        UDim2.fromOffset(
                            52 - size.X.Offset - 5*2, --if enabled
                            0
                        )
                    else UDim2.fromOffset(
                        0, --if enabled
                        0
                    )
                end, isSelectedState, handleSize):Tween()
            }),
            _new("Frame")({
                Name = "Handle",
                LayoutOrder = 2,
                BackgroundTransparency = _Computed(function(selected : boolean, _buttonState : Enums.ButtonState)
                    if _buttonState == Enums.ButtonState.Pressed then 
                        handleSize:Set(UDim2.fromOffset(28, 28)) 
                    elseif selected then 
                        handleSize:Set(UDim2.fromOffset(24, 24)) 
                    else 
                        handleSize:Set(UDim2.fromOffset(16,16)) 
                    end
                    
                    return if _buttonState ~= Enums.ButtonState.Disabled then 1 - 1 else 1 - 0.38 
                end, isSelectedState, buttonState),
                BackgroundColor3 = handleColorState:Tween(),
                Size = handleSize:Tween(),
                Children = {
                    
                    _new("UICorner")({
                        CornerRadius = _Computed(function(appearance : AppearanceData) 
                            return UDim.new(
                                0,  
                                ShapeStyle.get(appearance.Style)
                            )
                        end, appearanceDataState),
                    }),

                    _bind(ImageLabel.ColdFusion.new(
                        maid, 
                        2, 
                        Icons.navigation.check,
                        --0,
                        iconColorState
                    ))({
                        AnchorPoint = Vector2.new(0.5,0.5),
                        Visible = _Computed(function(selected : boolean)
                            return selected
                        end, isSelectedState),
                        ImageTransparency = _Computed(function(selected : boolean, _buttonState : Enums.ButtonState)
                            return if _buttonState ~= Enums.ButtonState.Disabled then 1 - 1 else 1 - 0.38
                        end, isSelectedState, buttonState),
                        Size = UDim2.new(0,16,0,16),
                        Position = UDim2.fromScale(0.5,0.5)
                    })
                }
            }),
           
        },
        Events = {
            MouseEnter = function()
                if buttonState:Get() ~= Enums.ButtonState.Disabled then
                    buttonState:Set(Enums.ButtonState.Hovered)
                end
            end,
            MouseLeave = function()
                if buttonState:Get() ~= Enums.ButtonState.Disabled then
                    buttonState:Set(Enums.ButtonState.Enabled)
                end
            end,
            MouseButton1Down = function()
                if buttonState:Get() ~= Enums.ButtonState.Disabled then
                    buttonState:Set(Enums.ButtonState.Pressed)
                    onClick()
                end
            end,
            MouseButton1Up = function()
                if buttonState:Get() ~= Enums.ButtonState.Disabled then
                    buttonState:Set(Enums.ButtonState.Enabled)
                end
            end,
        }
    }) :: TextButton
    
    maid:GiveTask(out:GetPropertyChangedSignal("Active"):Connect(function()
        if out.Active then
            buttonState:Set(Enums.ButtonState.Enabled)
        else
            buttonState:Set(Enums.ButtonState.Disabled)
        end
    end))
    
    return out 
end
return interface