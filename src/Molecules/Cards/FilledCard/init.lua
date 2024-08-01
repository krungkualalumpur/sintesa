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

local TextLabel = require(script.Parent.Parent:WaitForChild("Util"):WaitForChild("TextLabel"))
local StandardIconButton = require(script.Parent.Parent:WaitForChild("Buttons"):WaitForChild("IconButton"):WaitForChild("Standard"))

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

export type IconRef = "Leading" | "Trailing"
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

    isDark : CanBeState<boolean>,
    children : {CanBeState<Instance>},

    onButtonClicked : (ButtonData) -> ())
    
    local _fuse = ColdFusion.fuse(maid)
    local _new = _fuse.new
    local _import = _fuse.import
    local _bind = _fuse.bind
    local _clone = _fuse.clone
    local _Computed = _fuse.Computed
    local _Value = _fuse.Value

    local stateState = _Value(Enums.ButtonState.Enabled :: Enums.ButtonState)
    local isDarkState = _import(isDark, false)
    local appearanceData = _Computed(
        function(
            dark : boolean,
            state : Enums.ButtonState   
        ) 
            
        return Types.createAppearanceData(
            DynamicTheme.Color[Enums.ColorRole.Primary],
            DynamicTheme.Color[Enums.ColorRole.Secondary],
            DynamicTheme.Color[Enums.ColorRole.Tertiary],

            DynamicTheme.Color[Enums.ColorRole.Surface],
            DynamicTheme.Color[Enums.ColorRole.SurfaceDim],
            DynamicTheme.Color[Enums.ColorRole.Shadow],
 
            if state == Enums.ButtonState.Enabled then Enums.ElevationResting.Level0
                elseif state == Enums.ButtonState.Disabled then Enums.ElevationResting.Level0 
                elseif state == Enums.ButtonState.Focused then Enums.ElevationResting.Level1
                elseif state == Enums.ButtonState.Pressed then Enums.ElevationResting.Level0 
                elseif state == Enums.ButtonState.Dragged then Enums.ElevationResting.Level3 
            else Enums.ElevationResting.Level0,

            Enums.ShapeSymmetry.Full,
            Enums.ShapeStyle.Medium,
            64,

            dark
        )
    end, isDarkState, stateState)

    local appearanceDataState = _import(appearanceData, appearanceData)
 
    local containerColorState = _Computed(function(appearance : AppearanceData, state : Enums.ButtonState)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local surface = MaterialColor.Color3FromARGB(dynamicScheme:get_surface())
        local surfaceContainerHighest = MaterialColor.Color3FromARGB(dynamicScheme:get_surfaceContainerHighest())
        local surfaceVariant = MaterialColor.Color3FromARGB(dynamicScheme:get_surfaceVariant())

        return if state == Enums.ButtonState.Enabled then surfaceContainerHighest 
            elseif state == Enums.ButtonState.Disabled then surfaceVariant 
            else surfaceContainerHighest
    end, appearanceDataState, stateState)



   --[[ local trailingIcon = StandardIconButton.ColdFusion.new(
        maid, 
        trailingIconId, 
        _Computed(function(iconRef : IconRef?)
            return iconRef == "Trailing" 
        end, iconSelected),
        onTrailingIconClicked,
        isDarkState,
        24
    )]]

    local out = Base.ColdFusion.new(
        maid, 
        containerColorState, 
        appearanceDataState,
        true, 
        children
    )
    return out :: Frame
end

return interface