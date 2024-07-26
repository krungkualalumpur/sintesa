--!strict
local _Packages = game:GetService("ReplicatedStorage"):WaitForChild("Packages")
--services 
local UserInputService =  game:GetService("UserInputService")
--packages
local Maid = require(_Packages:WaitForChild("Maid"))
local ColdFusion = require(_Packages:WaitForChild("ColdFusion8"))
--modules
local Types = require(script.Parent.Parent.Parent:WaitForChild("Types"))
local Enums = require(script.Parent.Parent.Parent:WaitForChild("Enums"))
local Icons = require(script.Parent.Parent.Parent:WaitForChild("Icons"))

local MaterialColor = require(
    script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("MaterialColor")
)

local DynamicTheme = require(script.Parent.Parent:WaitForChild("dynamic_theme"))

local ShapeStyle = require(script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("Shape"))
local ElevationStyle = require(script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("Elevation"))

local ImageLabel = require(script.Parent.Parent:WaitForChild("Util"):WaitForChild("ImageLabel"))

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
local PADDING_SIZE = UDim.new(0,12)
--remotes
--variables
--references
--local functions
local function mouseIsInButton(button : GuiObject)
    local mouse = UserInputService:GetMouseLocation()
    if ((mouse.X > button.AbsolutePosition.X) and (mouse.X < (button.AbsolutePosition.X + button.AbsoluteSize.X))) 
    and ((mouse.Y > button.AbsolutePosition.Y) and (mouse.Y < (button.AbsolutePosition.Y + button.AbsoluteSize.Y))) then
        return true
    end
    return false
end
--class
local interface = {}

interface.ColdFusion = {}

function interface.ColdFusion.new(
    maid : Maid,

    isDark : CanBeState<boolean>,
    progress : State<number>)
    
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
        local outlineVariant = MaterialColor.Color3FromARGB(dynamicScheme:get_outlineVariant())
            
        return  outlineVariant
    end, appearanceDataState)
    
    local activeTrackColorState = _Computed(function(appearance : AppearanceData)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local primary = MaterialColor.Color3FromARGB(dynamicScheme:get_primary())
        local onSurface = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurface())

        return primary 
    end, appearanceDataState)

    local inactiveTrackColorState = _Computed(function(appearance : AppearanceData)
        local dynamicScheme = MaterialColor.getDynamicScheme(
            appearance.PrimaryColor, 
            appearance.SecondaryColor, 
            appearance.TertiaryColor, 
            appearance.NeutralColor, 
            appearance.NeutralVariantColor,
            appearance.IsDark
        )
        local secondaryContainer = MaterialColor.Color3FromARGB(dynamicScheme:get_secondaryContainer())
        local onSurfaceVariant = MaterialColor.Color3FromARGB(dynamicScheme:get_onSurfaceVariant())
        return secondaryContainer 
    end, appearanceDataState)

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
        BackgroundColor3 = containerColorState,
        Size = UDim2.fromOffset(100, 100),
        Children = {
            -- _bind(ImageLabel.ColdFusion.new(maid, 1, Icons.image.blur_circular))({
            --     Size = UDim2.fromOffset(100, 100)
            -- })
        }
    }) 

    local radius = 15
    local interval = 0.3
    for i = 0, math.pi*2, interval do
        _new("Frame")({
            Parent = out,
            Rotation = math.deg(i),
            BackgroundColor3 = _Computed(function(num : number, appearance : AppearanceData)
                local dynamicScheme = MaterialColor.getDynamicScheme(
                    appearance.PrimaryColor, 
                    appearance.SecondaryColor, 
                    appearance.TertiaryColor, 
                    appearance.NeutralColor, 
                    appearance.NeutralVariantColor,
                    appearance.IsDark
                )
                local primary = MaterialColor.Color3FromARGB(dynamicScheme:get_primary())
                local secondaryContainer = MaterialColor.Color3FromARGB(dynamicScheme:get_secondaryContainer())

                return if num > (i/(math.pi*2)) then primary else secondaryContainer
            end, progress, appearanceDataState):Tween(),
            Size = UDim2.fromOffset(2*math.pi*radius/(math.pi*2*(1/(interval))), 3),
            Position = UDim2.fromOffset(math.cos(i - math.pi/2)*radius, math.sin(i - math.pi/2)*radius),
            Children = {
                _new("UICorner")({
                    CornerRadius = UDim.new(0, 200)
                })
            }
        })
    end

    return out
end


return interface