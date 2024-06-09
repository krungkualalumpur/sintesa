--!strict
local _Packages = game:GetService("ReplicatedStorage"):WaitForChild("Packages")
--services 
--packages
local Maid = require(_Packages:WaitForChild("Maid"))
local ColdFusion8 = require(_Packages:WaitForChild("ColdFusion8"))
--modules
local Types = require(script.Parent:WaitForChild("Types"))
--types
type Maid = Maid.Maid

type Fuse = ColdFusion8.Fuse
type State<T> = ColdFusion8.State<T>
type ValueState<T> = ColdFusion8.ValueState<T>
type CanBeState<T> = ColdFusion8.CanBeState<T>

type AppearanceData = Types.AppearanceData
--constants
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
    

    local out  = _new("TextButton")({
        Text = text
    })
    return out
end

return button