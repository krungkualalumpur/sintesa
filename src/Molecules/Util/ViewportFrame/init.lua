--!strict
local _Packages = game:GetService("ReplicatedStorage"):WaitForChild("Packages")
--services 
local RunService =  game:GetService("RunService")
--packages
local Maid = require(_Packages:WaitForChild("Maid"))
local ColdFusion = require(_Packages:WaitForChild("ColdFusion8"))
--modules
local Types = require(script.Parent.Parent.Parent:WaitForChild("Types"))
local Enums = require(script.Parent.Parent.Parent:WaitForChild("Enums"))

local MaterialColor = require(
    script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("MaterialColor")
)

local DynamicTheme = require(script.Parent.Parent:WaitForChild("dynamic_theme"))

local ShapeStyle = require(script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("Shape"))
local ElevationStyle = require(script.Parent.Parent.Parent:WaitForChild("Styles"):WaitForChild("Elevation"))

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
local Util = {}
Util.ColdFusion = {}

function Util.ColdFusion.new(
    maid : Maid,
    instance : CanBeState<Instance>,
    height : CanBeState<number>,
    isRotate : CanBeState<boolean>,
    isDark : CanBeState<boolean>,
    shapeStyle : CanBeState<Enums.ShapeStyle>?)

    local _fuse = ColdFusion.fuse(maid)
    local _new = _fuse.new
    local _import = _fuse.import
    local _bind = _fuse.bind
    local _clone = _fuse.clone
    local _Computed = _fuse.Computed
    local _Value = _fuse.Value
   
    local instanceState = _import(instance, instance)
    local cfOffset = _Value(Vector3.new(1, 1, 2))
    local isRotateState = _import(isRotate, isRotate)
    
    local isDarkState = _import(isDark, isDark)
    local shapeStyleState = _import(shapeStyle :: Enums.ShapeStyle, Enums.ShapeStyle.Medium) 

    local getUiCorner = function()
        return _new("UICorner")({
            CornerRadius = _Computed(function(style : Enums.ShapeStyle) 
                return UDim.new(
                    0,  
                    ShapeStyle.get(style)
                )
            end, shapeStyleState),
        })
    end

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
    
    local camera = _new("Camera")({
        FieldOfView = 40,
        CFrame = _Computed(function(inst : Instance, offset : Vector3) 
            local cf, size =  if inst:IsA("BasePart") then 
                (inst.CFrame) elseif inst:IsA("Model") then inst:GetBoundingBox() else nil, if inst:IsA("BasePart") then 
                (inst.Size) elseif inst:IsA("Model") then inst:GetExtentsSize() else nil 

            return if cf and size then CFrame.new(cf.Position + size*offset, cf.Position) else CFrame.new()
        end, instanceState, cfOffset) 
    })

    local _maid = maid:GiveTask(Maid.new())
    local heightState = _import(height, height)
    return _new("ViewportFrame")({
        BackgroundTransparency = _Computed(function(rotate : boolean)
            _maid:DoCleaning()
            if rotate then
                local x = 0
                _maid:GiveTask(RunService.Stepped:Connect(function()
                    x += 0.5
                    cfOffset:Set(Vector3.new(math.cos(math.rad(x)), 0.5, math.sin(math.rad(x)))*2.4)
                end))
            end
            return 0
        end, isRotateState),
        BackgroundColor3 = _Computed(function(appearance : AppearanceData)
            local dynamicScheme = MaterialColor.getDynamicScheme(
                appearance.PrimaryColor, 
                appearance.SecondaryColor, 
                appearance.TertiaryColor, 
                appearance.NeutralColor, 
                appearance.NeutralVariantColor,
                appearance.IsDark
            )
            local surfaceContainerHighest = MaterialColor.Color3FromARGB(dynamicScheme:get_surfaceContainerHighest())
            
            return surfaceContainerHighest
        end, appearanceDataState),
        Size = _Computed(function(h : number)
            return UDim2.fromOffset(h, h)
        end, heightState),
        CurrentCamera = camera,
        Children = {
            getUiCorner(),
            camera,
            _new("WorldModel")({
                Children = {
                    instance
                }
            })
        }
    }) :: ViewportFrame
end

return Util