--!strict
local _Packages = game:GetService("ReplicatedStorage"):WaitForChild("Packages")
--services 
--packages
local Maid = require(_Packages:WaitForChild("Maid"))
local ColdFusion8 = require(_Packages:WaitForChild("ColdFusion8"))
--modules
--types
type Maid = Maid.Maid

type Fuse = ColdFusion8.Fuse
type State<T> = ColdFusion8.State<T>
type ValueState<T> = ColdFusion8.ValueState<T>
type CanBeState<T> = ColdFusion8.CanBeState<T>
--constants
--variables
--references
--local functions
--class
local Styles = {}

Styles.ColdFusion = {}

function Styles.ColdFusion.new(
    
)
    
end

return Styles