--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Package = ReplicatedStorage:WaitForChild("Packages")
--services
--packages
local Maid = require(Package:WaitForChild("Maid"))
local ColdFusion = require(Package:WaitForChild("ColdFusion8"))
--modules
local MaterialColor = require(
    script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("MaterialColor")
) 

local DynamicTheme = require(script.Parent.Parent:WaitForChild("dynamic_theme"))

local Slider: any = require(script.Parent)
local Types = require(script.Parent.Parent.Parent:WaitForChild("Types"))
local Icons = require(script.Parent.Parent.Parent:WaitForChild("Icons"))
local Styles = require(script.Parent.Parent.Parent:WaitForChild("Styles"))
local Enums = require(script.Parent.Parent.Parent:WaitForChild("Enums"))

local TextLabel = require(script.Parent.Parent:WaitForChild("Util"):WaitForChild("TextLabel"))
--types
type Fuse = ColdFusion.Fuse
type State<T> = ColdFusion.State<T>
type ValueState<T> = ColdFusion.ValueState<T>
type CanBeState<T> = ColdFusion.CanBeState<T>

type AppearanceData = Types.AppearanceData
type TypographyData = Types.TypographyData
type TransitionData = Types.TransitionData

type ButtonData = Types.ButtonData

--constants
--remotes 
--variables
--references
--local functions 
--class
return function(target : CoreGui) 
    local maid = Maid.new()

    local _fuse = ColdFusion.fuse(maid)
    local _new = _fuse.new
    local _import = _fuse.import
    local _bind = _fuse.bind
    local _clone = _fuse.clone
    local _Computed = _fuse.Computed
    local _Value = _fuse.Value
  
    local isDark = _Value(false)


    local out = Slider.ColdFusion.new(
        maid,
        isDark,
        300,
        NumberRange.new(-120,100),
        true,
        _Value(0.5)
    )
    out.Position = UDim2.fromScale(0.4, 0.4)
    
    local labelLarge = Styles.Typography.get(Enums.TypographyStyle.HeadlineSmall)
    local typographyDataState = _Value(Types.createTypographyData(
        labelLarge
    ))

    local isDarkState = _Value(false)
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

    local labelTextColorState = _Computed(function(appearance : AppearanceData)
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
        local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())
            
        return onSurface
        
    end, appearanceDataState)


    local bg = _new("Frame")({
        Size = UDim2.fromScale(1, 1),
        Children = {
            _new("UIListLayout")({
                HorizontalAlignment = Enum.HorizontalAlignment.Center, 
                VerticalAlignment = Enum.VerticalAlignment.Center,
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            TextLabel.ColdFusion.new(maid, 1, "Min", labelTextColorState, typographyDataState, 25),
            _bind(out)({LayoutOrder = 3}),
            TextLabel.ColdFusion.new(maid, 3, "Max", labelTextColorState, typographyDataState, 25),

        }
    })
    bg.Parent = target


    out.Interactable = true
    
    return function()
        maid:Destroy()
    end  
end