--!strict
local _Packages = game:GetService("ReplicatedStorage"):WaitForChild("Packages")
--services 
--packages
local Maid = require(_Packages:WaitForChild("Maid"))
local ColdFusion = require(_Packages:WaitForChild("ColdFusion8"))
--modules
local Base = require(script.Parent:WaitForChild("Base"))

local MaterialColor = require(
    script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("MaterialColor")
) 
local Types = require(script.Parent.Parent.Parent:WaitForChild("Types"))

local Styles = require(script.Parent.Parent.Parent:WaitForChild("Styles"))
local Enums = require(script.Parent.Parent.Parent:WaitForChild("Enums"))

local DynamicTheme = require(script.Parent.Parent:WaitForChild("dynamic_theme"))

local Outlined = require(script.Parent:WaitForChild("CommonButton"):WaitForChild("Outlined"))
--types
type Maid = Maid.Maid

type Fuse = ColdFusion.Fuse
type State<T> = ColdFusion.State<T>
type ValueState<T> = ColdFusion.ValueState<T>
type CanBeState<T> = ColdFusion.CanBeState<T>

type AppearanceData = Types.AppearanceData
type TypographyData = Types.TypographyData
type TransitionData = Types.TransitionData

type ButtonData = {
    Name : string,
    Selected : State<boolean>
}
--constants
--variables
--references
--local functions
--class
local interface = {}

interface.ColdFusion = {}
function interface.ColdFusion.new(
    maid : Maid,
    buttonsList : CanBeState<{[number] : ButtonData}>,
    isDark : CanBeState<boolean>)

    local _fuse = ColdFusion.fuse(maid)
    local _new = _fuse.new
    local _import = _fuse.import
    local _bind = _fuse.bind
    local _clone = _fuse.clone
    local _Computed = _fuse.Computed
    local _Value = _fuse.Value

    local isDarkState = _import(isDark, false)
    local buttonsListState = _import(buttonsList, buttonsList)


    local out = _new("Frame")({
        Children = {
            _new("UIListLayout")({
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
            })
        }
    })
    
    buttonsListState:ForValues(function(buttonData : ButtonData, _maid: Maid)  
        local _fuse = ColdFusion.fuse(_maid) 
        local _Computed = _fuse.Computed
        local button = _maid:GiveTask(Outlined.ColdFusion.new(_maid, buttonData.Name, isDarkState, nil, _Computed(function(selected : boolean)
            return if selected then 3300031967 else nil
        end, buttonData.Selected), buttonData.Selected))
        button.Size = UDim2.fromScale(0.25, 0.5)
        button.Parent = out
        return buttonData 
    end) 
     

    return out :: Frame
end

return interface