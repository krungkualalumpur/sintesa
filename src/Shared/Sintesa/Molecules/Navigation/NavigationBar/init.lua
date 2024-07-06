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
local ShapeStyle = require(script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("Shape"))

local TextLabel = require(script.Parent.Parent:WaitForChild("Util"):WaitForChild("TextLabel"))
local StandardIconButton = require(script.Parent.Parent:WaitForChild("Buttons"):WaitForChild("IconButton"):WaitForChild("Standard"))
local SmallBadge = require(script.Parent.Parent:WaitForChild("Badges"):WaitForChild("Small"))
local LargeBadge = require(script.Parent.Parent:WaitForChild("Badges"):WaitForChild("Large"))
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
local TopAppBar = {}

TopAppBar.ColdFusion = {}

function TopAppBar.ColdFusion.new(
    maid : Maid,

    isDark : CanBeState<boolean>,
    title : CanBeState<string>,
    navigationButtons : CanBeState<{ButtonData}>,

    onButtonClicked : (ButtonData) -> ())
    
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

    local labelLarge = Styles.Typography.get(Enums.TypographyStyle.LabelMedium)
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

    local Children = _Computed(function(buttons : {ButtonData})
        return buttons
    end, navigationButtonsState):ForValues(function(data : ButtonData,  pairMaid : Maid)
        
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

        local iconColorState = _Computed(function(appearance : AppearanceData, selected : boolean)
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
    
            return if selected then onSurface else onSurfaceVariant
        end, appearanceDataState, data.Selected) 

        local textColorState  = _Computed(function(appearance : AppearanceData, selected : boolean)
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
    
            return if selected then onSurface else onSurfaceVariant
        end, appearanceDataState, data.Selected) 

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
            BackgroundTransparency = _Computed(function(selected : boolean)
                return if selected then 0 else 1
            end, data.Selected):Tween(),
            BackgroundColor3 = activeIndicatorState,
            Size = UDim2.fromOffset(64, 32),
            Children = {
                getUiCorner(),
                _new("UIListLayout")({
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center 
                }),
                _bind(StandardIconButton.ColdFusion.new(
                    pairMaid, 
                    data.Id :: any,
                    data.Selected :: any,
                      function()
                        onButtonClicked(data)
                    end,
                    isDarkState,
                    32,
                    data.Badge,

                    iconColorState
                ))({
                    Size = UDim2.fromOffset(64, 32)
                }),
                TextLabel.ColdFusion.new(maid, 2, data.Name, textColorState, typographyDataState, 1)
            }
        })
        return out
    end)

    local out = Base.ColdFusion.new(
        maid, 
        containerColorState, 
        appearanceDataState,
        Children,
        Enum.FillDirection.Horizontal
    )
    out.Size = UDim2.new(1,0,0,80)
    return out :: Frame
end

return TopAppBar