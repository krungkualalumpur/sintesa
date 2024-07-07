--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Package = ReplicatedStorage:WaitForChild("Packages")
--services
--packages
local Maid = require(Package:WaitForChild("Maid"))
local ColdFusion = require(Package:WaitForChild("ColdFusion8"))
--modules
local BottomAppBar = require(script.Parent)
local Types = require(script.Parent.Parent.Parent.Parent:WaitForChild("Types"))
local Icons = require(script.Parent.Parent.Parent.Parent:WaitForChild("Icons"))
--types
type Fuse = ColdFusion.Fuse
type State<T> = ColdFusion.State<T>
type ValueState<T> = ColdFusion.ValueState<T>
type CanBeState<T> = ColdFusion.CanBeState<T>

type IconRef = BottomAppBar.IconRef
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
    --local leadingButton = Types.createFusionButtonData("Trailing", Icons.navigation.offline_share)
    local trailingButton = Types.createFusionButtonData("Leading", Icons.content.add)

    local out = BottomAppBar.ColdFusion.new(
        maid, 
        false, 
        {
            Types.createFusionButtonData("Trailing", Icons.file.attachment), 
            Types.createFusionButtonData("Trailing", Icons.image.image), 
            Types.createFusionButtonData("Trailing", Icons.navigation.offline_share)
        } ,
        trailingButton,
        onScroll,
        function(buttonData : Types.ButtonData)  
            if buttonData.Selected then
                buttonData.Selected:Set(not buttonData.Selected:Get())
            end
        end
    )
    
    local screen = _new("Frame")({
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        Parent = target,
        Children = {
            out
        }
    })

    --out.Parent = target
    return function()
        maid:Destroy()
    end
end