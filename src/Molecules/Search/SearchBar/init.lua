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

local TextLabel = require(script.Parent.Parent:WaitForChild("Util"):WaitForChild("TextLabel"))
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
    isDark : CanBeState<boolean>,
    leadingIconId : CanBeState<Types.IconData | number>,
    text : CanBeState<string>,
    width : CanBeState<number>,
    inputText : ValueState<string>,
    
    leadingIconFn : () -> (),

    trailingIconId : CanBeState<Types.IconData | number> ?,
    TrailingIconFn : (() -> ())?)
    
    local _fuse = ColdFusion.fuse(maid)
    local _new = _fuse.new
    local _import = _fuse.import
    local _bind = _fuse.bind
    local _clone = _fuse.clone
    local _Computed = _fuse.Computed
    local _Value = _fuse.Value

    local isDarkState = _import(isDark, false)

    local textBoxState = _Value(Enums.TextBoxState.Empty :: Enums.TextBoxState)
    local textBoxButtonState = _Value(Enums.ButtonState.Enabled :: Enums.ButtonState)

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
        local surfaceContainerHigh = MaterialColor.Color3FromARGB(dynamicScheme:get_surfaceContainerHigh())
            
        return  surfaceContainerHigh
    end, appearanceDataState)

    local textColorState = _Computed(function(appearance : AppearanceData, tbState : Enums.TextBoxState)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())
        local onSurfaceVariant = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurfaceVariant())

        return if tbState == Enums.TextBoxState.Empty then onSurfaceVariant else onSurface
    end, appearanceDataState, textBoxState)

    local typographyDataState = _Value(Types.createTypographyData(
        Styles.Typography.get(Enums.TypographyStyle.BodyLarge)
    ))

    local widthState = _import(width, width)

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
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = containerColorState,
        Size =_Computed(function(width : number) 
            return UDim2.new(0,width,0,56)
        end, widthState) ,
        Children = {
            getUiCorner(),
            _new("UIPadding")({
                PaddingTop = UDim.new(0, 16),
                PaddingBottom = UDim.new(0, 16),
                PaddingLeft = UDim.new(0, 16),
                PaddingRight = UDim.new(0, 16),
            }),
            _new("UIListLayout"){
                Padding = UDim.new(0, 16),
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Center
            },
            StandartButton.ColdFusion.new(maid, leadingIconId, _Value(false), leadingIconFn, isDarkState, 24),
            _bind(TextBox.ColdFusion.new(maid, 2, text, textColorState, typographyDataState, 16, textBoxState, textBoxButtonState, inputText))({
                AutomaticSize = Enum.AutomaticSize.Y,
                Size = _Computed(function(width : number) 
                    return UDim2.new(0,width - 112,0,0)
                end, widthState),
                TextWrapped = true
            }),
            if trailingIconId then
                _bind(StandartButton.ColdFusion.new(maid, trailingIconId, _Value(false), TrailingIconFn or function() end, isDarkState, 24))({
                    LayoutOrder = 3,
                })
            else nil :: any,
            
        }
    }) :: Frame
    
    return out
end

return Interface