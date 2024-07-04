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
    containerColorState : State<Color3>,

    appearanceData : CanBeState<AppearanceData>,
    
    hasShadow : boolean,
    Children : CanBeState<{[number] : CanBeState<Instance> | {CanBeState<Instance>}}>)

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
        
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundColor3 = _Computed(function(appearance : AppearanceData)
            return appearance.ShadowColor
        end, appearanceDataState),
        BackgroundTransparency =  _Computed(function(appearance : AppearanceData)
            return (100 - ElevationStyle.getLevelData(appearance.Elevation))/100
        end, appearanceDataState),
        Size = UDim2.new(0, 200,0,200),
        BorderSizePixel = 2,
        Children = {
            _new("Frame")({
                Name = "Main",
                AutomaticSize = Enum.AutomaticSize.XY,
                AnchorPoint = Vector2.new(0.5,0.5),
                ClipsDescendants = false,
                Size = if hasShadow then UDim2.new(0.92, 0, 0.92,0) else UDim2.new(1,0,1,0),
                BackgroundColor3 = containerColorState,
                Position = UDim2.fromScale(0.5,0.5),
                Children = _Computed(function(children : {[number] : Instance})
                    return {
                        _new("UIPadding")({
                            PaddingTop = PADDING_SIZE,
                            PaddingBottom = PADDING_SIZE,
                            PaddingLeft = PADDING_SIZE,
                            PaddingRight = PADDING_SIZE
                        }),
                        _new("UIListLayout")({
                            Padding = PADDING_SIZE,
                            SortOrder = Enum.SortOrder.LayoutOrder,
                            HorizontalAlignment = Enum.HorizontalAlignment.Center,
                            VerticalAlignment = Enum.VerticalAlignment.Center
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