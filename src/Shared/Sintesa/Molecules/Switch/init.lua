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
local Base =  require(script:WaitForChild("Base"))
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

    local isSelectedState = _Value(false :: boolean?)

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
        local primary = MaterialColor.Color3FromARGB(dynamicScheme:get_primary())
        local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())

        return primary
    end, appearanceDataState, buttonState)

    local handleColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local onPrimary = MaterialColor.Color3FromARGB(dynamicScheme:get_onPrimary())
            
        return onPrimary 
    end, appearanceDataState, buttonState)

    local iconColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local onPrimaryContainer = MaterialColor.Color3FromARGB(dynamicScheme:get_onPrimaryContainer())
            
        return onPrimaryContainer 
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
    
    local out = _new("TextButton")({
        BackgroundColor3 = containerColorState,
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
                Thickness = 0,--2,
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
                Size = UDim2.fromOffset(
                    52 - 24 - 5*2, --if enabled
                    0
                )
            }),
            _bind(ImageLabel.ColdFusion.new(
                maid, 
                2, 
                Icons.navigation.check,
                --0,
                containerColorState
            ))({
                BackgroundTransparency = 0,
                BackgroundColor3 = handleColorState,
                Size = UDim2.fromOffset(
                    --16, 
                    --16
                    24,
                    24
                ),
                Children = {
                    
                    _new("UICorner")({
                        CornerRadius = _Computed(function(appearance : AppearanceData) 
                            return UDim.new(
                                0,  
                                ShapeStyle.get(appearance.Style)
                            )
                        end, appearanceDataState),
                    }),
                }
            })
        }
    })
    
    return out
end
return interface