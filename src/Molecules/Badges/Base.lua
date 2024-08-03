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
local PADDING_SIZE = UDim.new(0,4)
--remotes
--variables
--references
--local functions
--class
local interface = {}

interface.ColdFusion = {}

function interface.ColdFusion.new(
    maid : Maid,

    containerColorState : State<Color3>,

    appearanceData : CanBeState<AppearanceData>,
    typographyData : CanBeState<TypographyData>,
    text : CanBeState<string>?,
    hasShadow : boolean,

    labelTextColorState : State<Color3>?)

    local _fuse = ColdFusion.fuse(maid)
    local _new = _fuse.new
    local _import = _fuse.import
    local _bind = _fuse.bind
    local _clone = _fuse.clone
    local _Computed = _fuse.Computed
    local _Value = _fuse.Value
 
    local appearanceDataState = _import(appearanceData, appearanceData)

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

    local textLabel = TextLabel.ColdFusion.new(
        maid,
        0, 
        text,
        labelTextColorState :: State<Color3>,
        typographyData,
        _Computed(function(appearance : AppearanceData)
            return appearance.Height
        end, appearanceDataState)
    )

    local out = _new("Frame")({
        AutomaticSize = Enum.AutomaticSize.X,
        Size = _Computed(function(appearence : AppearanceData)
            return UDim2.new(0,  appearence.Height, 0, appearence.Height)
        end, appearanceDataState),
        BackgroundColor3 = _Computed(function(appearance : AppearanceData)
            return appearance.ShadowColor
        end, appearanceDataState),
        BackgroundTransparency =  _Computed(function(appearance : AppearanceData)
            return (100 - ElevationStyle.getLevelData(appearance.Elevation))/100
        end, appearanceDataState),
        BorderSizePixel = 2,
        Children = {
            
            _new("Frame")({
                AutomaticSize = Enum.AutomaticSize.XY,
                Size = if not text then UDim2.fromOffset(6, 6) else UDim2.fromOffset(16,16),
                BackgroundColor3 = containerColorState,
                Children = {
                    if text then 
                        _new("UIPadding")({
                            PaddingTop = PADDING_SIZE,
                            PaddingLeft = PADDING_SIZE,
                            PaddingRight = PADDING_SIZE,
                            PaddingBottom = PADDING_SIZE
                        }) else nil,
                    getUiCorner(), 
                    _bind(textLabel)({
                        AutomaticSize = Enum.AutomaticSize.XY,
                        Size = UDim2.new(),
                    })
                }
            }),
            
            getUiCorner(),
        }
    }) 

    return out :: Frame
end


return interface