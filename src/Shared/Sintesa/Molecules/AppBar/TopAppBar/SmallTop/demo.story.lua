--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Package = ReplicatedStorage:WaitForChild("Packages")
--services
--packages
local Maid = require(Package:WaitForChild("Maid"))
local ColdFusion = require(Package:WaitForChild("ColdFusion8"))
--modules
local CenterAligned = require(script.Parent)
local Types = require(script.Parent.Parent.Parent.Parent.Parent:WaitForChild("Types"))
--types
type Fuse = ColdFusion.Fuse
type State<T> = ColdFusion.State<T>
type ValueState<T> = ColdFusion.ValueState<T>
type CanBeState<T> = ColdFusion.CanBeState<T>

type IconRef = CenterAligned.IconRef
--constants
--remotes
--variables
--references
--local functions 
--class
return function(target : CoreGui) 
    local maid = Maid.new()

    local _fuse = ColdFusion.fuse(maid)
    local _new = _fuse.new
    local _import = _fuse.import
    local _bind = _fuse.bind
    local _clone = _fuse.clone
    local _Computed = _fuse.Computed
    local _Value = _fuse.Value

    local onScroll = _Value(false)
    local leadingButton = Types.createButtonData("Leading", 15567843390)
    local trailingButton = Types.createButtonData("Trailing", 13805569043)

    local out = CenterAligned.ColdFusion.new(
        maid, 
        false, 
        "Welcome to the interface!",
        leadingButton,
        {trailingButton, trailingButton, trailingButton},
        onScroll,
        function(buttonData : Types.ButtonData)  
            if buttonData.Selected then
                buttonData.Selected:Set(not buttonData.Selected:Get())
            end
        end
    )
    out.Parent = target
    return function()
        maid:Destroy()
    end
end