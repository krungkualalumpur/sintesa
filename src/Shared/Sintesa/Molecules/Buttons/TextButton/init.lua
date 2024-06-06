--!strict
local _Packages = game:GetService("ReplicatedStorage"):WaitForChild("Packages")
--services 
--packages
local ColdFusion8 = require(_Packages:WaitForChild("ColdFusion8"))
--modules
--types
type Fuse = ColdFusion8.Fuse
type State<T> = ColdFusion8.State<T>
type ValueState<T> = ColdFusion8.ValueState<T>
type CanBeState<T> = ColdFusion8.CanBeState<T>
--constants
--variables
--references
--local functions
--class
local button = {}

button.ColdFusion = {}

function button.ColdFusion.new(
    textLabel : CanBeState<string>
)
    local _fuse = ColdFusion8.fuse
    local _new = ColdFusion8.new
    
    local out  = _new("TextButton")({
        
    })
    return out
end

return button