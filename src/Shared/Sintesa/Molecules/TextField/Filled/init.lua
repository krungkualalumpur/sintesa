--!strict
local _Packages = game:GetService("ReplicatedStorage"):WaitForChild("Packages")
--services 
local UserInputService =  game:GetService("UserInputService")
--packages
local Maid = require(_Packages:WaitForChild("Maid"))
local ColdFusion = require(_Packages:WaitForChild("ColdFusion8"))
--modules
local Types = require(script.Parent.Parent.Parent:WaitForChild("Types"))
local Icons = require(script.Parent.Parent.Parent:WaitForChild("Icons"))
local Enums = require(script.Parent.Parent.Parent:WaitForChild("Enums"))
local Styles = require(script.Parent.Parent.Parent:WaitForChild("Styles"))

local MaterialColor = require(
    script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("MaterialColor")
)

local DynamicTheme = require(script.Parent.Parent:WaitForChild("dynamic_theme"))

local ShapeStyle = require(script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("Shape"))
local ElevationStyle = require(script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("Elevation"))

local StandartButton = require(script.Parent.Parent:WaitForChild("Buttons"):WaitForChild("IconButton"):WaitForChild("Standard"))
local TextBox = require(script.Parent.Parent:WaitForChild("Util"):WaitForChild("TextBox"))
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
local Interface = {}
Interface.ColdFusion = {}

function Interface.ColdFusion.new(
    maid : Maid,
    layoutOrder : CanBeState<number>,
    isDark : CanBeState<boolean>,
    text : CanBeState<string?>,
    height : CanBeState<number>)

    local _fuse = ColdFusion.fuse(maid)
    local _new = _fuse.new
    local _import = _fuse.import
    local _bind = _fuse.bind
    local _clone = _fuse.clone
    local _Computed = _fuse.Computed
    local _Value = _fuse.Value

    local isDarkState = _import(isDark, false)
    local buttonState = _Value(Enums.ButtonState.Enabled :: Enums.ButtonState) 

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
            64,

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
        local surfaceContainerHighest = MaterialColor.Color3FromARGB(dynamicScheme:get_surfaceContainerHighest())
            
        return  surfaceContainerHighest
    end, appearanceDataState)

    local typographyDataState = _Value(Types.createTypographyData(
        Styles.Typography.get(Enums.TypographyStyle.BodyLarge)
    ))

    local heightState = _import(height, height)
    local textState = _import(text, text) :: State<string?>
    local textBoxState = _Value(Enums.TextBoxState.Empty :: Enums.TextBoxState) 
    local textBoxButtonState = _Value(Enums.ButtonState.Enabled :: Enums.ButtonState) 


    local textColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState)
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
            
        return if _buttonState == Enums.ButtonState.Enabled then onSurfaceVariant elseif _buttonState == Enums.ButtonState.Disabled then onSurface else onSurfaceVariant
    end, appearanceDataState, buttonState)
    
    local leadingIconInstance =  StandartButton.ColdFusion.new(maid, Icons.search.manage_search, _Value(false), function() end, isDarkState, 24)
    local trailingIconInstance =  StandartButton.ColdFusion.new(maid, Icons.navigation.close, _Value(false), function() end, isDarkState, 24)
    local base = _new("Frame")({
        AutomaticSize = Enum.AutomaticSize.X,
        Size = UDim2.fromOffset(280, 56),
        BackgroundColor3 = containerColorState,
        Children = {
            _new("UIPadding")({
                PaddingTop = UDim.new(0, 16),
                PaddingBottom = UDim.new(0, 16),
                PaddingLeft = UDim.new(0, 16),
                PaddingRight = UDim.new(0, 16) 
            }),
            _new("UIListLayout")({
                Padding = UDim.new(0, 16),
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Horizontal
            }),
            leadingIconInstance,
            _bind(TextBox.ColdFusion.new(maid, 2, text, textColorState, typographyDataState, 24, textBoxState, textBoxButtonState))({
                Size = UDim2.new(0,200,0,24),
                TextXAlignment = Enum.TextXAlignment.Left,
            }),
            _bind(trailingIconInstance)({LayoutOrder = 3})
        }
    })
    return base
end

return Interface