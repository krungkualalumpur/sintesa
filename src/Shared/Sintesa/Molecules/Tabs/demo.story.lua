--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Package = ReplicatedStorage:WaitForChild("Packages")
--services
--packages
local Maid = require(Package:WaitForChild("Maid"))
local ColdFusion = require(Package:WaitForChild("ColdFusion8"))
--modules
local MaterialColor = require(
    script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("MaterialColor")
) 

local DynamicTheme = require(script.Parent.Parent:WaitForChild("dynamic_theme"))

local FilledTextField: any = require(script.Parent)
local Types = require(script.Parent.Parent.Parent:WaitForChild("Types"))
local Icons = require(script.Parent.Parent.Parent:WaitForChild("Icons"))
local Styles = require(script.Parent.Parent.Parent:WaitForChild("Styles"))
local Enums = require(script.Parent.Parent.Parent:WaitForChild("Enums"))

local TextLabel = require(script.Parent.Parent:WaitForChild("Util"):WaitForChild("TextLabel"))
--types
type Fuse = ColdFusion.Fuse
type State<T> = ColdFusion.State<T>
type ValueState<T> = ColdFusion.ValueState<T>
type CanBeState<T> = ColdFusion.CanBeState<T>

type AppearanceData = Types.AppearanceData
type TypographyData = Types.TypographyData
type TransitionData = Types.TransitionData

type ButtonData = Types.ButtonData

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
  
    local isDark = _Value(false)


    local everythingVal = _Value(true)
    local accessibleVal = _Value(false)
    local troubleshootVal = _Value(false)

    local out = FilledTextField.ColdFusion.new(
        maid,
        isDark,

        {
            Types.createFusionButtonData("Everything", Icons.action.abc, everythingVal),
            Types.createFusionButtonData("Sumb", Icons.action.accessible, accessibleVal),
            Types.createFusionButtonData("Troubleshoot", Icons.action.troubleshoot, troubleshootVal),

        },

        function(buttonData : Types.ButtonData)
            if buttonData.Name == "Everything" then
                everythingVal:Set(true)
                accessibleVal:Set(false)
                troubleshootVal:Set(false)
            elseif buttonData.Name == "Sumb" then
                everythingVal:Set(false)
                accessibleVal:Set(true)
                troubleshootVal:Set(false)
            elseif buttonData.Name == "Troubleshoot" then
                everythingVal:Set(false)
                accessibleVal:Set(false)
                troubleshootVal:Set(true)
            end
        end
    )
    out.Position = UDim2.fromScale(0.4, 0.4)

    local bg = _new("Frame")({
        Size = UDim2.fromScale(1, 1),
        Children = {
            out
        }
    })
    bg.Parent = target
    return function()
        maid:Destroy()
    end
end