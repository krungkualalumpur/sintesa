--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Package = ReplicatedStorage:WaitForChild("Packages")
--services
--packages
local Maid = require(Package:WaitForChild("Maid"))
local ColdFusion = require(Package:WaitForChild("ColdFusion8"))
--modules
local MaterialColor = require(
    script.Parent.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("MaterialColor")
) 

local DynamicTheme = require(script.Parent.Parent.Parent:WaitForChild("dynamic_theme"))

local Search = require(script.Parent)
local Types = require(script.Parent.Parent.Parent.Parent:WaitForChild("Types"))
local Icons = require(script.Parent.Parent.Parent.Parent:WaitForChild("Icons"))
local Styles = require(script.Parent.Parent.Parent.Parent:WaitForChild("Styles"))
local Enums = require(script.Parent.Parent.Parent.Parent:WaitForChild("Enums"))

local TextLabel = require(script.Parent.Parent.Parent:WaitForChild("Util"):WaitForChild("TextLabel"))
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

    local leadingIconId = Icons.navigation.arrow_back
    local text = "Search heah"
    local trailingIconId = Icons.navigation.close

    local width = _Value(950)

    local inputText = _Value("")
    
    local out = Search.ColdFusion.new(
        maid,
        isDark,
        leadingIconId,
        text,
        width,
        inputText,

        trailingIconId
    )

    local bg = _new("Frame")({
        Size = UDim2.fromScale(1, 1),
        Children = {
            out
        }
    }) ::Frame

    maid:GiveTask(bg.Changed:Connect(function()
        width:Set(bg.AbsoluteSize.X) 
        print(inputText:Get())
    end))
    bg.Parent = target
    return function()
        maid:Destroy()
    end
end