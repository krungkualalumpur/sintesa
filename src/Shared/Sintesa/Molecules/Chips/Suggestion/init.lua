--!strict
local _Packages = game:GetService("ReplicatedStorage"):WaitForChild("Packages")
--services 
--packages
local Maid = require(_Packages:WaitForChild("Maid"))
local ColdFusion = require(_Packages:WaitForChild("ColdFusion8"))
--modules
local MaterialColor = require(
    script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("MaterialColor")
) 
local Types = require(script.Parent.Parent.Parent:WaitForChild("Types"))

local Styles = require(script.Parent.Parent.Parent:WaitForChild("Styles"))
local Enums = require(script.Parent.Parent.Parent:WaitForChild("Enums"))

local DynamicTheme = require(script.Parent.Parent:WaitForChild("dynamic_theme"))

local TextLabel = require(script.Parent.Parent:WaitForChild("Util"):WaitForChild("TextLabel"))
local StandardIconButton = require(script.Parent.Parent:WaitForChild("Buttons"):WaitForChild("IconButton"):WaitForChild("Standard"))
local Outlined =  require(script.Parent.Parent:WaitForChild("Buttons"):WaitForChild("CommonButton"):WaitForChild("Outlined"))

--types
type Maid = Maid.Maid

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
local interface = {}
interface.ColdFusion = {}

function interface.ColdFusion.new(
    maid : Maid,
    onClick : () -> ())
    
    local _fuse = ColdFusion.fuse(maid)
    local _new = _fuse.new
    local _import = _fuse.import
    local _bind = _fuse.bind
    local _clone = _fuse.clone
    local _Computed = _fuse.Computed
    local _Value = _fuse.Value

    local base = _bind(Outlined.ColdFusion.new(
        maid, 
        "Suggestion", 
        onClick
    ))({
        
    })

    local canvasGroup = base:FindFirstChild("CanvasGroup")
    local mainFrame = if canvasGroup then canvasGroup:FindFirstChild("Main") else nil
    local textLabel = if mainFrame then mainFrame:FindFirstChild("TextLabel") else nil

    local labelTextColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState, selected : boolean?)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local primary = MaterialColor.Color3FromARGB(dynamicScheme:get_primary())
        local onSecondaryContainer = MaterialColor.Color3FromARGB(dynamicScheme:get_onSecondaryContainer())
        local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())
            
        return if selected == nil then 
            (if _buttonState == Enums.ButtonState.Enabled then primary elseif _buttonState == Enums.ButtonState.Disabled then onSurface else primary)
        else (if selected == true then
            onSecondaryContainer
        else
            onSurface
        )
    end, appearanceDataState, buttonState, isSelectedState)


    if textLabel then 
        _bind(textLabel)({
            TextColor3 = labelTextColorState
        })
        -- print(textLabel, " test?")
    end
    return base
end
return interface