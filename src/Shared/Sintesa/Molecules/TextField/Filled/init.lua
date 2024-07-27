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
    layoutOrder : CanBeState<number>,
    isDark : CanBeState<boolean>,
    text : CanBeState<string?>,
    height : CanBeState<number>,

    leadingIconId : CanBeState<number | Types.IconData>,
    trailingIconId : CanBeState<number | Types.IconData>,

    width : number,

    leadingIconFn : () -> (),
    trailingIconFn : () -> (),

    inputText : ValueState<string>,

    isError : State<boolean>,
    errorText : CanBeState<string> ?)

    local _fuse = ColdFusion.fuse(maid)
    local _new = _fuse.new
    local _import = _fuse.import
    local _bind = _fuse.bind
    local _clone = _fuse.clone
    local _Computed = _fuse.Computed
    local _Value = _fuse.Value

    local isDarkState = _import(isDark, false)
    local buttonState = _Value(Enums.ButtonState.Enabled :: Enums.ButtonState) 
    local errorTextState = _import(errorText, "Incorrect input!")

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

    local containerColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local surfaceContainerHighest =  MaterialColor.Color3FromARGB(dynamicScheme:get_surfaceContainerHighest())
        local onSurface =  MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())

        return if _buttonState ~= Enums.ButtonState.Disabled then 
            surfaceContainerHighest
        else onSurface
    end, appearanceDataState, buttonState)
 
    local typographyDataState = _Value(Types.createTypographyData(
        Styles.Typography.get(Enums.TypographyStyle.BodyLarge)
    ))
    local textSupporterTypographyDataState = _Value(Types.createTypographyData(
        Styles.Typography.get(Enums.TypographyStyle.BodySmall)
    ))

    local heightState = _import(height, height)
    local textState = _import(text, text) :: State<string?>
    local textBoxState = _Value(Enums.TextBoxState.Empty :: Enums.TextBoxState) 

   
    local textColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState, _error : boolean)
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
        local errorColor = MaterialColor.Color3FromARGB(dynamicScheme:get_error())

        return if not _error then (if _buttonState == Enums.ButtonState.Enabled then onSurfaceVariant elseif _buttonState == Enums.ButtonState.Disabled then onSurface else onSurfaceVariant) else errorColor
    end, appearanceDataState, buttonState, isError)
    
    local supportingText2ColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState, _error : boolean)
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
        local errorColor = MaterialColor.Color3FromARGB(dynamicScheme:get_error())
        return if not _error then (if _buttonState == Enums.ButtonState.Enabled then onSurfaceVariant elseif _buttonState == Enums.ButtonState.Disabled then onSurface else onSurfaceVariant) else errorColor
    end, appearanceDataState, buttonState, isError) 


    local activeIndicatorState  = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState, _error : boolean)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        ) 
        local onSurfaceVariant = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurfaceVariant())
        local primary = MaterialColor.Color3FromARGB(dynamicScheme:get_primary())
        local errorColor = MaterialColor.Color3FromARGB(dynamicScheme:get_error())
                                        
        return if not _error then (if _buttonState == Enums.ButtonState.Enabled then  onSurfaceVariant else primary) else errorColor
    end, appearanceDataState, buttonState, isError) 

    local leadingIconInstance =  StandartButton.ColdFusion.new(maid, leadingIconId, _Value(false), leadingIconFn, isDarkState, 24, nil, textColorState)
    local errorIconInstance = StandartButton.ColdFusion.new(maid, Icons.alert.error, _Value(false), trailingIconFn, isDarkState, 24, nil, supportingText2ColorState)
    local trailingIconInstance =  StandartButton.ColdFusion.new(maid, trailingIconId, _Value(false), trailingIconFn, isDarkState, 24, nil, textColorState)
    local base = _new("Frame")({
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1,
        Size = UDim2.fromOffset(180, 56),
        BackgroundColor3 = containerColorState,
        Children = {
            _new("Frame")({
                BackgroundTransparency = _Computed(function(_buttonState : Enums.ButtonState)
                    return if _buttonState ~= Enums.ButtonState.Disabled then 1 - 1 else 1 - 0.04 
                end, buttonState),
                BackgroundColor3 = containerColorState,
                Size = UDim2.new(1,0,1,0),
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
                    _bind(TextBox.ColdFusion.new(maid, 2, text, textColorState, typographyDataState, 24, textBoxState, buttonState, inputText))({
                        AutomaticSize = Enum.AutomaticSize.Y,
                        TextWrapped = true,
                        Size = UDim2.new(0,width,0,24),
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Children = {
                            _bind(TextLabel.ColdFusion.new(maid, layoutOrder, text, activeIndicatorState, textSupporterTypographyDataState, 10))({
                                Position = UDim2.new(0,0,0,-12),
                                TextXAlignment = Enum.TextXAlignment.Left,
                                Visible = _Computed(function(tbState : Enums.TextBoxState)
                                    return tbState == Enums.TextBoxState.Populated
                                end, textBoxState),
                                TextTransparency = _Computed(function(_buttonState : Enums.ButtonState)
                                    return if _buttonState ~= Enums.ButtonState.Disabled then 1 - 1 else 1 - 0.38
                                end, buttonState)
                            })
                        }
                    }),
                    _bind(errorIconInstance)({
                        LayoutOrder = 3,
                        Visible = isError
                    }),
                    _bind(trailingIconInstance)({LayoutOrder = 4})
                }
            }),
            
            _new("Frame")({
                Name = "ActiveIndicatorFrame",
                BackgroundColor3 = activeIndicatorState:Tween(),
                Size = _Computed(function(_buttonState : Enums.ButtonState) 
                    return if _buttonState == Enums.ButtonState.Enabled then UDim2.new(1,0,0,1) 
                        elseif _buttonState == Enums.ButtonState.Focused then UDim2.new(1,0,0,2) 
                        elseif _buttonState == Enums.ButtonState.Disabled then UDim2.new(1,0,0,0) 
                    else UDim2.new(1,0,0,1)
                end, buttonState):Tween(), 
                Position = UDim2.new(0,0,1,0)
            }),

            _bind(TextLabel.ColdFusion.new(maid, 4, errorTextState, supportingText2ColorState, textSupporterTypographyDataState, 45))({
                Size = UDim2.new(0,width,0,30),
                Position = UDim2.new(0,45,1,0), 
                TextXAlignment = Enum.TextXAlignment.Left,
                Visible = isError
            }),
            -- _new("TextLabel")({
            --     Name = "SupportingText2",
            --     BackgroundTransparency = 1,
            --     Size = UDim2.new(0,width,0,45),
            --     Position = UDim2.new(0,0,1,0),
            --     Text = "Testos"
            -- })
        }
    })
    return base
end

return Interface