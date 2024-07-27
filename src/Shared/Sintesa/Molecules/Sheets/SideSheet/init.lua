--!strict
local _Packages = game:GetService("ReplicatedStorage"):WaitForChild("Packages")
--services 
local UserInputService =  game:GetService("UserInputService")
--packages
local Maid = require(_Packages:WaitForChild("Maid"))
local ColdFusion = require(_Packages:WaitForChild("ColdFusion8"))
--modules
local Styles = require(script.Parent.Parent.Parent:WaitForChild("Styles"))
local Types = require(script.Parent.Parent.Parent:WaitForChild("Types"))
local Enums = require(script.Parent.Parent.Parent:WaitForChild("Enums"))
local Icons = require(script.Parent.Parent.Parent:WaitForChild("Icons"))

local MaterialColor = require(
    script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("MaterialColor")
)

local DynamicTheme = require(script.Parent.Parent:WaitForChild("dynamic_theme"))

local ShapeStyle = require(script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("Shape"))
local ElevationStyle = require(script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("Elevation"))

local TextLabel = require(script.Parent.Parent:WaitForChild("Util"):WaitForChild("TextLabel"))
local StandardIconButton = require(script.Parent.Parent:WaitForChild("Buttons"):WaitForChild("IconButton"):WaitForChild("Standard"))
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

    title : CanBeState<string>,

    children : CanBeState<{Instance}>,

    onClose : () -> ())

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
            Enums.ShapeStyle.ExtraLarge,
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
        local surfaceContainerLow = MaterialColor.Color3FromARGB(dynamicScheme:get_surfaceContainerLow())
            
        return  surfaceContainerLow
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
        local onSurfaceVariant = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurfaceVariant())
        local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())
            
        return onSurfaceVariant
    end, appearanceDataState)

    local typographyDataState = _Value(Types.createTypographyData(
        Styles.Typography.get(Enums.TypographyStyle.TitleLarge)
    ))

    -- local getUiCorner = function()
    --     return _new("UICorner")({
    --         CornerRadius = _Computed(function(appearance : AppearanceData) 
    --             return UDim.new(
    --                 0,  
    --                 ShapeStyle.get(appearance.Style)
    --             )
    --         end, appearanceDataState),
    --     })
    -- end

    local content = _new("Frame"){
        BackgroundColor3 = containerColorState,
        Size = UDim2.new(0,300,1,0),
        AutomaticSize = Enum.AutomaticSize.X,
        Children = {
            -- getUiCorner(),
    
        }
    }

    local out = _new("Frame")({
        BackgroundTransparency =  1,
        Size = UDim2.new(1,0,1,0),
        BorderSizePixel = 2,
        Children = {
            _new("UIListLayout")({
                FillDirection = Enum.FillDirection.Vertical,
                VerticalAlignment = Enum.VerticalAlignment.Bottom,
                HorizontalAlignment = Enum.HorizontalAlignment.Right
            }),
            _new("Frame")({
                Name = "Main",
                BackgroundTransparency =  1,
                AutomaticSize = Enum.AutomaticSize.X,
                Size = UDim2.new(0,300,1,0),
                Children = {
                    _new("UIListLayout")({
                        FillDirection = Enum.FillDirection.Vertical,
                        VerticalAlignment = Enum.VerticalAlignment.Bottom,
                        HorizontalAlignment = Enum.HorizontalAlignment.Center
                    }),
                    
                    _bind(content)({
                        Children = {
                            -- _new("Frame")({
                            --     BackgroundColor3 = containerColorState,
                            --     Position = UDim2.new(0,0,0,100),
                            --     Size = UDim2.new(1,0,0,100)
                            -- }),
                            _new("UIPadding")({
                                PaddingTop = UDim.new(0,24),
                                PaddingBottom = UDim.new(0,24),
                                PaddingLeft = UDim.new(0,24),
                                PaddingRight = UDim.new(0,24)
                            }),
                            _new("UIListLayout")({
                                FillDirection = Enum.FillDirection.Vertical,
                                VerticalAlignment = Enum.VerticalAlignment.Top,
                                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                                SortOrder = Enum.SortOrder.LayoutOrder
                            }),
                            _new("Frame")({
                                LayoutOrder = 1,
                                Name = "Header",
                                BackgroundTransparency = 1,
                                Size = UDim2.new(0,300,0,50),
                                Children = {
                                    _new("UIListLayout")({
                                        FillDirection = Enum.FillDirection.Horizontal,
                                        HorizontalAlignment = Enum.HorizontalAlignment.Left,
                                        VerticalAlignment = Enum.VerticalAlignment.Center,
                                        SortOrder = Enum.SortOrder.LayoutOrder
                                    }),
                                    _bind(TextLabel.ColdFusion.new(maid, 1, title, textColorState, typographyDataState, 50)){
                                        Size = UDim2.new(0, 300 - 25),
                                        TextXAlignment = Enum.TextXAlignment.Left
                                    },
                                    _bind(StandardIconButton.ColdFusion.new(maid, Icons.navigation.close, _Value(false), onClose, isDarkState, 25))({
                                        LayoutOrder = 2
                                    })
                                }
                            }),
                            _new("Frame")({
                                LayoutOrder = 2,
                                BackgroundTransparency = 1,
                                AutomaticSize = Enum.AutomaticSize.X,
                                Size = UDim2.new(0,300,0,0),
                                Children = children
                            })
                        }
                    }),
                }
            }),
            
            -- getUiCorner(),
        }
    }) 

    return out :: Frame
end


return interface