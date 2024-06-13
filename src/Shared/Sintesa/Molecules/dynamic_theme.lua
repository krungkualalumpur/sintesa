--!strict
local _Packages = game:GetService("ReplicatedStorage"):WaitForChild("Packages")
--services 
--packages
local Maid = require(_Packages:WaitForChild("Maid"))
local ColdFusion = require(_Packages:WaitForChild("ColdFusion8"))
--modules
local Enums = require(script.Parent.Parent:WaitForChild("Enums"))
--types
type Maid = Maid.Maid

type Fuse = ColdFusion.Fuse
type State<T> = ColdFusion.State<T>
type ValueState<T> = ColdFusion.ValueState<T>
type CanBeState<T> = ColdFusion.CanBeState<T>
--constants
--remotes
--variables
--references
--local functions
--class
local _fuse = ColdFusion.fuse()
local _new = _fuse.new
local _Value = _fuse.Value 

return {
    Color = {
        [Enums.ColorRole.OnPrimary] = _Value(Color3.new(0.713725, 0.129412, 0.945098)),
        [Enums.ColorRole.OnSecondary] = _Value(Color3.new(0.627451, 0.549020, 0.713725)),
        [Enums.ColorRole.OnTertiary] = _Value(Color3.new(0.203922, 0.411765, 0.686275)),
    },
    
} :: {
    Color : {
        [Enums.ColorRole] : ValueState<Color3>
    },

}