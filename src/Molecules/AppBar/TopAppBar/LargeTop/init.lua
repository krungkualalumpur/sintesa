--!strict
local _Packages = game:GetService("ReplicatedStorage"):WaitForChild("Packages")
--services 
--packages
local Maid = require(_Packages:WaitForChild("Maid"))
local ColdFusion = require(_Packages:WaitForChild("ColdFusion8"))
--modules
local Base = require(script.Parent.Parent:WaitForChild("Base"))

local MaterialColor = require(
    script.Parent.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("MaterialColor")
) 
local Types = require(script.Parent.Parent.Parent.Parent:WaitForChild("Types"))

local Styles = require(script.Parent.Parent.Parent.Parent:WaitForChild("Styles"))
local Enums = require(script.Parent.Parent.Parent.Parent:WaitForChild("Enums"))

local DynamicTheme = require(script.Parent.Parent.Parent:WaitForChild("dynamic_theme"))

local TextLabel = require(script.Parent.Parent.Parent:WaitForChild("Util"):WaitForChild("TextLabel"))
local StandardIconButton = require(script.Parent.Parent.Parent:WaitForChild("Buttons"):WaitForChild("IconButton"):WaitForChild("Standard"))

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
local PADDING_SIZE = UDim.new(0, 24)
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
    leadingButton : CanBeState<ButtonData>,
    trailingButtons : CanBeState<{[number] : ButtonData}>,

    onScroll : State<boolean>,

    onButtonClicked : (ButtonData) -> ())
    
    local _fuse = ColdFusion.fuse(maid)
    local _new = _fuse.new
    local _import = _fuse.import
    local _bind = _fuse.bind
    local _clone = _fuse.clone
    local _Computed = _fuse.Computed
    local _Value = _fuse.Value
    
    local isDarkState = _import(isDark, false)

    local leadingIconState = _import(leadingButton, leadingButton)
    local trailingIconsState = _import(trailingButtons, trailingButtons)


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
            152,

            dark
        )
    end, isDarkState)

    local labelLarge = Styles.Typography.get(Enums.TypographyStyle.HeadlineMedium)
    local typographyDataState = _Value(Types.createTypographyData(
        labelLarge
    ))
 
    local containerColorState = _Computed(function(appearance : AppearanceData, scroll : boolean)
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

        return if scroll then surfaceContainer else surface
    end, appearanceDataState, onScroll)

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

    local function getLeadingIcon()
        local leadingIcon = _Computed(function(button : ButtonData)
            local leadingIconId = button.Id or 15567843390
            local selected = _import(button.Selected, false)
            
            return _bind(StandardIconButton.ColdFusion.new(
                maid, 
                leadingIconId, 
                selected,
                function()
                    onButtonClicked(button)
                end,
                isDarkState,
                24
            ))({
                LayoutOrder = 1
            })
        end, leadingIconState)
        return leadingIcon
    end

    local function getTrailingIcon(buttonData : ButtonData, fuse : Fuse ?)
        local _import = if fuse then fuse.import else _import
        local trailingIconId = buttonData.Id or 13805569043
        local selected = _import(buttonData.Selected, false)
            
        local button = _bind(StandardIconButton.ColdFusion.new(
                maid, 
                trailingIconId, 
                selected,
                function()
                    onButtonClicked(buttonData)
                end,
                isDarkState,
                24
            ))({
                LayoutOrder = 3
            })
        return button

    end

    local leadingIcon = getLeadingIcon()


    local trailingIcons  = _Value({}) 

    local Children : {CanBeState<Instance> | {CanBeState<Instance>}} = {
        _new("Frame")({
            Name = "LeadingIconAndTitle",
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(0.8, 1),
            Children = {
                _new("UIListLayout")({
                    VerticalAlignment = Enum.VerticalAlignment.Center
                }),
                leadingIcon :: any,
                _bind(TextLabel.ColdFusion.new(
                    maid, 
                    2, 
                    title, 
                    headlineColorState, 
                    typographyDataState, 
                    _Computed(function(appearence : AppearanceData)
                        return appearence.Height
                    end, appearanceDataState)
                ))({
                    AutomaticSize = Enum.AutomaticSize.None,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Size = UDim2.fromScale(0.75, 0.8)
                }),
            }
        }),
       
      
        _new("Frame")({
            LayoutOrder = 2,
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(0.1, 1),
            Children = {
                _new("UIListLayout")({
                    Padding = PADDING_SIZE,
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Right,
                    VerticalAlignment = Enum.VerticalAlignment.Top
                }) :: any,
                trailingIcons
            }
        })
        
    }

    --_new("ObjectValue")({
--[[ Value =]] 
        _Computed(function(buttons : {ButtonData})
            trailingIcons:Set({})
            return buttons
        end, trailingIconsState):ForValues(function(buttonData : ButtonData, _maid: Maid)  
            _fuse = ColdFusion.fuse(_maid)
            _import = _fuse.import 

            _Computed = _fuse.Computed

            local sc = trailingIcons:Get()
            --local trailingIconId = buttonData.Id or 13805569043
            --local selected = _import(buttonData.Selected, false)
            
            local button = getTrailingIcon(buttonData, _fuse)

            table.insert(sc, button)

            trailingIcons:Set(sc)
            return buttonData
        end)
    --}) 


    local out = Base.ColdFusion.new(
        maid, 
        containerColorState, 
        appearanceDataState,
        Children
    )
    return out :: Frame
end

return TopAppBar