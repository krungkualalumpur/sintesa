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

type IconData = Types.IconData

export type ButtonStates = {
    [Enums.ButtonState] : {
        Container : AppearanceData,
        LabelText : TypeScaleData
    }
}
--constants
--remotes
--variables
--references
--local functions

--class
local ImageLabel = {}
ImageLabel.ColdFusion = {}

function ImageLabel.ColdFusion.new(
    maid : Maid,

    layoutOrder : CanBeState<number>,
    imageId : CanBeState<(number? | IconData?)>,

    iconColorState : State<Color3> ?)

    local _fuse = ColdFusion.fuse(maid)
    local _new = _fuse.new
    local _import = _fuse.import
    local _bind = _fuse.bind
    local _clone = _fuse.clone
    local _Computed = _fuse.Computed
    local _Value = _fuse.Value
   
    local imageIdState  = _import(imageId, imageId) 

    return _new("ImageLabel")({
        LayoutOrder = 1,
        BackgroundTransparency = 1,
        Visible = _Computed(function(id : (number? | IconData?))
            return if id then true else false
        end, imageIdState),
        ImageColor3 = iconColorState,
        Image = _Computed(function(id : (number | IconData)?)
            local _id = if type(id) == "number" then  `http://www.roblox.com/asset/?id={id}` elseif id then id.AssetId else ''
            return _id
        end, imageIdState) ,
        ImageRectOffset = _Computed(function(id : (number | IconData?)? )
            print(id)
            local offset = if type(id) == "table" then Vector2.new(id.OffsetPerSize[1]*id.Size[1], id.OffsetPerSize[2]*id.Size[2]) else Vector2.new()
            return offset
        end, imageIdState) ,
        ImageRectSize = _Computed(function(id : (number | IconData?)? )
            local size = if type(id) == "table" then Vector2.new(id.Size[1], id.Size[2]) else Vector2.new()
            return size
        end, imageIdState),
        -- Size = _Computed(function(appearance : AppearanceData, _text : string?)
        --     return if text then UDim2.new(0, appearance.Height/2, 0 ,appearance.Height/2) else UDim2.new(0, appearance.Height, 0 ,appearance.Height)
        -- end, appearanceDataState, textState),
        -- Children = {
        --     _new("UIAspectRatioConstraint")({
        --         AspectRatio = 1
        --     })
        -- }
    })
end

return ImageLabel