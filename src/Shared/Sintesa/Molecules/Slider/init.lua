--!strict
--services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
--packages
local Maid = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Maid"))
local ColdFusion = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("ColdFusion8"))
local Signal = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Signal"))
--modules
local Types = require(script.Parent.Parent:WaitForChild("Types"))
local Icons = require(script.Parent.Parent:WaitForChild("Icons"))
local Enums = require(script.Parent.Parent:WaitForChild("Enums"))

local Styles = require(script.Parent.Parent:WaitForChild("Styles"))
local ShapeStyle = require(script.Parent.Parent:WaitForChild("Styles"):WaitForChild("Shape"))

local MaterialColor = require(
    script.Parent.Parent:WaitForChild("Styles"):WaitForChild("MaterialColor")
)
local DynamicTheme = require(script.Parent:WaitForChild("dynamic_theme"))
--types
type Maid = Maid.Maid
type Signal = Signal.Signal

type Fuse = ColdFusion.Fuse
type State<T> = ColdFusion.State<T>
type ValueState<T> = ColdFusion.ValueState<T>
type CanBeState<T> = ColdFusion.CanBeState<T>

type AppearanceData = Types.AppearanceData
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
    isDark : CanBeState<boolean>)   
    
    local _fuse = ColdFusion.fuse(maid)
    local _new = _fuse.new
    local _import = _fuse.import
    local _bind = _fuse.bind
    local _clone = _fuse.clone
    local _Computed = _fuse.Computed
    local _Value = _fuse.Value
   
    local isDarkState = _import(isDark, isDark)
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
            Enums.ShapeStyle.ExtraSmall,
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
        
        return secondaryContainer
    end, appearanceDataState)

    local ratio = 0.5

    local buttonSeparatorSize = 0.05
    local out = _new("Frame"){
        BackgroundTransparency = 0,
        BackgroundColor3 = Color3.fromRGB(255,0,0),
        Size = UDim2.fromOffset(400, 16),
        Children = {
            getUiCorner(),

           
            _new("Frame"){
                Size = UDim2.fromScale(1, 1),
                Children = {
                    _new("UIListLayout")({
                        FillDirection = Enum.FillDirection.Horizontal,
                        SortOrder = Enum.SortOrder.LayoutOrder
                    }),
                    _new("Frame")({
                        LayoutOrder = 1,
                        Name = "Active",
                        BackgroundColor3 = activeTrackColorState,
                        Size = UDim2.fromScale(math.clamp(ratio - buttonSeparatorSize*0.5, 0, 1), 1) ,
                        Children = {
                            getUiCorner(),

                        }
                    }),
                    _new("TextButton")({
                        Name = "Button",
                        LayoutOrder = 2,
                        ZIndex = 2,
                        AnchorPoint = Vector2.new(0.5,0.5),
                        BackgroundTransparency = 1,
                        Size = UDim2.fromScale(buttonSeparatorSize, 1),
                        Children = {
                            _new("TextButton")({
                                AnchorPoint = Vector2.new(0.5,0.5),
                                BackgroundColor3 = activeTrackColorState,
                                Position = UDim2.fromScale(0.5, 0.5),    
                                Size = UDim2.fromOffset(6, 44),
                                Children = {
                                    getUiCorner()
                                }
                            })
                        }
                    }),
                    _new("Frame")({
                        LayoutOrder = 3,
                        Name = "Inactive",
                        BackgroundColor3 = inactiveTrackColorState,
                        Size = UDim2.fromScale(math.clamp(1 - (ratio + buttonSeparatorSize*0.5), 0, 1), 1)  ,
                        Children = {
                            getUiCorner(),

                        }
                    })
                }
                }
            }
           
    } 
    return out

end
return interface