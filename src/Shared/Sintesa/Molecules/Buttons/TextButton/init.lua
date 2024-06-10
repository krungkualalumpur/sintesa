--!strict
local _Packages = game:GetService("ReplicatedStorage"):WaitForChild("Packages")
--services 
--packages
local Maid = require(_Packages:WaitForChild("Maid"))
local ColdFusion8 = require(_Packages:WaitForChild("ColdFusion8"))
--modules
local DynamicScheme = require(script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("MaterialColor"):WaitForChild("dynamiccolor"):WaitForChild("dynamic_scheme"))
local DynamicColor = require(script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("MaterialColor"):WaitForChild("dynamiccolor"):WaitForChild("dynamic_color"))
local ColorUtil = require(script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("MaterialColor"):WaitForChild("utils"):WaitForChild("color_utils"))
local Types = require(script.Parent.Parent.Parent:WaitForChild("Types"))
--types
type Maid = Maid.Maid

type Fuse = ColdFusion8.Fuse
type State<T> = ColdFusion8.State<T>
type ValueState<T> = ColdFusion8.ValueState<T>
type CanBeState<T> = ColdFusion8.CanBeState<T>

type AppearanceData = Types.AppearanceData
--constants
local PRIMARY_COLOR = Color3.fromHSV(0.000000, 0.000000, 0.811765)
local SECONDARY_COLOR = Color3.fromHSV(0.000000, 0.000000, 0.811765)
local TERTIARY_COLOR = Color3.fromHSV(0.000000, 0.000000, 0.811765)

--variables
--references
--local functions
--class
local button = {}

button.ColdFusion = {}

function button.ColdFusion.new(
    text : CanBeState<string>,
    appearance : AppearanceData
)
    local _maid = Maid.new()

    local _fuse = ColdFusion8.fuse(_maid)
    local _new = _fuse.new
    local _import = _fuse.import 

    local textState = _import(text, "")

    local primaryColorState = _import(appearance.PrimaryColor, PRIMARY_COLOR)

    local dynamicColor = DynamicColor.DynamicColor.new()
    
    local dynamic_Scheme = DynamicScheme.DynamicScheme.new({
        ColorUtil.argbFromRgb(primaryColorState:Get().R, primaryColorState:Get().G, primaryColorState:Get().B);
        variant: Variant.Variant;
        contrastLevel: number;
        isDark: boolean;
        primaryPalette: TonalPalette;
        secondaryPalette: TonalPalette;
        tertiaryPalette: TonalPalette;
        neutralPalette: TonalPalette;
        neutralVariantPalette: TonalPalette;
    })
    local argb = dynamicColor:getArgb(dynamic_Scheme)
    print(argb)

    local out  = _new("TextButton")({
        BackgroundColor = primaryColorState,
        Text = textState,
    })
    return out
end

return button