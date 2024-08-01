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

local Styles = require(script.Parent.Parent.Parent:WaitForChild("Styles"))
local Enums = require(script.Parent.Parent.Parent:WaitForChild("Enums"))

local DynamicTheme = require(script.Parent.Parent:WaitForChild("dynamic_theme"))

local TextLabel = require(script.Parent.Parent:WaitForChild("Util"):WaitForChild("TextLabel"))
local StandardIconButton = require(script.Parent.Parent:WaitForChild("Buttons"):WaitForChild("IconButton"):WaitForChild("Standard"))
local FABButton = require(script.Parent.Parent:WaitForChild("Buttons"):WaitForChild("FAB"))

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
    leadingButtons : CanBeState<{[number] : ButtonData}>,
    trailingButton : CanBeState<ButtonData>,

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

    local leadingIconsState = _import(leadingButtons, leadingButtons)
    local trailingIconState = _import(trailingButton, trailingButton)


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
            112,

            dark
        )
    end, isDarkState)

    local labelLarge = Styles.Typography.get(Enums.TypographyStyle.HeadlineSmall)
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

    local function getTrailingIcon()
        local trailingIcon = _Computed(function(button : ButtonData)
            local leadingIconId = button.Id or 15567843390
            --local selected = _import(button.Selected, false)
            
            return _bind(FABButton.ColdFusion.new(
                maid, 
                leadingIconId, 
                function()
                    onButtonClicked(button)
                end,
                isDarkState,
                48
            ))({
                LayoutOrder = 3
            })
        end, trailingIconState)
        return trailingIcon
    end

    local function getLeadingIcon(buttonData : ButtonData, fuse : Fuse ?)
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
                32
            ))({
                LayoutOrder = 1
            })
        return button

    end

    local leadingIcons = _Value({})  


    local trailingIcon  = getTrailingIcon()

    local Children : {CanBeState<Instance> | {CanBeState<Instance>}} = {
        -- _new("Frame")({
        --     Name = "LeadingIconAndTitle",
        --     BackgroundTransparency = 1,
        --     Size = UDim2.fromScale(0.8, 1),
        --     Children = {
        --         _new("UIListLayout")({
        --             VerticalAlignment = Enum.VerticalAlignment.Center
        --         }),
        --         trailingIcon :: any,
        --     }
        -- }),
        _new("UIListLayout")({
            Padding = PADDING_SIZE,
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }) :: any,
      
        _new("Frame")({
            LayoutOrder = 0,
            -- BackgroundColor3 = Color3.fromRGB(255,0,0),
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(0.85, 1),
            Children = {
                _new("UIListLayout")({
                    Padding = PADDING_SIZE,
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Left,
                    VerticalAlignment = Enum.VerticalAlignment.Center
                }) :: any,
                leadingIcons
            }
        }),

        trailingIcon,
        
    }

    --_new("ObjectValue")({
--[[ Value =]] 
        _Computed(function(buttons : {ButtonData})
            leadingIcons:Set({})
            return buttons
        end, leadingIconsState):ForValues(function(buttonData : ButtonData, _maid: Maid)  
            _fuse = ColdFusion.fuse(_maid)
            _import = _fuse.import 

            _Computed = _fuse.Computed

            local sc = leadingIcons:Get()
            --local trailingIconId = buttonData.Id or 13805569043
            --local selected = _import(buttonData.Selected, false)
            
            local button = getLeadingIcon(buttonData, _fuse)

            table.insert(sc, button)

            leadingIcons:Set(sc)
            return buttonData
        end)
    --}) 


    local out = Base.ColdFusion.new(
        maid, 
        containerColorState, 
        appearanceDataState,
        Children
    )
    out.Size = UDim2.new(1,0,0, 72)
    out.AnchorPoint = Vector2.new(0,1)
    out.Position = UDim2.new(0,0,1,0)
    return out :: Frame
end

return TopAppBar