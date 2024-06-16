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
local ElevationStyle = require(script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("Elevation"))

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
    typographyData : CanBeState<TypographyData>)

    local _fuse = ColdFusion.fuse(maid)
    local _new = _fuse.new
    local _import = _fuse.import
    local _bind = _fuse.bind
    local _clone = _fuse.clone
    local _Computed = _fuse.Computed
    local _Value = _fuse.Value

    local appearanceDataState = _import(appearanceData, appearanceData)
    local typographyDataState = _import(typographyData, typographyData)

    
    local out = _new("TextButton")({

        BackgroundColor3 = _Computed(function(appearance : AppearanceData)
            return  MaterialColor.Color3FromARGB(MaterialColor.getDynamicScheme(
                appearance.PrimaryColor, 
                appearance.SecondaryColor, 
                appearance.TertiaryColor, 
                appearance.NeutralColor, 
                appearance.NeutralVariantColor,
                appearance.IsDark
            ):get_primary())
            
        end, appearanceDataState),

        BorderColor3 = _Computed(function(appearance : AppearanceData)
            return appearance.ShadowColor
        end, appearanceDataState),

        BorderSizePixel = 2,

        TextColor3 = _Computed(function(appearance : AppearanceData): Color3
            local onPrimary = MaterialColor.getDynamicScheme(
                appearance.PrimaryColor, 
                appearance.SecondaryColor, 
                appearance.TertiaryColor, 
                appearance.NeutralColor, 
                appearance.NeutralVariantColor,
                appearance.IsDark
            ):get_onPrimary()

            return MaterialColor.Color3FromARGB(onPrimary)
        end, appearanceDataState),

        TextSize = _Computed(function(typography : TypographyData)
            return typography.TypeScale.Size
        end, typographyDataState),

        LineHeight = _Computed(function(typography : TypographyData)
            return typography.TypeScale.LineHeight
        end, typographyDataState),

        FontFace = _Computed(function(typography : TypographyData)
            for _,fontWeight : Enum.FontWeight in pairs(Enum.FontWeight:GetEnumItems()) do
                if typography.TypeScale.Weight == fontWeight.Value then
                    return Font.fromName(typography.TypeScale.Font.Name, fontWeight)
                end
            end
            return Font.fromName(typography.TypeScale.Font.Name, Enum.FontWeight.Regular) 
        end, typographyDataState),

        Text = text,

        Children = {
            _new("UICorner")({
                CornerRadius = _Computed(function(appearance : AppearanceData) 
                    return UDim.new(
                        0,  
                        ShapeStyle.get(appearance.Style)
                    )
                end, appearanceDataState),
            }),
    

            _new("UIStroke")({
                Name = "Shadow",
                Thickness = 6,
                Color = _Computed(function(appearance : AppearanceData)
                    return appearance.ShadowColor
                end, appearanceDataState),
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                Transparency =  _Computed(function(appearance : AppearanceData)
                    return (40 - ElevationStyle.getLevelData(appearance.Elevation))/40
                end, appearanceDataState)
                --[[ AnchorPoint = Vector2.new(0.5, 0.5),
               BackgroundColor3 = _Computed(function(appearance : AppearanceData)
                    return appearance.ShadowColor
                end, appearanceDataState),

                BackgroundTransparency = _Computed(function(appearance : AppearanceData)
                    return (100 - ElevationStyle.getLevelData(appearance.Elevation))/100
                end, appearanceDataState),

                Size = UDim2.fromScale(1.15, 1.15),
                Position = UDim2.fromScale(0.5, 0.5),]]

            })
        }
    })
    return out :: TextButton
end


return interface