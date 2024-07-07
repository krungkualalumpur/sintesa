--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Package = ReplicatedStorage:WaitForChild("Packages")
--services
--packages
local Maid = require(Package:WaitForChild("Maid"))
local ColdFusion = require(Package:WaitForChild("ColdFusion8"))
--modules
local NavigationBar = require(script.Parent)
local Types = require(script.Parent.Parent.Parent.Parent:WaitForChild("Types"))
local Icons = require(script.Parent.Parent.Parent.Parent:WaitForChild("Icons"))
--types
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
return function(target : CoreGui) 
    local maid = Maid.new()

    local _fuse = ColdFusion.fuse(maid)
    local _new = _fuse.new
    local _import = _fuse.import
    local _bind = _fuse.bind
    local _clone = _fuse.clone
    local _Computed = _fuse.Computed
    local _Value = _fuse.Value

    local out = NavigationBar.ColdFusion.new(
        maid, 
        false, 
        "Pleang Chat Thai",
        {
            {
                Name = "Experiment",
                Buttons = {
                    Types.createFusionButtonData("acce_new", Icons.action.accessibility_new, _Value(false)),
                    Types.createFusionButtonData("acce_for", Icons.action.accessible_forward, _Value(false)),
                    Types.createFusionButtonData("acc_bal", Icons.action.account_balance, _Value(false)),
                    Types.createFusionButtonData("add_chart", Icons.action.addchart, _Value(false), 1),
                },
            },
            {
                Name = "Email",
                Buttons = {
                    Types.createFusionButtonData("Inbox", Icons.action.all_inbox, _Value(false)),
                    Types.createFusionButtonData("Outbox", Icons.action.outbox, _Value(false), 2),
                    Types.createFusionButtonData("Favorites", Icons.action.favorite, _Value(false)),
                    Types.createFusionButtonData("Trash", Icons.action.delete, _Value(false)),
                },
            },
        },
        function(buttonData : Types.ButtonData)  
            print((if buttonData then buttonData.Name or "" else "") .. " clicked!")
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