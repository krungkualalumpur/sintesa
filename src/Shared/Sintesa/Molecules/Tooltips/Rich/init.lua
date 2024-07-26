--!strict
local _Packages = game:GetService("ReplicatedStorage"):WaitForChild("Packages")
--services 
local UserInputService =  game:GetService("UserInputService")
--packages
local Maid = require(_Packages:WaitForChild("Maid"))
local ColdFusion = require(_Packages:WaitForChild("ColdFusion8"))
--modules
local Types = require(script.Parent.Parent.Parent:WaitForChild("Types"))
local Enums = require(script.Parent.Parent.Parent:WaitForChild("Enums"))

local MaterialColor = require(
    script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("MaterialColor")
)
local Styles = require(script.Parent.Parent.Parent:WaitForChild("Styles"))

local DynamicTheme = require(script.Parent.Parent:WaitForChild("dynamic_theme"))

local ShapeStyle = require(script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("Shape"))
local ElevationStyle = require(script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("Elevation"))

local TextLabel = require(script.Parent.Parent:WaitForChild("Util"):WaitForChild("TextLabel"))
local StandardTextButton = require(script.Parent.Parent:WaitForChild("Buttons"):WaitForChild("CommonButton"):WaitForChild("Text"))
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
local PADDING_SIZE = UDim.new(0,12)
--remotes
--variables
--references
--local functions
local function mouseIsInButton(button : GuiObject)
    local mouse = UserInputService:GetMouseLocation()
    if ((mouse.X > button.AbsolutePosition.X) and (mouse.X < (button.AbsolutePosition.X + button.AbsoluteSize.X))) 
    and ((mouse.Y > button.AbsolutePosition.Y) and (mouse.Y < (button.AbsolutePosition.Y + button.AbsoluteSize.Y))) then
        return true
    end
    return false
end
--class
local interface = {}

interface.ColdFusion = {}

function interface.ColdFusion.new(
    maid : Maid,

    isDark : CanBeState<boolean>,
    subText : CanBeState<string>,
    supportingText : CanBeState<string>,
    actionText : CanBeState<string>,

    onActionClick : () -> ())

    local _fuse = ColdFusion.fuse(maid)
    local _new = _fuse.new
    local _import = _fuse.import
    local _bind = _fuse.bind
    local _clone = _fuse.clone
    local _Computed = _fuse.Computed
    local _Value = _fuse.Value
  
    local isDarkState = _import(isDark, false)

    local appearanceDataState = _Computed(
        function(
            dark : boolean
        ) 
           
        return Types.createAppearanceData(
            DynamicTheme.Color[Enums.ColorRole.Primary],
            DynamicTheme.Color[Enums.ColorRole.Secondary],
            DynamicTheme.Color[Enums.ColorRole.Tertiary],

            DynamicTheme.Color[Enums.ColorRole.Surface],
            DynamicTheme.Color[Enums.ColorRole.SurfaceDim],
            DynamicTheme.Color[Enums.ColorRole.Shadow],
        
            Enums.ElevationResting.Level0,

            Enums.ShapeSymmetry.Full,
            Enums.ShapeStyle.Medium,
            1,

            dark
        )
    end, isDarkState)

    local containerColorState = _Computed(function(appearance : AppearanceData)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local surfaceContainer = MaterialColor.Color3FromARGB(dynamicScheme:get_surfaceContainer())
        return surfaceContainer
    end, appearanceDataState)

    local textSupportingColorState = _Computed(function(appearance : AppearanceData)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local onSurfaceVariant = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurfaceVariant())
            
        return onSurfaceVariant 
    end, appearanceDataState)
    local subheadTextTypographyDataState = _Value(Types.createTypographyData(
        Styles.Typography.get(Enums.TypographyStyle.TitleSmall)
    ))
    local supportingTextTypographyDataState = _Value(Types.createTypographyData(
        Styles.Typography.get(Enums.TypographyStyle.BodyMedium)
    ))

    local getUiCorner = function()
        return _new("UICorner")({
            CornerRadius = _Computed(function(appearance : AppearanceData) 
                return UDim.new(
                    0,  
                    ShapeStyle.get(appearance.Style)
                )
            end, appearanceDataState),
        })
    end

   
    local out = _new("Frame")({
        
        AutomaticSize = Enum.AutomaticSize.XY,
        AnchorPoint = Vector2.new(0.5,0.5),
        BackgroundColor3 = _Computed(function(appearance : AppearanceData)
            return appearance.ShadowColor
        end, appearanceDataState),
        BackgroundTransparency =  _Computed(function(appearance : AppearanceData)
            return (100 - ElevationStyle.getLevelData(appearance.Elevation))/100
        end, appearanceDataState),
        Size = UDim2.new(0,0,0,24 ),
        BorderSizePixel = 2,
        Children = {
           
            _new("Frame")({
                Name = "Main",
                AutomaticSize = Enum.AutomaticSize.XY,
                AnchorPoint = Vector2.new(0.5,0.5),
                ClipsDescendants = false,
                Size = --[[if hasShadow then UDim2.new(0.92, 0, 0.92,0) else]] UDim2.new(0.92, 0, 0.92,0),
                BackgroundColor3 = containerColorState,
                Position = UDim2.fromScale(0.5,0.5),
                Children = {
                    _new("UIPadding")({
                        PaddingLeft = UDim.new(0, 8),
                        PaddingRight = UDim.new(0, 8),
                        PaddingTop = UDim.new(0, 8),
                        PaddingBottom = UDim.new(0, 8),

                    }),
                    getUiCorner(),
                    _new("UIListLayout")({
                        Padding =UDim.new(0,4),
                        HorizontalAlignment=  Enum.HorizontalAlignment.Left,
                        SortOrder = Enum.SortOrder.LayoutOrder
                    }),
                    _bind(TextLabel.ColdFusion.new(maid, 1, subText, textSupportingColorState, subheadTextTypographyDataState, 24))({
                        AutomaticSize = Enum.AutomaticSize.XY,
                        TextWrapped = true,
                        Size = UDim2.new(0,0,0,24),
                        TextXAlignment = Enum.TextXAlignment.Left
                    }),
                    _bind(TextLabel.ColdFusion.new(maid, 2, supportingText, textSupportingColorState, supportingTextTypographyDataState, 24))({
                        AutomaticSize = Enum.AutomaticSize.XY,
                        TextWrapped = true,
                        Size = UDim2.new(0,0,0,24),
                        TextXAlignment = Enum.TextXAlignment.Left,
                    }),
                    _new("Frame")({
                        LayoutOrder = 3,
                        Size = UDim2.fromOffset(0, 12 - 4)
                    }),
                    _bind(StandardTextButton.ColdFusion.new(maid, actionText, onActionClick, isDarkState, 30))({
                        LayoutOrder = 4,
                    })
                },
            }),
            
            getUiCorner(),
            Children = {
                _new("UISizeConstraint")({
                    MaxSize = Vector2.new(500,500)
                })
            }
        }
    }) 

    return out :: Frame
end


return interface