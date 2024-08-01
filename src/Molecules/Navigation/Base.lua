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
local PADDING_SIZE = UDim.new(0,8)
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

    appearanceData : CanBeState<AppearanceData>,
    Children : CanBeState<{[number] : CanBeState<Instance> | {CanBeState<Instance>}}>,
    fillDirection : Enum.FillDirection,
    horizontalAlignment : Enum.HorizontalAlignment?,
    verticalAlignment : Enum.VerticalAlignment?,
    listPadding : number?,
    betweenListPadding : number?)

    local _fuse = ColdFusion.fuse(maid)
    local _new = _fuse.new
    local _import = _fuse.import
    local _bind = _fuse.bind
    local _clone = _fuse.clone
    local _Computed = _fuse.Computed
    local _Value = _fuse.Value
 
    local appearanceDataState = _import(appearanceData, appearanceData)
    local childrenState = _import(Children, Children)

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

    local out = _new("Frame")({
        Size = _Computed(function(appearence : AppearanceData)
            return UDim2.new(1, 0, 0, appearence.Height)
        end, appearanceDataState),
        BackgroundColor3 = _Computed(function(appearance : AppearanceData)
            return appearance.ShadowColor
        end, appearanceDataState),
        BackgroundTransparency =  _Computed(function(appearance : AppearanceData)
            return (100 - ElevationStyle.getLevelData(appearance.Elevation))/100
        end, appearanceDataState),
        BorderSizePixel = 2,
        Children = {
            _new("ScrollingFrame")({
                Name = "Main",
                AutomaticSize = Enum.AutomaticSize.X,
                CanvasSize = UDim2.new(),

                AutomaticCanvasSize = if fillDirection == Enum.FillDirection.Horizontal then Enum.AutomaticSize.X 
                    elseif fillDirection == Enum.FillDirection.Vertical then Enum.AutomaticSize.Y 
                else Enum.AutomaticSize.X,
                AnchorPoint = Vector2.new(0.5,0.5),
                ClipsDescendants = false,
                Size = UDim2.new(1,0,1,0),
                BackgroundColor3 = containerColorState,
                Position = UDim2.fromScale(0.5,0.5),
                ScrollBarThickness = 6,
                Children = _Computed(function(children : {[number] : Instance})
                    return {
                        _new("UIPadding")({
                            PaddingTop = if listPadding then UDim.new(0, listPadding) else  PADDING_SIZE,
                            PaddingBottom = if listPadding then UDim.new(0, listPadding) else  PADDING_SIZE,
                            PaddingLeft = if listPadding then UDim.new(0, listPadding) else  PADDING_SIZE,
                            PaddingRight = if listPadding then UDim.new(0, listPadding) else  PADDING_SIZE
                        }),
                        _new("UIListLayout")({
                            Padding = UDim.new(0,  betweenListPadding or 48),
                            SortOrder = Enum.SortOrder.LayoutOrder,
                            FillDirection = fillDirection,
                            HorizontalAlignment = horizontalAlignment or Enum.HorizontalAlignment.Center,
                            VerticalAlignment = verticalAlignment or Enum.VerticalAlignment.Center
                        }),
                        getUiCorner(),
                        table.unpack(children)
                    }
                end, childrenState)
            }),
            
            getUiCorner(),
        }
    }) 

    return out :: Frame
end


return interface