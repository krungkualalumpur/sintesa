--!strict
local _Packages = game:GetService("ReplicatedStorage"):WaitForChild("Packages")
--services 
--packages
local Maid = require(_Packages:WaitForChild("Maid"))
local ColdFusion = require(_Packages:WaitForChild("ColdFusion8"))
--modules
local Base = require(script.Parent:WaitForChild("Base"))

local MaterialColor = require(
    script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("MaterialColor")
) 
local Types = require(script.Parent.Parent.Parent:WaitForChild("Types"))
local Icons = require(script.Parent.Parent.Parent:WaitForChild("Icons"))

local Styles = require(script.Parent.Parent.Parent:WaitForChild("Styles"))
local Enums = require(script.Parent.Parent.Parent:WaitForChild("Enums"))

local DynamicTheme = require(script.Parent.Parent:WaitForChild("dynamic_theme"))

local ImageLabel = require(script.Parent.Parent:WaitForChild("Util"):WaitForChild("ImageLabel"))
local TextLabel = require(script.Parent.Parent:WaitForChild("Util"):WaitForChild("TextLabel"))
local StandardIconButton = require(script.Parent.Parent:WaitForChild("Buttons"):WaitForChild("IconButton"):WaitForChild("Standard"))

local ButtonBase = require(script.Parent.Parent:WaitForChild("Buttons"):WaitForChild("Base"))
local ShapeStyle = require(script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("Shape"))

local Divider = require(script.Parent.Parent:WaitForChild("Divider")) 
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

export type IconRef = "Leading" | "Trailing"
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
    title : CanBeState<string>,
    navigationButtons : CanBeState<{
        [number] : ButtonData,
    }>,

    onButtonClicked : (ButtonData) -> (),
    hasMenuButton : boolean?,
    onMenuClicked : (MenuData : ButtonData) -> ())
    
    local _fuse = ColdFusion.fuse(maid)
    local _new = _fuse.new
    local _import = _fuse.import
    local _bind = _fuse.bind
    local _clone = _fuse.clone
    local _Computed = _fuse.Computed
    local _Value = _fuse.Value
    
    local isDarkState = _import(isDark, false)

    local navigationButtonsState = _import(navigationButtons, navigationButtons)

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

    local labelLarge = Styles.Typography.get(Enums.TypographyStyle.LabelLarge)
    local typographyDataState = _Value(Types.createTypographyData(
        labelLarge
    ))

 
    local containerColorState = _Computed(function(appearance : AppearanceData)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local surface = MaterialColor.Color3FromARGB(dynamicScheme:get_surface())
        local surfaceContainer = MaterialColor.Color3FromARGB(dynamicScheme:get_surfaceContainer())

        return surfaceContainer
    end, appearanceDataState)

    local headlineColorState  = _Computed(function(appearance : AppearanceData)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        ) 
        local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())
        return onSurface
    end, appearanceDataState) 

    local textColorState  = _Computed(function(appearance : AppearanceData)
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
   --[[ local trailingIcon = StandardIconButton.ColdFusion.new(
        maid, 
        trailingIconId, 
        _Computed(function(iconRef : IconRef?)
            return iconRef == "Trailing" 
        end, iconSelected),
        onTrailingIconClicked,
        isDarkState,
        24
    )]]

    local Children = _Computed(function(buttons : {
        [number] : ButtonData
    })
        local menuButton = if hasMenuButton then Types.createButtonData("", Icons.navigation.menu, nil, nil) else nil

        if menuButton then 
            table.insert(buttons, 1, menuButton)
        end
        return buttons
    end, navigationButtonsState):ForPairs(function(k : number, data : ButtonData,  pairMaid : Maid)
        -- local out = _new("Frame")({
        --     BackgroundTransparency = 1,
        --     Size = UDim2.fromOffset(48, 48),
        --     Children = {
        --         _new("UIListLayout")({
        --             SortOrder = Enum.SortOrder.LayoutOrder,
        --             HorizontalAlignment = Enum.HorizontalAlignment.Center 
        --         }),
        --         StandardIconButton.ColdFusion.new(
        --             pairMaid, 
        --             data.Id :: any,
        --             data.Selected :: any,
        --               function()
        --                 onButtonClicked(data)
        --             end,
        --             isDarkState,
        --             nil,
        --             data.Badge
        --         ),
        --         TextLabel.ColdFusion.new(maid, 2, data.Name, textColorState, typographyDataState, 1)
        --     }
        -- })
       
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
                Enums.ShapeStyle.Full,
                64,

                dark
            )
        end, isDarkState)

        local textColorState  = _Computed(function(appearance : AppearanceData, selected : boolean, _buttonState : Enums.ButtonState)
            local dynamicScheme = MaterialColor.getDynamicScheme(
                appearance.PrimaryColor, 
                appearance.SecondaryColor, 
                appearance.TertiaryColor, 
                appearance.NeutralColor, 
                appearance.NeutralVariantColor,
                appearance.IsDark
            ) 
            local onSecondaryContainer = MaterialColor.Color3FromARGB(dynamicScheme:get_onSecondaryContainer())
            local onSurfaceVariant = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurfaceVariant())
            local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())

            return  if selected then (
                if _buttonState == Enums.ButtonState.Enabled then
                    onSecondaryContainer
                    elseif _buttonState == Enums.ButtonState.Hovered then
                        onSecondaryContainer
                    elseif _buttonState == Enums.ButtonState.Focused then
                        onSecondaryContainer
                    elseif _buttonState == Enums.ButtonState.Pressed then
                        onSecondaryContainer
                else onSecondaryContainer

            ) else (
                if _buttonState == Enums.ButtonState.Enabled then
                    onSurfaceVariant
                    elseif _buttonState == Enums.ButtonState.Hovered then
                        onSurface
                    elseif _buttonState == Enums.ButtonState.Focused then
                        onSurface
                    elseif _buttonState == Enums.ButtonState.Pressed then
                        onSecondaryContainer
                else onSecondaryContainer
            )
        end, appearanceDataState, data.Selected, buttonState) 

        local stateLayerColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState, selected : boolean)
            local dynamicScheme = MaterialColor.getDynamicScheme(
                appearance.PrimaryColor, 
                appearance.SecondaryColor, 
                appearance.TertiaryColor, 
                appearance.NeutralColor, 
                appearance.NeutralVariantColor,
                appearance.IsDark
            )
            local inverseOnSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_inverseOnSurface())
            local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())
            local onSurfaceVariant = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurfaceVariant())
    
            return if selected then (if _buttonState == Enums.ButtonState.Hovered then inverseOnSurface 
                elseif _buttonState == Enums.ButtonState.Focused then inverseOnSurface 
                elseif _buttonState == Enums.ButtonState.Pressed then inverseOnSurface
            else inverseOnSurface) else (if _buttonState == Enums.ButtonState.Hovered then inverseOnSurface 
                elseif _buttonState == Enums.ButtonState.Focused then onSurfaceVariant 
                elseif _buttonState == Enums.ButtonState.Pressed then onSurface 
            else onSurfaceVariant) 
        end, appearanceDataState, buttonState, data.Selected)

        local activeIndicatorColorState  = _Computed(function(appearance : AppearanceData, selected : boolean)
            local dynamicScheme = MaterialColor.getDynamicScheme(
                appearance.PrimaryColor, 
                appearance.SecondaryColor, 
                appearance.TertiaryColor, 
                appearance.NeutralColor, 
                appearance.NeutralVariantColor,
                appearance.IsDark
            ) 
            local secondaryContainer = MaterialColor.Color3FromARGB(dynamicScheme:get_secondaryContainer())
            return secondaryContainer
        end, appearanceDataState, data.Selected) 

        -- local out = _bind(ButtonBase.ColdFusion.new(
        --     maid, 
        --     activeIndicatorColorState, 
        --     stateLayerColorState, 
        --     appearanceDataState, 
        --     typographyDataState, 
        --     buttonState, 
        --     false, 
        --     function()
        --         onButtonClicked(data :: ButtonData)
        --     end
        -- ))({
        --     BackgroundTransparency = _Computed(function(selected : boolean)
        --         return if selected then 0 else 1
        --     end, data.Selected):Tween(),
        --     BackgroundColor3 = activeIndicatorColorState,
        --     Children = {
        --         _new("UIPadding")({
        --             PaddingLeft = UDim.new(0, 16),
        --             PaddingRight = UDim.new(0, 16)
        --         }),
        --         _new("UIListLayout")({
        --             Padding = UDim.new(0, 12),
        --             SortOrder = Enum.SortOrder.LayoutOrder,
        --             FillDirection = Enum.FillDirection.Horizontal,
        --             VerticalAlignment = Enum.VerticalAlignment.Center
        --         }),
        --         _bind(ImageLabel.ColdFusion.new(maid, 1, data.Id, textColorState))({
        --             Size = UDim2.fromOffset(24, 24)
        --         }),
        --         _bind(TextLabel.ColdFusion.new(maid, 2, data.Name, textColorState, typographyDataState, 0) :: any)({
        --             TextXAlignment = Enum.TextXAlignment.Left
        --         })
        --     }
        -- }) :: GuiButton
        local activeIndicatorState  = _Computed(function(appearance : AppearanceData, selected : boolean)
            local dynamicScheme = MaterialColor.getDynamicScheme(
                appearance.PrimaryColor, 
                appearance.SecondaryColor, 
                appearance.TertiaryColor, 
                appearance.NeutralColor, 
                appearance.NeutralVariantColor,
                appearance.IsDark
            ) 
            local secondaryContainer = MaterialColor.Color3FromARGB(dynamicScheme:get_secondaryContainer())
    
            return secondaryContainer
        end, appearanceDataState, data.Selected) 

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
            LayoutOrder = k,
            BackgroundTransparency = _Computed(function(selected : boolean)
                return if selected then 0 else 1
            end, data.Selected):Tween(),
            BackgroundColor3 = activeIndicatorState,
            Size = UDim2.fromOffset(56, 32),
            Children = {
                getUiCorner(),
                _new("UIListLayout")({
                    Padding = UDim.new(0,4),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center 
                }),
                StandardIconButton.ColdFusion.new(
                    pairMaid, 
                    data.Id :: any,
                    data.Selected :: any,
                      function()
                        local function isMenu()
                            return data.Name == "" and data.Id == Icons.navigation.menu 
                        end
                        if not isMenu() then
                            onButtonClicked(data)
                        elseif onMenuClicked then
                            onMenuClicked(data)
                        end
                    end,
                    isDarkState,
                    32,
                    data.Badge
                ),
                TextLabel.ColdFusion.new(maid, 2, data.Name, textColorState, typographyDataState, 4)
            }
        })
        return k, out
        -- out.BackgroundColor3 = Color3.fromRGB(255,0,0)
        --out.BackgroundTransparency = 0
    
    end)

    local out = Base.ColdFusion.new(
        maid, 
        containerColorState, 
        appearanceDataState,
        Children,
        Enum.FillDirection.Vertical,
        nil,
        Enum.VerticalAlignment.Top,
        12,
        10+24
    )
    out.AnchorPoint = Vector2.new(-1,0)
    out.Position = UDim2.new(0,10,0,0)
    out.Size = UDim2.new(0,80,1,0)

    return out :: Frame
end

return Interface