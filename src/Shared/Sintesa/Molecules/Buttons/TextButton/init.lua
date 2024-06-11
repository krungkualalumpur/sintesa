--!strict
local _Packages = game:GetService("ReplicatedStorage"):WaitForChild("Packages")
--services 
--packages
local Maid = require(_Packages:WaitForChild("Maid"))
local ColdFusion8 = require(_Packages:WaitForChild("ColdFusion8"))
--modules
local Types = require(script.Parent.Parent.Parent:WaitForChild("Types"))
local MaterialColor = require(script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("MaterialColor"))
--types
type Maid = Maid.Maid

type Fuse = ColdFusion8.Fuse
type State<T> = ColdFusion8.State<T>
type ValueState<T> = ColdFusion8.ValueState<T>
type CanBeState<T> = ColdFusion8.CanBeState<T>

type AppearanceData = Types.AppearanceData
--constants
local PRIMARY_COLOR = Color3.fromHSV(0.000000, 0.000000, 0.811765)
local SECONDARY_COLOR = Color3.fromHSV(0.000000, 0.000000, 0.811765)
local TERTIARY_COLOR = Color3.fromHSV(0.000000, 0.000000, 0.811765)

--variables
--references
--local functions
--class
local button = {}

button.ColdFusion = {}

function button.ColdFusion.new(
    text : CanBeState<string>,
    appearance : AppearanceData
)
    local _maid = Maid.new()

    local _fuse = ColdFusion8.fuse(_maid)
    local _new = _fuse.new
    local _import = _fuse.import 

    local textState = _import(text, "")

    local primaryColorState = _import(appearance.PrimaryColor, PRIMARY_COLOR)

    print(MaterialColor.getDynamicColor(primaryColorState:Get(), Color3.fromRGB(164, 209, 138),Color3.fromRGB(31, 101, 194),Color3.fromRGB(255,255,255),Color3.fromRGB(255,255,255)))
    local out  = _new("TextButton")({
        BackgroundColor3 = primaryColorState,
        Text = textState,
    })
    return out
end

return button