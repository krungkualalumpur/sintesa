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
        [Enums.ColorRole.Primary] = _Value(Color3.new(0.713725, 0.129412, 0.945098)),
        [Enums.ColorRole.Secondary] = _Value(Color3.new(0.627451, 0.549020, 0.713725)),
        [Enums.ColorRole.Tertiary] = _Value(Color3.new(0.203922, 0.411765, 0.686275)),
        [Enums.ColorRole.Surface] = _Value(Color3.fromRGB(220,220,220)), --neutral colors in general
        [Enums.ColorRole.SurfaceDim] = _Value(Color3.fromRGB(180,180,180)), -- neutral variant colors in general
        [Enums.ColorRole.Shadow] = _Value(Color3.new(0.011765, 0.011765, 0.011765))
    },
    
} :: {
    Color : {
        [Enums.ColorRole] : ValueState<Color3>
    },

}