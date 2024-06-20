--!strict
local _Packages = game:GetService("ReplicatedStorage"):WaitForChild("Packages")
--services 
local UserInputService =  game:GetService("UserInputService")
--packages
local Maid = require(_Packages:WaitForChild("Maid"))
local ColdFusion = require(_Packages:WaitForChild("ColdFusion8"))
--modules
local Types = require(script.Parent.Parent.Parent:WaitForChild("Types"))
local Enums = require(script.Parent.Parent.Parent:WaitForChild("Enums"))

local MaterialColor = require(
    script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("MaterialColor")
)

local DynamicTheme = require(script.Parent.Parent:WaitForChild("dynamic_theme"))

local ShapeStyle = require(script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("Shape"))
local ElevationStyle = require(script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("Elevation"))

local TextLabel = require(script.Parent.Parent:WaitForChild("Util"):WaitForChild("TextLabel"))

--types
type Maid = Maid.Maid

type Fuse = ColdFusion.Fuse
type State<T> = ColdFusion.State<T>
type ValueState<T> = ColdFusion.ValueState<T>
type CanBeState<T> = ColdFusion.CanBeState<T>

type TypographyData = Types.TypographyData
type AppearanceData = Types.AppearanceData
type TypeScaleData = Types.TypeScaleData

export type ButtonStates = {
    [Enums.ButtonState] : {
        Container : AppearanceData,
        LabelText : TypeScaleData
    }
}
--constants
local PADDING_SIZE = UDim.new(0,2)
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
    

    containerColorState : State<Color3>,
    stateLayerColorState : State<Color3>,

    appearanceData : CanBeState<AppearanceData>,
    typographyData : CanBeState<TypographyData>,
    buttonState : ValueState<Enums.ButtonState>,
    hasShadow : boolean,

    onClick : (... any) -> (... any),

    text : CanBeState<string?>,
    iconId : CanBeState<number?>,

    iconColorState : State<Color3> ?,
    stateOpacity : State<number> ?,
    labelTextColorState : State<Color3>?,

    backgroundOpacity : CanBeState<number>?)

    local _fuse = ColdFusion.fuse(maid)
    local _new = _fuse.new
    local _import = _fuse.import
    local _bind = _fuse.bind
    local _clone = _fuse.clone
    local _Computed = _fuse.Computed
    local _Value = _fuse.Value

    local appearanceDataState = _import(appearanceData, appearanceData)
    local typographyDataState = _import(typographyData, typographyData)
    
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
    
    local textState = _import(text, text)
    local iconIdState = _import(iconId, iconId)
    local stateOpacityState = _import(stateOpacity, stateOpacity)
    local backgroundOpacityState = _import(backgroundOpacity, backgroundOpacity)

    local out = _new("TextButton")({
        AutomaticSize = Enum.AutomaticSize.X,
        Size = _Computed(function(appearance : AppearanceData, str : string?)
            return UDim2.new(0, if str then 75 else 0, 0 ,appearance.Height)
        end, appearanceDataState, textState),
        BackgroundColor3 = _Computed(function(appearance : AppearanceData)
            return appearance.ShadowColor
        end, appearanceDataState),
        BackgroundTransparency = _Computed(function(appearance : AppearanceData)
            return (100 - ElevationStyle.getLevelData(appearance.Elevation))/100
        end, appearanceDataState),
        Children = {
            _new("Frame")({
                Name = "CanvasGroup",
                AutomaticSize = Enum.AutomaticSize.X,
                ClipsDescendants = false,
                Size =  _Computed(function(appearance : AppearanceData, str : string?)
                    local xOffset = if str then 75 else 0
                    return if hasShadow then UDim2.new(0, xOffset, 0.9,0) else UDim2.new(0,xOffset,1,0)
                end, appearanceDataState, textState),
                BackgroundTransparency = _Computed(function(opacity : number?)
                    return if opacity then (1 - opacity) else 0 
                end, backgroundOpacityState),
                BackgroundColor3 = containerColorState,
                Children = {
                    getUiCorner(),
                    _new("Frame")({
                        Name = "Main",
                        AutomaticSize = Enum.AutomaticSize.X,
                        BackgroundColor3 = stateLayerColorState,
                        BackgroundTransparency = _Computed(function(opacity : number?)
                            return if opacity then (1 - opacity) else 1
                        end, stateOpacityState),
                        Size = UDim2.fromScale(0, 1),
                        Children = {
                            _new("UIListLayout")({
                                Padding = PADDING_SIZE,
                                SortOrder = Enum.SortOrder.LayoutOrder,
                                FillDirection = Enum.FillDirection.Horizontal,
                                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                                VerticalAlignment = Enum.VerticalAlignment.Center
                            }),
                            getUiCorner(),
                            _new("ImageLabel")({
                                LayoutOrder = 1,
                                BackgroundTransparency = 1,
                                Visible = _Computed(function(id : number?)
                                    return if id then true else false
                                end, iconIdState),
                                ImageColor3 = iconColorState,
                                Image = _Computed(function(id : number?)
                                    return `rbxassetid://{id}`
                                end, iconIdState) ,
                                Size = _Computed(function(appearance : AppearanceData, _text : string?)
                                    return if text then UDim2.new(0, appearance.Height/2, 0 ,appearance.Height/2) else UDim2.new(0, appearance.Height, 0 ,appearance.Height)
                                end, appearanceDataState, textState),
                                Children = {
                                    _new("UIAspectRatioConstraint")({
                                        AspectRatio = 1
                                    })
                                }
                            }),
                            TextLabel.ColdFusion.new(
                                maid,
                                2, 
                                textState,
                                labelTextColorState :: State<Color3>,
                                typographyDataState,
                                _Computed(function(appearance : AppearanceData)
                                    return appearance.Height
                                end, appearanceDataState)
                            )
                        }
                    }),
                }
            }),
            
            getUiCorner(),
    
           --[[ if hasShadow then
                _new("UIStroke")({
                    Name = "Shadow",
                    Thickness = 6,
                    Color = _Computed(function(appearance : AppearanceData)
                        return appearance.ShadowColor
                    end, appearanceDataState),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    Transparency =  _Computed(function(appearance : AppearanceData)
                        return (20 - ElevationStyle.getLevelData(appearance.Elevation))/20
                    end, appearanceDataState)
                })
            else nil :: any]]
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
        }
    }) :: TextButton

    _bind(out)({
        Events = {
            MouseButton1Up = function()
                if mouseIsInButton(out) then
                    buttonState:Set(Enums.ButtonState.Hovered)
                else
                    buttonState:Set(Enums.ButtonState.Enabled)
                end
            end
        }
    })
    return out :: TextButton
end


return interface