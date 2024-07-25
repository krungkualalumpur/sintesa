--!strict
local _Packages = game:GetService("ReplicatedStorage"):WaitForChild("Packages")
--services 
local UserInputService =  game:GetService("UserInputService")
--packages
local Maid = require(_Packages:WaitForChild("Maid"))
local ColdFusion = require(_Packages:WaitForChild("ColdFusion8"))
--modules
local Types = require(script.Parent.Parent:WaitForChild("Types"))
local Icons = require(script.Parent.Parent:WaitForChild("Icons"))
local Enums = require(script.Parent.Parent:WaitForChild("Enums"))
local Styles = require(script.Parent.Parent:WaitForChild("Styles"))

local MaterialColor = require(
    script.Parent.Parent:WaitForChild("Styles"):WaitForChild("MaterialColor")
)

local DynamicTheme = require(script.Parent:WaitForChild("dynamic_theme"))

local ShapeStyle = require(script.Parent.Parent:WaitForChild("Styles"):WaitForChild("Shape"))
local ElevationStyle = require(script.Parent.Parent:WaitForChild("Styles"):WaitForChild("Elevation"))

local StandardTextButton = require(script.Parent:WaitForChild("Buttons"):WaitForChild("CommonButton"):WaitForChild("Text"))
local StandardIconButton = require(script.Parent:WaitForChild("Buttons"):WaitForChild("IconButton"):WaitForChild("Standard"))

local TextLabel = require(script.Parent:WaitForChild("Util"):WaitForChild("TextLabel"))
local ImageLabel = require(script.Parent:WaitForChild("Util"):WaitForChild("ImageLabel"))
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
    
    buttonsList : CanBeState<{
        [number] : Types.ButtonData
    }>,
    length : CanBeState<number>,

    buttonsClickFn : (Types.ButtonData) -> ())
    local _fuse = ColdFusion.fuse(maid)
    local _new = _fuse.new
    local _import = _fuse.import
    local _bind = _fuse.bind
    local _clone = _fuse.clone
    local _Computed = _fuse.Computed
    local _Value = _fuse.Value
    
    local isDarkState = _import(isDark, false)
    local lengthState = _import(length, length)

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
        local surface =  MaterialColor.Color3FromARGB(dynamicScheme:get_surface())

        return surface
    end, appearanceDataState)
 
    local typographyDataState = _Value(Types.createTypographyData(
        Styles.Typography.get(Enums.TypographyStyle.BodyLarge)
    ))

    local buttonsListState = _import(buttonsList, buttonsList)

   
    local children = _Computed(function(list : {Types.ButtonData})
        return list
    end, buttonsListState):ForValues(function(data : Types.ButtonData, maid: Maid)  
        local buttonName = data.Name or ""
        local isSelected = data.Selected or _Computed(function() return false end)
        local iconId = data.Id or 0
    
        local buttonState = _Value(Enums.ButtonState.Enabled :: Enums.ButtonState) 

        local textColorState = _Computed(function(appearance : AppearanceData, _buttonState : Enums.ButtonState, selected : boolean)
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
                                            
            return if selected then  primary else  onSurfaceVariant
        end, appearanceDataState, buttonState, isSelected)

        local imageLabel = _bind(ImageLabel.ColdFusion.new(maid, 1, iconId, textColorState:Tween()))({
            Size = if data.Id then UDim2.fromOffset(24, 24) else UDim2.fromOffset(0, 0)
        })
        local textLabel = _bind(TextLabel.ColdFusion.new(maid, 2, buttonName, textColorState:Tween(), typographyDataState, 10))({
            Size = _Computed(function(length : number)
                return if data.Id then UDim2.fromOffset(length/(#buttonsListState:Get()), 20) else UDim2.fromOffset(length/(#buttonsListState:Get()), 20 + 24)
            end, lengthState) 
        })
        
        local activeIndicatorState  = _Computed(function(appearance : AppearanceData, selected : boolean)
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
                                            
            return if selected then primary  else onSurfaceVariant
        end, appearanceDataState, isSelected) 
        local activeIndicator = _new("Frame")({
            LayoutOrder = 3,
            BackgroundColor3 = activeIndicatorState:Tween(),
            Size = _Computed(function(selected : boolean, length : number)
                return if selected then UDim2.new(0,length/(#buttonsListState:Get()), 0, 2) else UDim2.new(0,0, 0, 2)
            end, isSelected, lengthState):Tween()
        })
        
        local out = _new("TextButton")({
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.XY,
            Children = {
                _new("UIListLayout")({
                    FillDirection = Enum.FillDirection.Vertical,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    SortOrder = Enum.SortOrder.LayoutOrder
                }),
                imageLabel,
                textLabel,
                activeIndicator
            },
            Events = {
                MouseButton1Down = function() 
                    buttonsClickFn(data)
                end,
                MouseButton1Up = function() end
            }
        })
        return out 
    end)

    local out = _new("Frame")({
        AutomaticSize = Enum.AutomaticSize.X,
        Size = _Computed(function(length : number)
            return UDim2.fromOffset(length, 48)
        end, lengthState), 
        Position = UDim2.new(0,0,1,0) - UDim2.new(0,0,0,48),
        BackgroundColor3 = containerColorState,
        Children = {
            _new("UIListLayout")({
                FillDirection = Enum.FillDirection.Horizontal,
                VerticalAlignment = Enum.VerticalAlignment.Top,
            }),
            children
        }
    })
    return out
end

return Interface