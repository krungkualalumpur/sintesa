--!strict
--services
--packages
--modules
local DynamicScheme = require(script:WaitForChild("dynamiccolor"):WaitForChild("dynamic_scheme"))
local DynamicColor = require(script:WaitForChild("dynamiccolor"):WaitForChild("dynamic_color"))
local Variant = require(script:WaitForChild("dynamiccolor"):WaitForChild("variant"))
local ContrastCurve = require(script:WaitForChild("dynamiccolor"):WaitForChild("contrast_curve"))
local ToneDeltaPair = require(script:WaitForChild("dynamiccolor"):WaitForChild("tone_delta_pair"))
local Hct = require(script:WaitForChild("hct"):WaitForChild("hct"))

local TonalPalette = require(script:WaitForChild("palettes"):WaitForChild("tonal_palette"))

local ColorUtil = require(script:WaitForChild("utils"):WaitForChild("color_utils"))
--types
--constants
type DynamicScheme = any
type DynamicColor = any
type TonalPalette = TonalPalette.TonalPalette
type ToneDeltaPair = ToneDeltaPair.ToneDeltaPair
type ContrastCurve = ContrastCurve.ContrastCurve
--remotes
--variables
--references
--local functions
local function getRGBComponentsFromColor3(
    color3 : Color3)
    
    local R, G, B = color3.R*255, color3.G*255, color3.B*255
    return R*255, G*255, B*255
end
--class
local MaterialColor = {}


function MaterialColor.getDynamicColor(
    primary : Color3,
    secondary : Color3,
    tertiary : Color3,

    neutral : Color3,
    neutralVariant : Color3): DynamicScheme
   -- print(primary.R*255, primary.G*255, primary.B*255) 

    local primaryR, primaryG, primaryB = getRGBComponentsFromColor3(Color3.fromRGB(primary.R, primary.G, primary.B))
    local secondaryR, secondaryG, secondaryB = getRGBComponentsFromColor3(Color3.fromRGB(secondary.R, secondary.G, secondary.B))
    local tertiaryR, tertiaryG, tertiaryB = getRGBComponentsFromColor3(Color3.fromRGB(tertiary.R, tertiary.G, tertiary.B))
    
    local neutralR, neutralG, neutralB = getRGBComponentsFromColor3(Color3.fromRGB(tertiary.R, tertiary.G, tertiary.B))
    local neutralVariantR, neutralVariantG, neutralVariantB = getRGBComponentsFromColor3(Color3.fromRGB(tertiary.R, tertiary.G, tertiary.B))

    local primary_hct = Hct.Hct.new(ColorUtil.argbFromRgb(primaryR, primaryG, primaryB))
    local secondary_hct = Hct.Hct.new(ColorUtil.argbFromRgb(secondaryR, secondaryG, secondaryB))
    local tertiary_hct = Hct.Hct.new(ColorUtil.argbFromRgb(tertiaryR, tertiaryG, tertiaryB))

    local neutral_hct = Hct.Hct.new(ColorUtil.argbFromRgb(neutralR, neutralG, neutralB))
    local neutralVariant_hct = Hct.Hct.new(ColorUtil.argbFromRgb(neutralVariantR, neutralVariantG, neutralVariantB))

    --[[{
        ColorUtil.argbFromRgb(primary.R, primary.G, primary.B),
        variant : Variant.Variant,
        contrastLevel: number,
        isDark: boolean,
        primaryPalette: TonalPalette,
        secondaryPalette: TonalPalette,
        tertiaryPalette: TonalPalette,
        neutralPalette: TonalPalette,
        neutralVariantPalette: TonalPalette
    }]]
    --[[local primary_dynamicColor = DynamicColor.DynamicColor.new(
        "primary",
        function (dynamicScheme : DynamicScheme)
            return TonalPalette.TonalPalette.fromHct(primary_hct)
        end, 
        function(dynamicScheme : DynamicScheme) 
            return primary_hct:get_tone()
        end
    )
    local secondary_dynamicColor = DynamicColor.DynamicColor.new(
        "secondary",
        function (dynamicScheme : DynamicScheme)
            return TonalPalette.TonalPalette.fromHct(secondary_hct)
        end, 
        function(dynamicScheme : DynamicScheme) 
            return secondary_hct:get_tone()
        end
    )
    local tertiary_dynamicColor = DynamicColor.DynamicColor.new(
        "tertiary",
        function (dynamicScheme : DynamicScheme)
            return TonalPalette.TonalPalette.fromHct(tertiary_hct)
        end, 
        function(dynamicScheme : DynamicScheme) 
            return tertiary_hct:get_tone()
        end
    )
    local neutral_dynamicColor = DynamicColor.DynamicColor.new(
        "neutral",
        function (dynamicScheme : DynamicScheme)
            return TonalPalette.TonalPalette.fromHct(neutral_hct)
        end, 
        function(dynamicScheme : DynamicScheme) 
            return neutral_hct:get_tone()
        end
    )
    local neutralVariant_dynamicColor = DynamicColor.DynamicColor.new(
        "neutralVariant",
        function (dynamicScheme : DynamicScheme)
            return TonalPalette.TonalPalette.fromHct(neutralVariant_hct)
        end, 
        function(dynamicScheme : DynamicScheme) 
            return neutralVariant_hct:get_tone()
        end
    )]]

    local primaryKeyColor = TonalPalette.TonalPalette.createKeyColor(primary_hct:get_hue(), primary_hct:get_chroma())
    local secondaryKeyColor = TonalPalette.TonalPalette.createKeyColor(secondary_hct:get_hue(), secondary_hct:get_chroma())
    local tertiaryKeyColor = TonalPalette.TonalPalette.createKeyColor(tertiary_hct:get_hue(), tertiary_hct:get_chroma())
    local neutralKeyColor = TonalPalette.TonalPalette.createKeyColor(neutral_hct:get_hue(), neutral_hct:get_chroma())
    local neutralVariantKeyColor = TonalPalette.TonalPalette.createKeyColor(neutralVariant_hct:get_hue(), neutralVariant_hct:get_chroma())

    local primaryPalette = TonalPalette.TonalPalette.new(
        primary_hct:get_hue(), 
        primary_hct:get_chroma(), 
        primaryKeyColor:create()
    )
    local secondaryPalette = TonalPalette.TonalPalette.new(
        secondary_hct:get_hue(), 
        secondary_hct:get_chroma(), 
        secondaryKeyColor:create()
    )
    local tertiaryPalette = TonalPalette.TonalPalette.new(
        tertiary_hct:get_hue(), 
        tertiary_hct:get_chroma(), 
        tertiaryKeyColor:create()
    )
    local neutralPalette = TonalPalette.TonalPalette.new(
        neutral_hct:get_hue(), 
        neutral_hct:get_chroma(), 
        neutralKeyColor:create()
    )
    local neutralVariantPalette = TonalPalette.TonalPalette.new(
        neutralVariant_hct:get_hue(), 
        neutralVariant_hct:get_chroma(), 
        neutralVariantKeyColor:create()
    )

    local sourceColor = ColorUtil.argbFromRgb(primaryR,primaryG, primaryB)

    local dynamic_Scheme = DynamicScheme.DynamicScheme.new({
        sourceColorArgb = sourceColor,
        isDark = true,
        contrastLevel = 0,
        variant = Variant.Variant,
        primaryPalette = primaryPalette,
        secondaryPalette = secondaryPalette,
        tertiaryPalette = tertiaryPalette,
        neutralPalette = neutralPalette, 
        neutralVariantPalette = neutralVariantPalette, 
    })

   -- local argb = primary_dynamicColor:getArgb(dynamic_Scheme)
    --local primary_argb = dynamic_Scheme:getArgb(primary_dynamicColor)
   -- local secondary_argb = dynamic_Scheme:getArgb(secondary_dynamicColor)
   -- print(ColorUtil.rgbaFromArgb(primary_argb), "\n", ColorUtil.rgbaFromArgb(secondary_argb), "\n", ColorUtil.rgbaFromArgb(primary_dynamicColor:getArgb(dynamic_Scheme)))
    
    return dynamic_Scheme
end

return MaterialColor