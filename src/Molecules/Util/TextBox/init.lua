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
--remotes
--variables
--references
--local functions

--class
local util = {}
util.ColdFusion = {}

function util.ColdFusion.new(
    maid : Maid,

    layoutOrder : CanBeState<number>,
    text : CanBeState<string?>,
    textColor3 : CanBeState<Color3>,
    typographyData : CanBeState<TypographyData>,
    height : CanBeState<number>,
    textBoxState : ValueState<Enums.TextBoxState>,
    buttonState : ValueState<Enums.ButtonState>,
    inputText : ValueState<string>)

    local _fuse = ColdFusion.fuse(maid)
    local _new = _fuse.new
    local _import = _fuse.import
    local _bind = _fuse.bind
    local _clone = _fuse.clone
    local _Computed = _fuse.Computed
    local _Value = _fuse.Value
   
    local typographyDataState = _import(typographyData, typographyData)
    local heightState = _import(height, height)
    local textState = _import(text, text) :: State<string?>
    local textColor3State = _import(textColor3, Color3.fromRGB())

    local out =  _new("TextBox")({
        LayoutOrder = layoutOrder,
        Size = _Computed(function(num : number, str : string ?) 
            return UDim2.fromOffset(if str then 75 else num, num)
        end, heightState, textState),
        Visible = _Computed(function(str : string?)
            return if str then true else false
        end, textState),
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1,
        PlaceholderColor3 = textColor3State:Tween(),
        PlaceholderText = _Computed(function(str : string?)
            return str or ""
        end, textState),
        LineHeight = _Computed(function(typography : TypographyData)
            return typography.TypeScale.LineHeight
        end, typographyDataState), 
        TextSize = _Computed(function(typography : TypographyData)
            return typography.TypeScale.Size
        end, typographyDataState),
        TextColor3 = textColor3State:Tween(),
        FontFace = _Computed(function(typography : TypographyData)
            for _,fontWeight : Enum.FontWeight in pairs(Enum.FontWeight:GetEnumItems()) do
                if typography.TypeScale.Weight == fontWeight.Value then
                    return Font.fromName(typography.TypeScale.Font.Name, fontWeight)
                end
            end
            return Font.fromName(typography.TypeScale.Font.Name, Enum.FontWeight.Regular) 
        end, typographyDataState),
        TextXAlignment = Enum.TextXAlignment.Left
    }) :: TextBox

    _bind(out)({
        Events = {
            Changed = function(propertyName : string)
                if propertyName == "Text" then
                    if buttonState:Get() == Enums.ButtonState.Disabled then
                        out.Text = ""
                        return
                    end
                    if #out.Text > 0 then 
                        textBoxState:Set(Enums.TextBoxState.Populated) 
                    else 
                        textBoxState:Set(Enums.TextBoxState.Empty) 
                    end
                    inputText:Set(out.Text)
                end

            end,
            Focused = function()
                if buttonState:Get() ~= Enums.ButtonState.Disabled then 
                    buttonState:Set(Enums.ButtonState.Focused)
                end
            end,
            FocusLost = function()
                if buttonState:Get() ~= Enums.ButtonState.Disabled then 
                    buttonState:Set(Enums.ButtonState.Enabled)
                end
            end
        }
    })
    return out
end

return util