--!strict
local _Packages = game:GetService("ReplicatedStorage"):WaitForChild("Packages")
--services 
local UserInputService =  game:GetService("UserInputService")
--packages
local Maid = require(_Packages:WaitForChild("Maid"))
local ColdFusion = require(_Packages:WaitForChild("ColdFusion8"))
--modules
local Types = require(script.Parent.Parent:WaitForChild("Types"))
local Icons = require(script.Parent.Parent:WaitForChild("Icons"))
local Enums = require(script.Parent.Parent:WaitForChild("Enums"))

local MaterialColor = require(
    script.Parent.Parent:WaitForChild("Styles"):WaitForChild("MaterialColor")
)

local DynamicTheme = require(script.Parent:WaitForChild("dynamic_theme"))

local ShapeStyle = require(script.Parent.Parent:WaitForChild("Styles"):WaitForChild("Shape"))
local ElevationStyle = require(script.Parent.Parent:WaitForChild("Styles"):WaitForChild("Elevation"))

local ImageLabel = require(script.Parent:WaitForChild("Util"):WaitForChild("ImageLabel"))
local TextLabel = require(script.Parent:WaitForChild("Util"):WaitForChild("TextLabel"))
local Divider = require(script.Parent:WaitForChild("Divider"))

local Styles = require(script.Parent.Parent:WaitForChild("Styles"))
--types
type Maid = Maid.Maid

type Fuse = ColdFusion.Fuse
type State<T> = ColdFusion.State<T>
type ValueState<T> = ColdFusion.ValueState<T>
type CanBeState<T> = ColdFusion.CanBeState<T>

type TypographyData = Types.TypographyData
type AppearanceData = Types.AppearanceData
type TypeScaleData = Types.TypeScaleData

type IconData = Types.IconData
type MenuData = {
    LeadingIcon : (IconData|number)?,
    Name : CanBeState<string>,
    TrailingIcon : (IconData|number)?,
    TrailingSupportingText : string?

}
export type ButtonStates = {
    [Enums.ButtonState] : {
        Container : AppearanceData,
        LabelText : TypeScaleData
    }
}

type ListData = Types.ListData
--constants
local PADDING_SIZE = UDim.new(0,12)
--remotes
--variables
--references
--local functions
local function mouseIsInButton(button : GuiObject)
    local mouse = UserInputService:GetMouseLocation()
    if ((mouse.X > button.AbsolutePosition.X) and (mouse.X < (button.AbsolutePosition.X + button.AbsoluteSize.X))) 
    and ((mouse.Y > button.AbsolutePosition.Y) and (mouse.Y < (button.AbsolutePosition.Y + button.AbsoluteSize.Y))) then
        return true
    end
    return false
end
--class
local interface = {}

interface.ColdFusion = {}

function interface.ColdFusion.new(
    maid : Maid,
    isDark : CanBeState<boolean>,
    
    hasShadow : boolean,
    lists : CanBeState<{
        MenuData
    }>,
    onClick : (MenuData) -> (),
    length : number)

    local _fuse = ColdFusion.fuse(maid)
    local _new = _fuse.new
    local _import = _fuse.import
    local _bind = _fuse.bind
    local _clone = _fuse.clone
    local _Computed = _fuse.Computed
    local _Value = _fuse.Value
  
    local listLength = length
    local isDarkState = _import(isDark, false)

    local appearanceDataState = _Computed(
        function(
            dark : boolean
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
            Enums.ShapeStyle.Small,
            1,

            dark
        )
    end, isDarkState)

    local containerColorState = _Computed(function(appearance : AppearanceData)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local surfaceContainer = MaterialColor.Color3FromARGB(dynamicScheme:get_surfaceContainer())
            
        return  surfaceContainer
    end, appearanceDataState)
    
    local listsState = _import(lists, lists)

    local getUiCorner = function()
        return _new("UICorner")({
            CornerRadius = _Computed(function(appearance : AppearanceData) 
                return UDim.new(
                    0,  
                    ShapeStyle.get(appearance.Style)
                )
            end, appearanceDataState),
        })
    end

    local Children =  _Computed(function(group : {MenuData})
        return group
    end, listsState):ForValues(function(list : MenuData, pairMaid : Maid)
        local buttonState = _Value(Enums.ButtonState.Enabled :: Enums.ButtonState)
        
        local containerColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState)
            local dynamicScheme = MaterialColor.getDynamicScheme(
                appearance.PrimaryColor, 
                appearance.SecondaryColor, 
                appearance.TertiaryColor, 
                appearance.NeutralColor, 
                appearance.NeutralVariantColor,
                appearance.IsDark
            )
            local surfaceContainer = MaterialColor.Color3FromARGB(dynamicScheme:get_surfaceContainer())
                
            return surfaceContainer
        end, appearanceDataState, buttonState)

        local textColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState)
            local dynamicScheme = MaterialColor.getDynamicScheme(
                appearance.PrimaryColor, 
                appearance.SecondaryColor, 
                appearance.TertiaryColor, 
                appearance.NeutralColor, 
                appearance.NeutralVariantColor,
                appearance.IsDark
            )
            local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())

            return onSurface
        end, appearanceDataState, buttonState)
        local supportingTextColorState = _Computed(function(appearance : AppearanceData)
            local dynamicScheme = MaterialColor.getDynamicScheme(
                appearance.PrimaryColor, 
                appearance.SecondaryColor, 
                appearance.TertiaryColor, 
                appearance.NeutralColor, 
                appearance.NeutralVariantColor,
                appearance.IsDark
            )
            local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurfaceVariant())
                
            return onSurface
        end, appearanceDataState)
        local iconColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState)
            local dynamicScheme = MaterialColor.getDynamicScheme(
                appearance.PrimaryColor, 
                appearance.SecondaryColor, 
                appearance.TertiaryColor, 
                appearance.NeutralColor, 
                appearance.NeutralVariantColor,
                appearance.IsDark
            )
            local onSurfaceVariant = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurfaceVariant())
            local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())

            return if _buttonState == Enums.ButtonState.Disabled then onSurface else onSurfaceVariant
        end, appearanceDataState, buttonState)

        local avatarColorState = _Computed(function(appearance : AppearanceData)
            local dynamicScheme = MaterialColor.getDynamicScheme(
                appearance.PrimaryColor, 
                appearance.SecondaryColor, 
                appearance.TertiaryColor, 
                appearance.NeutralColor, 
                appearance.NeutralVariantColor,
                appearance.IsDark
            )
            local primaryContainer = MaterialColor.Color3FromARGB(dynamicScheme:get_primaryContainer())
                
            return primaryContainer
        end, appearanceDataState)

        local stateLayerColorState = _Computed(function(appearance : AppearanceData)
            local dynamicScheme = MaterialColor.getDynamicScheme(
                appearance.PrimaryColor, 
                appearance.SecondaryColor, 
                appearance.TertiaryColor, 
                appearance.NeutralColor, 
                appearance.NeutralVariantColor,
                appearance.IsDark
            )
            local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())
                
            return onSurface
        end, appearanceDataState)

        local avatarTextColorState = _Computed(function(appearance : AppearanceData)
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
        end, appearanceDataState)

        local headlineLabel = Styles.Typography.get(Enums.TypographyStyle.BodyLarge)
        local headlineTypographyDataState = _Value(Types.createTypographyData(
            headlineLabel
        ))

        local labelLarge = Styles.Typography.get(Enums.TypographyStyle.BodyMedium)
        local labelLargeTypographyDataState = _Value(Types.createTypographyData(
            labelLarge
        ))


        local out = _new("TextButton")({
            BackgroundColor3 = containerColorState,
            Size = UDim2.new(1,0,0,0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Children = {
                getUiCorner(),
                _new("Frame")({
                    BackgroundTransparency = _Computed(function(_buttonState : Enums.ButtonState) 
                        return if _buttonState == Enums.ButtonState.Hovered then 1 - 0.08
                            elseif _buttonState == Enums.ButtonState.Focused then 1 - 0.1 
                            elseif _buttonState == Enums.ButtonState.Pressed then 1 - 0.1
                        else 1 - 0
                    end, buttonState):Tween(),
                    BackgroundColor3 = stateLayerColorState:Tween() ,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Size = UDim2.new(1,0,0,56),
                    Children = {
                        _new("UIPadding")({
                            PaddingTop = UDim.new(0,8),
                            PaddingBottom = UDim.new(0,8),
                            PaddingLeft = UDim.new(0,16),
                            PaddingRight = UDim.new(0,16),
                        }),
                        _new("UIListLayout")({
                            Padding = UDim.new(0,16),
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            FillDirection = Enum.FillDirection.Horizontal,
                            SortOrder = Enum.SortOrder.LayoutOrder,
                        }),
                     
                       
                         _bind(ImageLabel.ColdFusion.new(maid, 1, list.LeadingIcon, iconColorState))({
                            Size = UDim2.fromOffset(24, 24),
                            --BackgroundColor3 = Color3.fromRGB(25,5,55)
                        }),
                        _new("Frame")({
                            LayoutOrder = 2,
                            BackgroundTransparency = 1,
                            AutomaticSize = Enum.AutomaticSize.XY,
                            Size = UDim2.fromOffset(24, 24),
                            Children = {
                                _new("UIListLayout")({
                                    Padding = UDim.new(0,8),
                                    VerticalAlignment = Enum.VerticalAlignment.Center,
                                    FillDirection = Enum.FillDirection.Vertical,
                                    SortOrder = Enum.SortOrder.LayoutOrder,
                                }),
                                _bind(TextLabel.ColdFusion.new(maid, 1, list.Name, textColorState, headlineTypographyDataState, 2))({
                                    AutomaticSize = Enum.AutomaticSize.Y,
                                    BackgroundTransparency = 1,
                                    Size = UDim2.new(0, 56, 0, 0),
                                    TextXAlignment = Enum.TextXAlignment.Left,
                                    TextTransparency = _Computed(function(_buttonState : Enums.ButtonState)
                                        return if _buttonState == Enums.ButtonState.Disabled then 1 - 0.38 else 1 - 1
                                    end, buttonState)
                                }),
                               
                            }
                        }),
                    }
                }),
                 _bind(ImageLabel.ColdFusion.new(maid, 1,  list.TrailingIcon, iconColorState))({
                    AnchorPoint = Vector2.new(1,0.5),
                    Size = UDim2.fromOffset(24, 24),
                    Position = UDim2.new(1,0,0.5,0) - UDim2.new(0,48,0,0)
                    --BackgroundColor3 = Color3.fromRGB(25,5,55)
                }),
                _bind(TextLabel.ColdFusion.new(maid, 1, list.TrailingSupportingText, supportingTextColorState, labelLargeTypographyDataState, 0))({
                    AnchorPoint = Vector2.new(1,0.5),
                    Size = UDim2.fromOffset(24, 24),
                    Position = UDim2.new(1,0,0.5,0) - UDim2.new(0,24,0,0)
                    --BackgroundColor3 = Color3.fromRGB(25,5,55)
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
                        onClick(list)
                    end
                end,
                MouseButton1Up = function()
                    if buttonState:Get() ~= Enums.ButtonState.Disabled then
                        buttonState:Set(Enums.ButtonState.Enabled)
                    end
                end,
            }
        })
        
        return out
    end)

    local out = _new("Frame")({
        BackgroundColor3 = _Computed(function(appearance : AppearanceData)
            return appearance.ShadowColor
        end, appearanceDataState),
        BackgroundTransparency =  _Computed(function(appearance : AppearanceData)
            return (100 - ElevationStyle.getLevelData(appearance.Elevation))/100
        end, appearanceDataState),
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(0,listLength,0,0),
        BorderSizePixel = 2,
        ClipsDescendants = true,
        Children = {
            _new("Frame")({
                Name = "Main",
                ZIndex = 10,
                AutomaticSize = Enum.AutomaticSize.Y,
                ClipsDescendants = false,
                Size = --[[if hasShadow then UDim2.new(0.92, 0, 0.92,0) else]] UDim2.new(1,0,0,0),
                BackgroundColor3 = containerColorState,
                Children = {
                    _new("UIPadding")({
                        PaddingTop = UDim.new(0,6),
                        PaddingBottom = UDim.new(0,6),

                    }),
                    _new("UIListLayout")({
                        Padding = UDim.new(0,8)
                    }),
                    getUiCorner(),
                    Children :: any
                }
            }),
            
            getUiCorner(),
        }
    }) 

    return out :: Frame
end


return interface