--!strict
local _Packages = game:GetService("ReplicatedStorage"):WaitForChild("Packages")
--services 
local UserInputService =  game:GetService("UserInputService")
--packages
local Maid = require(_Packages:WaitForChild("Maid"))
local ColdFusion = require(_Packages:WaitForChild("ColdFusion8"))
--modules
local Types = require(script.Parent.Parent:WaitForChild("Types"))
local Enums = require(script.Parent.Parent:WaitForChild("Enums"))
local Icons = require(script.Parent.Parent:WaitForChild("Icons"))

local MaterialColor = require(
    script.Parent.Parent:WaitForChild("Styles"):WaitForChild("MaterialColor")
)

local DynamicTheme = require(script.Parent:WaitForChild("dynamic_theme"))
local Styles = require(script.Parent.Parent:WaitForChild("Styles"))

local ShapeStyle = require(script.Parent.Parent:WaitForChild("Styles"):WaitForChild("Shape"))
local ElevationStyle = require(script.Parent.Parent:WaitForChild("Styles"):WaitForChild("Elevation"))

local TextLabel = require(script.Parent:WaitForChild("Util"):WaitForChild("TextLabel"))
local StandardTextButton = require(script.Parent:WaitForChild("Buttons"):WaitForChild("CommonButton"):WaitForChild("Text"))

local StandardIconButton = require(script.Parent:WaitForChild("Buttons"):WaitForChild("IconButton"):WaitForChild("Standard"))
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
    actionText : CanBeState<string>,
    supportingText : CanBeState<string>,

    onAction : () -> (),
    onClose : (() -> ())?)

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
            Enums.ShapeStyle.None,
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
        local inverseSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_inverseSurface())
            
        return  inverseSurface
    end, appearanceDataState)
    
    local textColorState = _Computed(function(appearance : AppearanceData)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local inversePrimary = MaterialColor.Color3FromARGB(dynamicScheme:get_inversePrimary())
            
        return inversePrimary 
    end, appearanceDataState)
    local supportingTextColorState = _Computed(function(appearance : AppearanceData)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local inverseOnSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_inverseOnSurface())
            
        return inverseOnSurface 
    end, appearanceDataState)
    local iconColorState = _Computed(function(appearance : AppearanceData)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local inverseOnSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_inverseOnSurface())
            
        return inverseOnSurface 
    end, appearanceDataState)
    local typographyDataState = _Value(Types.createTypographyData(
        Styles.Typography.get(Enums.TypographyStyle.LabelLarge)
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
        Size = UDim2.new(0,100,0,48),
        BorderSizePixel = 2,
        Children = {
            _new("Frame")({
                Name = "Main",
                AutomaticSize = Enum.AutomaticSize.XY,
                AnchorPoint = Vector2.new(0.5,0.5),
                ClipsDescendants = false,
                Size = UDim2.new(0.92, 0, 0.92,0),
                BackgroundColor3 = containerColorState,
                Position = UDim2.fromScale(0.5,0.5),
                Children = {
                    getUiCorner(),
                    _new("UIPadding")({
                        PaddingTop = UDim.new(0, 16),
                        PaddingBottom = UDim.new(0, 16),
                        PaddingLeft = UDim.new(0, 16),
                        PaddingRight = UDim.new(0, 16),

                    }),

                    _new("UIListLayout")({
                        FillDirection = Enum.FillDirection.Horizontal, 
                        Padding = UDim.new(0, 16),
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        VerticalAlignment = Enum.VerticalAlignment.Center
                    }),
                    TextLabel.ColdFusion.new(maid, 1, supportingText, supportingTextColorState, typographyDataState, 48 - 16*2),
                    
                    _bind(StandardTextButton.ColdFusion.new(maid, actionText, onAction, isDarkState, 48 - 16*2, nil, textColorState))({
                        LayoutOrder = 3,
                        
                    }),
                    --TextLabel.ColdFusion.new(maid, 2, actionText, textColorState, typographyDataState, 48 - 16*2),

                    if onClose then
                        _bind(StandardIconButton.ColdFusion.new(maid, Icons.navigation.close, _Value(false), function()  
                        
                        end, isDarkState, 48 - 16*2, nil, iconColorState))({
                            LayoutOrder = 4
                        })
                    else nil :: any
                }
            }),
            
            getUiCorner(),
        }
    }) 

    return out :: Frame
end


return interface