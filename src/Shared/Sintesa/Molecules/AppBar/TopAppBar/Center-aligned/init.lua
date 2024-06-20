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
    onScroll : State<boolean>)
    
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
            64,

            dark
        )
    end, isDarkState)

    local labelLarge = Styles.Typography.get(Enums.TypographyStyle.TitleLarge)
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

    local leadingIconSelected = _Value(false)
    local onLeadingIconClicked = function()
        print("Fangchan nakrab")
    end

    local trailingIconSelected = _Value(false)
    local onOTrailingIconClicked = function()
        print("Anadee fangchan nakrab")
    end

    local leadingIcon = _bind(StandardIconButton.ColdFusion.new(
        maid,15567843390, 
        leadingIconSelected,
        onLeadingIconClicked
    ))({
        Size = UDim2.fromOffset(24, 24)
    }) :: Instance

    local trailingIcon = _bind(StandardIconButton.ColdFusion.new(
        maid,13805569043, 
        trailingIconSelected,
        onOTrailingIconClicked
    ))({
        Size = UDim2.fromOffset(24, 24) 
    }) :: Instance

    local Children = {
        _bind(leadingIcon){
            LayoutOrder = 1,
        },
        _bind(TextLabel.ColdFusion.new(
            maid, 
            2, 
            "chiwit khong phom thi thai pen mei dii na chab", 
            headlineColorState, 
            typographyDataState, 
            _Computed(function(appearence : AppearanceData)
                return appearence.Height
            end, appearanceDataState)
        ))({
            AutomaticSize = Enum.AutomaticSize.None,
            Size = UDim2.fromScale(0.8, 1)
        }),
        _bind(trailingIcon)({
            LayoutOrder = 3,
        })
    }

    local out = Base.ColdFusion.new(
        maid, 
        containerColorState, 
        appearanceDataState,
        true, 
        Children
    )
    return out :: Frame
end

return TopAppBar