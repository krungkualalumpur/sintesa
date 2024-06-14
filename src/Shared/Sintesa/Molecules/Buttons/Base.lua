--!strict
local _Packages = game:GetService("ReplicatedStorage"):WaitForChild("Packages")
--services 
--packages
local Maid = require(_Packages:WaitForChild("Maid"))
local ColdFusion = require(_Packages:WaitForChild("ColdFusion8"))
--modules
local Types = require(script.Parent.Parent.Parent:WaitForChild("Types"))
local Enums = require(script.Parent.Parent.Parent:WaitForChild("Enums"))

local MaterialColor = require(
    script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("MaterialColor")
)

local DynamicTheme = require(script.Parent.Parent:WaitForChild("dynamic_theme"))

local ShapeStyle = require(script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("Shape"))

--types
type Maid = Maid.Maid

type Fuse = ColdFusion.Fuse
type State<T> = ColdFusion.State<T>
type ValueState<T> = ColdFusion.ValueState<T>
type CanBeState<T> = ColdFusion.CanBeState<T>

type TypographyData = Types.TypographyData
type AppearanceData = Types.AppearanceData
type TypeScaleData = Types.TypeScaleData

export type ButtonStates = {
    [Enums.ButtonState] : {
        Container : AppearanceData,
        LabelText : TypeScaleData
    }
}
--constants
local DEFAULT_COLOR = Color3.fromRGB(200,200,200)
--remotes
--variables
--references
--local functions
--class
local interface = {}

interface.ColdFusion = {}

function interface.ColdFusion.new(
    maid : Maid,
    
    text : CanBeState<string>,

    appearanceData : CanBeState<AppearanceData>,
    typographyData : CanBeState<TypographyData>,

    state : CanBeState<Enums.ButtonState>)

    local _fuse = ColdFusion.fuse(maid)
    local _new = _fuse.new
    local _import = _fuse.import
    local _bind = _fuse.bind
    local _clone = _fuse.clone
    local _Computed = _fuse.Computed
    local _Value = _fuse.Value

    local buttonState : State<Enums.ButtonState> = _import(state :: Enums.ButtonState, Enums.ButtonState.Enabled)

    local appearanceDataState = _import(appearanceData, appearanceData)
    local typographyDataState = _import(typographyData, typographyData)

    --[[local function getCurrentPrimary(
        primaryColor : Color3,
        secondaryColor : Color3,
        tertiaryColor : Color3,
        neutralColor : Color3,
        neutralVariantColor : Color3)

        local DynamicScheme = MaterialColor.getDynamicScheme(
            primaryColor,   
            secondaryColor,
            tertiaryColor,
            neutralColor,
            neutralVariantColor
        )

        return DynamicScheme:get_primaryContainer()
    end]]
    local out = _new("TextButton")({
        BackgroundColor3 = _Computed(function(appearance : AppearanceData, _state : Enums.ButtonState)
            return  MaterialColor.Color3FromARGB(MaterialColor.getDynamicScheme(
                appearance.PrimaryColor, 
                appearance.SecondaryColor, 
                appearance.TertiaryColor, 
                appearance.NeutralColor, 
                appearance.NeutralVariantColor
            ):get_primary())
            
        end, appearanceDataState, buttonState),

        TextColor3 = _Computed(function(appearance : AppearanceData, _state : Enums.ButtonState)
            return MaterialColor.Color3FromARGB(MaterialColor.getDynamicScheme(
                appearance.PrimaryColor, 
                appearance.SecondaryColor, 
                appearance.TertiaryColor, 
                appearance.NeutralColor, 
                appearance.NeutralVariantColor
            ):get_onPrimary())
        end, appearanceDataState, buttonState),

        Text = text,

        Children = {
            _new("UICorner")({
                CornerRadius = _Computed(function(appearance : AppearanceData, _state : Enums.ButtonState) 
                    return UDim.new(
                        0,  
                        ShapeStyle.get(appearance.Style)
                    )
                end, appearanceDataState, buttonState)
            })
        }
    })
    return out 
end


return interface