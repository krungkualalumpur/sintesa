--!strict
local _Packages = game:GetService("ReplicatedStorage"):WaitForChild("Packages")
--services 
--packages
local Maid = require(_Packages:WaitForChild("Maid"))
local ColdFusion = require(_Packages:WaitForChild("ColdFusion8"))
--modules
local MaterialColor = require(
    script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("MaterialColor")
) 
local Types = require(script.Parent.Parent.Parent:WaitForChild("Types"))
local Icons = require(script.Parent.Parent.Parent:WaitForChild("Icons"))

local Styles = require(script.Parent.Parent.Parent:WaitForChild("Styles"))
local Enums = require(script.Parent.Parent.Parent:WaitForChild("Enums"))

local DynamicTheme = require(script.Parent.Parent:WaitForChild("dynamic_theme"))

local Divider = require(script.Parent.Parent:WaitForChild("Divider"))

local TextLabel = require(script.Parent.Parent:WaitForChild("Util"):WaitForChild("TextLabel"))
local ImageLabel = require(script.Parent.Parent:WaitForChild("Util"):WaitForChild("ImageLabel"))
local TextButton = require(script.Parent.Parent:WaitForChild("Buttons"):WaitForChild("CommonButton"):WaitForChild("Text"))
local StandardIconButton = require(script.Parent.Parent:WaitForChild("Buttons"):WaitForChild("IconButton"):WaitForChild("Standard"))
local InterfaceBase =  require(script.Parent.Parent:WaitForChild("Dialogs"):WaitForChild("Base"))

local ShapeStyle = require(script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("Shape"))
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
type IconData = Types.IconData
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

    headlineText : CanBeState<string>,
    supportingText : CanBeState<string?>,

    footerButtons : {ButtonData},
    onFooterButtonClick : (buttonData : ButtonData) -> (),
    
    iconButton : ButtonData?,
    onIconButtonClick : () -> (),

    content : Frame?)
    
    local width = 250

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
            dark : boolean,
            _buttonState : Enums.ButtonState) 
           
        return Types.createAppearanceData(
            DynamicTheme.Color[Enums.ColorRole.Primary],
            DynamicTheme.Color[Enums.ColorRole.Secondary],
            DynamicTheme.Color[Enums.ColorRole.Tertiary],

            DynamicTheme.Color[Enums.ColorRole.Surface],
            DynamicTheme.Color[Enums.ColorRole.SurfaceDim],
            DynamicTheme.Color[Enums.ColorRole.Shadow],
            
            if _buttonState == Enums.ButtonState.Enabled then Enums.ElevationResting.Level1 
                elseif _buttonState == Enums.ButtonState.Disabled then Enums.ElevationResting.Level0
                elseif _buttonState == Enums.ButtonState.Hovered then Enums.ElevationResting.Level2
                elseif _buttonState == Enums.ButtonState.Focused then Enums.ElevationResting.Level1
                elseif _buttonState == Enums.ButtonState.Pressed then Enums.ElevationResting.Level1
                elseif _buttonState == Enums.ButtonState.Dragged then Enums.ElevationResting.Level4
            else Enums.ElevationResting.Level1,

            Enums.ShapeSymmetry.Full,
            Enums.ShapeStyle.ExtraLarge,
            32,

            dark
        )
    end, isDarkState, buttonState)

    
    local outlineColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local outline = MaterialColor.Color3FromARGB(dynamicScheme:get_outline())
        local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())
        local onSurfaceVariant = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurfaceVariant())
            
        return outline
    end, appearanceDataState, buttonState)

    local headlineTextColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local primary = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())
        local onSecondaryContainer = MaterialColor.Color3FromARGB(dynamicScheme:get_onSecondaryContainer())
        local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())
            
        return primary
    end, appearanceDataState, buttonState)

    local supportingTextColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local onSurfaceVariant = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurfaceVariant())
        local onSecondaryContainer = MaterialColor.Color3FromARGB(dynamicScheme:get_onSecondaryContainer())
        local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())
            
        return onSurfaceVariant
    end, appearanceDataState, buttonState)

    local containerColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        --local surfaceContainerLow = MaterialColor.Color3FromARGB(dynamicScheme:get_surfaceContainerLow())
        local secondaryContainer = MaterialColor.Color3FromARGB(dynamicScheme:get_surfaceContainerHigh())

        local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())

        return secondaryContainer
    end, appearanceDataState, buttonState)

    local stateLayerColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local onSurfaceVariant = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurfaceVariant())

        local onSecondaryContainer = MaterialColor.Color3FromARGB(dynamicScheme:get_onSecondaryContainer())

        local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())
            
        return  onSurfaceVariant
      
    end, appearanceDataState, buttonState)

    local headlineTypographyState = _Value(Types.createTypographyData(Styles.Typography.get(Enums.TypographyStyle.HeadlineSmall))) 
    local supportingTypographyState = _Value(Types.createTypographyData(Styles.Typography.get(Enums.TypographyStyle.BodyMedium))) 

    local leadingIconColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local primary = MaterialColor.Color3FromARGB(dynamicScheme:get_primary())
        local onSecondaryContainer = MaterialColor.Color3FromARGB(dynamicScheme:get_onSecondaryContainer())
        local onSurfaceVariant = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurfaceVariant())

        local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())
            
        return 
            (if _buttonState == Enums.ButtonState.Enabled then primary
                elseif _buttonState == Enums.ButtonState.Disabled then onSurface 
                elseif _buttonState == Enums.ButtonState.Hovered then primary
                elseif _buttonState == Enums.ButtonState.Focused then primary
                elseif _buttonState == Enums.ButtonState.Pressed then primary
                elseif _buttonState == Enums.ButtonState.Dragged then onSecondaryContainer
            else primary) 
    end, appearanceDataState, buttonState)

    local trailingIconColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local primary = MaterialColor.Color3FromARGB(dynamicScheme:get_primary())
        local onSecondaryContainer = MaterialColor.Color3FromARGB(dynamicScheme:get_onSecondaryContainer())
        local onSurfaceVariant = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurfaceVariant())

        local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())
            
        return 
            (if _buttonState == Enums.ButtonState.Enabled then onSecondaryContainer
                elseif _buttonState == Enums.ButtonState.Disabled then onSurface 
                elseif _buttonState == Enums.ButtonState.Hovered then onSecondaryContainer
                elseif _buttonState == Enums.ButtonState.Focused then onSecondaryContainer
                elseif _buttonState == Enums.ButtonState.Pressed then onSecondaryContainer
                elseif _buttonState == Enums.ButtonState.Dragged then primary
            else onSecondaryContainer) 
            
    end, appearanceDataState, buttonState)
    
    local opacityState = _Computed(function(_buttonState : Enums.ButtonState)
        return
            (if _buttonState == Enums.ButtonState.Pressed then 
                0.1
            elseif _buttonState == Enums.ButtonState.Focused then 
                0.1
            elseif _buttonState == Enums.ButtonState.Hovered then
                0.08
            elseif _buttonState == Enums.ButtonState.Dragged then
                0.16
        else 0)
    end, buttonState)
    
    local iconButtonInstance: TextButton? = if iconButton then StandardIconButton.ColdFusion.new(maid, iconButton.Id or 0, _Value(false), onIconButtonClick, isDarkState, 24) else nil

    local headlineTextInstance =  TextLabel.ColdFusion.new(
        maid, 
        1, 
        headlineText, 
        headlineTextColorState, 
        headlineTypographyState, 
        25
    )
    local supportingTextInstance =  _bind(TextLabel.ColdFusion.new(
        maid, 
        2, 
        supportingText, 
        headlineTextColorState, 
        supportingTypographyState, 
        25
    ))({
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(0,width,0,0),
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local contentFrame = if content then _new("Frame")({
        LayoutOrder = 4,
        BackgroundTransparency = 1,
        Size = UDim2.new(0,width,0,170),
        Children = {
            _bind(content)({Size = UDim2.new(1,0,1,0)})
        }
    }) else nil

    local footer = _new("Frame")({
        LayoutOrder = 6,
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(0, width, 0, 0),
        Children = {
            _new("UIListLayout")({
                Padding = UDim.new(0,8),
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Right
            }),
        }
    })

    for _, buttonData in pairs(footerButtons) do
        TextButton.ColdFusion.new(maid, buttonData.Name or "", function()
            onFooterButtonClick(buttonData)
        end, isDarkState).Parent = footer
    end

    local base = _new("Frame")({
        AnchorPoint = Vector2.one*0.5,
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundColor3 = containerColorState,
        Size = UDim2.new(0,0,0,100),
        Children = {
            _new("UICorner")({
                CornerRadius = _Computed(function(appearance : AppearanceData) 
                    return UDim.new(
                        0,  
                        ShapeStyle.get(appearance.Style)
                    )
                end, appearanceDataState),
            }),
            _new("UIPadding")({
                PaddingTop = UDim.new(0,24),
                PaddingBottom = UDim.new(0,24),
                PaddingLeft = UDim.new(0,24),
                PaddingRight = UDim.new(0,24),

            }),
            _new("UIListLayout")({
                Padding = UDim.new(0,16),
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Center
            }),
            _bind(iconButtonInstance :: any)({LayoutOrder = 0}),
            headlineTextInstance,
            supportingTextInstance,
            if contentFrame then
                {
                    _bind(Divider.ColdFusion.new(maid, isDark, false)){
                        LayoutOrder = 3,
                        Size = UDim2.new(0,width,0,1),
                        AnchorPoint = Vector2.new(0.5,0.5),
                    },
                    contentFrame,
                    _bind(Divider.ColdFusion.new(maid, isDark, false)){
                        LayoutOrder = 5,
                        Size = UDim2.new(0,width,0,1),
                        AnchorPoint = Vector2.new(0.5,0.5), 
                    }
                } :: any
            else nil,

            footer
        }
    }) :: Frame

    return base
end
return interface