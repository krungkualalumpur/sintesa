--!strict
--services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

--packages
local Maid = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Maid"))
local ColdFusion = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("ColdFusion8"))
local Signal = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Signal"))
--modules
local Types = require(script.Parent.Parent:WaitForChild("Types"))
local Icons = require(script.Parent.Parent:WaitForChild("Icons"))
local Enums = require(script.Parent.Parent:WaitForChild("Enums"))

local Styles = require(script.Parent.Parent:WaitForChild("Styles"))
local ShapeStyle = require(script.Parent.Parent:WaitForChild("Styles"):WaitForChild("Shape"))

local MaterialColor = require(
    script.Parent.Parent:WaitForChild("Styles"):WaitForChild("MaterialColor")
)
local DynamicTheme = require(script.Parent:WaitForChild("dynamic_theme"))
local TextLabel = require(script.Parent:WaitForChild("Util"):WaitForChild("TextLabel"))

local MathUtil = require(script.Parent.Parent:WaitForChild("Utils"):WaitForChild("MathUtil"))
--types
type Maid = Maid.Maid
type Signal = Signal.Signal

type Fuse = ColdFusion.Fuse
type State<T> = ColdFusion.State<T>
type ValueState<T> = ColdFusion.ValueState<T>
type CanBeState<T> = ColdFusion.CanBeState<T>

type AppearanceData = Types.AppearanceData
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
    isDark : CanBeState<boolean>,
    size : CanBeState<number>,
    ratioState : ValueState<number>,
    ratioState2 : ValueState<number>? -- for range
    )   
    
    local _fuse = ColdFusion.fuse(maid)
    local _new = _fuse.new
    local _import = _fuse.import
    local _bind = _fuse.bind
    local _clone = _fuse.clone
    local _Computed = _fuse.Computed
    local _Value = _fuse.Value
   
    local buttonState = _Value(Enums.ButtonState.Enabled :: Enums.ButtonState)
    local isDarkState = _import(isDark, isDark)
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
            Enums.ShapeStyle.ExtraSmall,
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
        local outlineVariant = MaterialColor.Color3FromARGB(dynamicScheme:get_outlineVariant())
            
        return  outlineVariant
    end, appearanceDataState)

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

    local handleColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState)
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

        return if _buttonState == Enums.ButtonState.Enabled then primary 
            elseif _buttonState == Enums.ButtonState.Disabled then onSurface 
        else primary
    end, appearanceDataState, buttonState)

    local activeTrackColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState)
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

        return if _buttonState == Enums.ButtonState.Enabled then primary 
            elseif _buttonState == Enums.ButtonState.Disabled then onSurface 
        else primary
    end, appearanceDataState, buttonState)

    local inactiveTrackColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local secondaryContainer = MaterialColor.Color3FromARGB(dynamicScheme:get_secondaryContainer())
        local onSurfaceVariant = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurfaceVariant())
        return if _buttonState == Enums.ButtonState.Enabled then secondaryContainer 
            elseif _buttonState == Enums.ButtonState.Disabled then onSurfaceVariant 
        else secondaryContainer
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
        local inverseOnSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_inverseOnSurface())
            
        return inverseOnSurface
    end, appearanceDataState, buttonState)
    
    local labelLarge = Styles.Typography.get(Enums.TypographyStyle.BodyLarge)
    local typographyDataState = _Value(Types.createTypographyData(
        labelLarge
    ))

    local sizeState = _import(size, size)

    local buttonSeparatorSize = 0.05
    local out = _new("Frame"){
        BackgroundTransparency = 1,
      --  BackgroundColor3 = Color3.fromRGB(255,0,0),
        Size = _Computed(function(size : number)
            return UDim2.fromOffset(size, 16)
        end, sizeState) ,
        Children = {
            getUiCorner(),
            _new("Frame"){
                Name = "Container",
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1),
                Children = {
                    _new("UIListLayout")({
                        FillDirection = Enum.FillDirection.Horizontal,
                        SortOrder = Enum.SortOrder.LayoutOrder
                    }),
                    _new("Frame")({
                        LayoutOrder = 1,
                        Name = "Active",
                        BackgroundColor3 = activeTrackColorState,
                        Size = _Computed(function(ratio : number)
                            return UDim2.fromScale(math.clamp(ratio - buttonSeparatorSize*0.5, 0, 1), 1) 
                        end, ratioState),
                        Children = { 
                            getUiCorner(),

                        }
                    }),
                   
                    _new("Frame")({
                        LayoutOrder = 3,
                        Name = "Inactive",
                        BackgroundColor3 = inactiveTrackColorState,
                        Size = _Computed(function(ratio : number) 
                            return UDim2.fromScale(math.clamp(1 - (ratio + buttonSeparatorSize*0.5), 0, 1 - buttonSeparatorSize), 1) 
                        end, ratioState),
                        Children = {
                            getUiCorner(),

                        }
                    })
                }
                }
            }
           
    } :: Frame

    local function onHandleClick()
        if buttonState:Get() == Enums.ButtonState.Disabled then return end

        local conn
        conn = RunService.Heartbeat:Connect(function()
            if not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then 
                if conn then conn:Disconnect() end
                buttonState:Set(Enums.ButtonState.Enabled)
            end
            local v2 = UserInputService:GetMouseLocation()
            local min = out.AbsolutePosition.X
            local max = out.AbsolutePosition.X + out.AbsoluteSize.X
            ratioState:Set(math.clamp((v2.X - min)/(max - min), 0, 1))

        end)
        buttonState:Set(Enums.ButtonState.Pressed)
    end
    
    local handle = _new("TextButton")({
        Name = "Handle",
        LayoutOrder = 2,
        Parent = out:FindFirstChild("Container"),
        ZIndex = 2,
        AnchorPoint = Vector2.new(0.5,0.5),
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(buttonSeparatorSize, 1),
        Children = {
            _new("TextButton")({
                AnchorPoint = Vector2.new(0.5,0.5),
                BackgroundColor3 = handleColorState,
                Position = UDim2.fromScale(0.5, 0.5),    
                Size = UDim2.fromOffset(6, 44),
                Children = {
                    getUiCorner(),
                    _bind(TextLabel.ColdFusion.new(
                        maid, 
                        0, 
                        _Computed(function(ratio : number)
                            return tostring(math.round(ratio*100))
                        end, ratioState),
                        labelTextColorState, 
                        typographyDataState, 
                        12
                    ))({
                        AnchorPoint = Vector2.new(0.5,0.5),
                        AutomaticSize = Enum.AutomaticSize.XY,
                        Size = UDim2.new(),
                        Visible = _Computed(function(_buttonState : Enums.ButtonState)
                            return if _buttonState == Enums.ButtonState.Pressed then true else false
                        end, buttonState),
                        BackgroundColor3 = _Computed(function(appearance : AppearanceData)
                            local dynamicScheme = MaterialColor.getDynamicScheme(
                                appearance.PrimaryColor, 
                                appearance.SecondaryColor, 
                                appearance.TertiaryColor, 
                                appearance.NeutralColor, 
                                appearance.NeutralVariantColor,
                                appearance.IsDark
                            )
                            local shadow = MaterialColor.Color3FromARGB(dynamicScheme:get_shadow())
                                 
                            return shadow
                        end, appearanceDataState),
                        BackgroundTransparency = 1 - 0.25,
                        Position = UDim2.fromScale(0.5, -0.6),
                        Children = {
                            _new("UIPadding")({
                                PaddingTop = UDim.new(0,12),
                                PaddingBottom = UDim.new(0,12),
                                PaddingLeft = UDim.new(0,16),
                                PaddingRight = UDim.new(0,16),

                            }),
                            _new("UICorner")({
                                CornerRadius = UDim.new(
                                        0,  
                                        ShapeStyle.get(Enums.ShapeStyle.Full)
                                    )
                                ,
                            })
                        }
                    }),
        
                   
                },

                Events = {
                    MouseButton1Down = onHandleClick,
                    
                }
            }),
            
         
        },
        Events = {
            MouseButton1Down = onHandleClick,
           
        }
    })
    return out

end
return interface