-- Compiled with roblox-ts v2.3.0
local TS = _G[script]
--[[
	*
	 * @license
	 * Copyright 2022 Google LLC
	 *
	 * Licensed under the Apache License, Version 2.0 (the "License");
	 * you may not use this file except in compliance with the License.
	 * You may obtain a copy of the License at
	 *
	 *      http://www.apache.org/licenses/LICENSE-2.0
	 *
	 * Unless required by applicable law or agreed to in writing, software
	 * distributed under the License is distributed on an "AS IS" BASIS,
	 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	 * See the License for the specific language governing permissions and
	 * limitations under the License.
	 
]]


local Hct = require(script.Parent.Parent:WaitForChild("hct"):WaitForChild("hct")).Hct
local Variant = require(script.Parent:WaitForChild("variant"))
local TonalPalette_Raw = require(script.Parent.Parent:WaitForChild("palettes"):WaitForChild("tonal_palette"))
local TonalPalette = TonalPalette_Raw.TonalPalette
local mathUtils = require(script.Parent.Parent:WaitForChild("utils"):WaitForChild("math_utils"))
local MaterialDynamicColors = require(script.Parent:WaitForChild("material_dynamic_colors")).MaterialDynamicColors

--types
type TonalPalette = TonalPalette_Raw.TonalPalette
export type DynamicSchemeOptions = {
    sourceColorArgb: any;
    variant: Variant.Variant;
    contrastLevel: number;
    isDark: boolean;
    primaryPalette: TonalPalette;
    secondaryPalette: TonalPalette;
    tertiaryPalette: TonalPalette;
    neutralPalette: TonalPalette;
    neutralVariantPalette: TonalPalette;
}
--
--[[
	*
	 * @param sourceColorArgb The source color of the theme as an ARGB 32-bit
	 *     integer.
	 * @param variant The variant, or style, of the theme.
	 * @param contrastLevel Value from -1 to 1. -1 represents minimum contrast,
	 * 0 represents standard (i.e. the design as spec'd), and 1 represents maximum
	 * contrast.
	 * @param isDark Whether the scheme is in dark mode or light mode.
	 * @param primaryPalette Given a tone, produces a color. Hue and chroma of the
	 * color are specified in the design specification of the variant. Usually
	 * colorful.
	 * @param secondaryPalette Given a tone, produces a color. Hue and chroma of
	 * the color are specified in the design specification of the variant. Usually
	 * less colorful.
	 * @param tertiaryPalette Given a tone, produces a color. Hue and chroma of
	 * the color are specified in the design specification of the variant. Usually
	 * a different hue from primary and colorful.
	 * @param neutralPalette Given a tone, produces a color. Hue and chroma of the
	 * color are specified in the design specification of the variant. Usually not
	 * colorful at all, intended for background & surface colors.
	 * @param neutralVariantPalette Given a tone, produces a color. Hue and chroma
	 * of the color are specified in the design specification of the variant.
	 * Usually not colorful, but slightly more colorful than Neutral. Intended for
	 * backgrounds & surfaces.
	 
]]
--[[
	*
	 * Constructed by a set of values representing the current UI state (such as
	 * whether or not its dark theme, what the theme style is, etc.), and
	 * provides a set of TonalPalettes that can create colors that fit in
	 * with the theme style. Used by DynamicColor to resolve into a color.
	 
]]
local DynamicScheme
do
	DynamicScheme = setmetatable({}, {
		__tostring = function()
			return "DynamicScheme"
		end,
	})
	DynamicScheme.__index = DynamicScheme
	function DynamicScheme.new(dynamicScheme : DynamicSchemeOptions)
		local self = setmetatable({}, DynamicScheme)
		return self:constructor(dynamicScheme) or self
	end
	function DynamicScheme:constructor(args : DynamicSchemeOptions)
		self.sourceColorArgb = args.sourceColorArgb
		self.variant = args.variant
		self.contrastLevel = args.contrastLevel
		self.isDark = args.isDark
		self.sourceColorHct = Hct:fromInt(args.sourceColorArgb)
		self.primaryPalette = args.primaryPalette
		self.secondaryPalette = args.secondaryPalette
		self.tertiaryPalette = args.tertiaryPalette
		self.neutralPalette = args.neutralPalette
		self.neutralVariantPalette = args.neutralVariantPalette
		self.errorPalette = TonalPalette:fromHueAndChroma(25.0, 84.0)
	end
	function DynamicScheme:getRotatedHue(sourceColor, hues, rotations)
		local sourceHue = sourceColor:get_hue()
		if #hues ~= #rotations then
			error(`mismatch between hue length {#hues} & rotations {#rotations}`)
		end
		if #rotations == 1 then
			return mathUtils.sanitizeDegreesDouble(sourceColor:get_hue() + rotations[1])
		end
		local size = #hues
		do
			local i = 0
			local _shouldIncrement = false
			while true do
				if _shouldIncrement then
					i += 1
				else
					_shouldIncrement = true
				end
				if not (i <= size - 2) then
					break
				end
				local thisHue = hues[i + 1]
				local nextHue = hues[i + 2]
				if thisHue < sourceHue and sourceHue < nextHue then
					return mathUtils.sanitizeDegreesDouble(sourceHue + rotations[i + 1])
				end
			end
		end
		-- If this statement executes, something is wrong, there should have been a
		-- rotation found using the arrays.
		return sourceHue
	end
	function DynamicScheme:getArgb(dynamicColor)
		return dynamicColor:getArgb(self)
	end
	function DynamicScheme:getHct(dynamicColor)
		return dynamicColor:getHct(self)
	end
	function DynamicScheme:get_primaryPaletteKeyColor()
		return self:getArgb(MaterialDynamicColors.primaryPaletteKeyColor)
	end
	function DynamicScheme:get_secondaryPaletteKeyColor()
		return self:getArgb(MaterialDynamicColors.secondaryPaletteKeyColor)
	end
	function DynamicScheme:get_tertiaryPaletteKeyColor()
		return self:getArgb(MaterialDynamicColors.tertiaryPaletteKeyColor)
	end
	function DynamicScheme:get_neutralPaletteKeyColor()
		return self:getArgb(MaterialDynamicColors.neutralPaletteKeyColor)
	end
	function DynamicScheme:get_neutralVariantPaletteKeyColor()
		return self:getArgb(MaterialDynamicColors.neutralVariantPaletteKeyColor)
	end
	function DynamicScheme:get_background()
		return self:getArgb(MaterialDynamicColors.background)
	end
	function DynamicScheme:get_onBackground()
		return self:getArgb(MaterialDynamicColors.onBackground)
	end
	function DynamicScheme:get_surface()
		return self:getArgb(MaterialDynamicColors.surface)
	end
	function DynamicScheme:get_surfaceDim()
		return self:getArgb(MaterialDynamicColors.surfaceDim)
	end
	function DynamicScheme:get_surfaceBright()
		return self:getArgb(MaterialDynamicColors.surfaceBright)
	end
	function DynamicScheme:get_surfaceContainerLowest()
		return self:getArgb(MaterialDynamicColors.surfaceContainerLowest)
	end
	function DynamicScheme:get_surfaceContainerLow()
		return self:getArgb(MaterialDynamicColors.surfaceContainerLow)
	end
	function DynamicScheme:get_surfaceContainer()
		return self:getArgb(MaterialDynamicColors.surfaceContainer)
	end
	function DynamicScheme:get_surfaceContainerHigh()
		return self:getArgb(MaterialDynamicColors.surfaceContainerHigh)
	end
	function DynamicScheme:get_surfaceContainerHighest()
		return self:getArgb(MaterialDynamicColors.surfaceContainerHighest)
	end
	function DynamicScheme:get_onSurface()
		return self:getArgb(MaterialDynamicColors.onSurface)
	end
	function DynamicScheme:get_surfaceVariant()
		return self:getArgb(MaterialDynamicColors.surfaceVariant)
	end
	function DynamicScheme:get_onSurfaceVariant()
		return self:getArgb(MaterialDynamicColors.onSurfaceVariant)
	end
	function DynamicScheme:get_inverseSurface()
		return self:getArgb(MaterialDynamicColors.inverseSurface)
	end
	function DynamicScheme:get_inverseOnSurface()
		return self:getArgb(MaterialDynamicColors.inverseOnSurface)
	end
	function DynamicScheme:get_outline()
		return self:getArgb(MaterialDynamicColors.outline)
	end
	function DynamicScheme:get_outlineVariant()
		return self:getArgb(MaterialDynamicColors.outlineVariant)
	end
	function DynamicScheme:get_shadow()
		return self:getArgb(MaterialDynamicColors.shadow)
	end
	function DynamicScheme:get_scrim()
		return self:getArgb(MaterialDynamicColors.scrim)
	end
	function DynamicScheme:get_surfaceTint()
		return self:getArgb(MaterialDynamicColors.surfaceTint)
	end
	function DynamicScheme:get_primary()
		return self:getArgb(MaterialDynamicColors.primary)
	end
	function DynamicScheme:get_onPrimary()
		return self:getArgb(MaterialDynamicColors.onPrimary)
	end
	function DynamicScheme:get_primaryContainer()
		return self:getArgb(MaterialDynamicColors.primaryContainer)
	end
	function DynamicScheme:get_onPrimaryContainer()
		return self:getArgb(MaterialDynamicColors.onPrimaryContainer)
	end
	function DynamicScheme:get_inversePrimary()
		return self:getArgb(MaterialDynamicColors.inversePrimary)
	end
	function DynamicScheme:get_secondary()
		return self:getArgb(MaterialDynamicColors.secondary)
	end
	function DynamicScheme:get_onSecondary()
		return self:getArgb(MaterialDynamicColors.onSecondary)
	end
	function DynamicScheme:get_secondaryContainer()
		return self:getArgb(MaterialDynamicColors.secondaryContainer)
	end
	function DynamicScheme:get_onSecondaryContainer()
		return self:getArgb(MaterialDynamicColors.onSecondaryContainer)
	end
	function DynamicScheme:get_tertiary()
		return self:getArgb(MaterialDynamicColors.tertiary)
	end
	function DynamicScheme:get_onTertiary()
		return self:getArgb(MaterialDynamicColors.onTertiary)
	end
	function DynamicScheme:get_tertiaryContainer()
		return self:getArgb(MaterialDynamicColors.tertiaryContainer)
	end
	function DynamicScheme:get_onTertiaryContainer()
		return self:getArgb(MaterialDynamicColors.onTertiaryContainer)
	end
	function DynamicScheme:get_error()
		return self:getArgb(MaterialDynamicColors.error)
	end
	function DynamicScheme:get_onError()
		return self:getArgb(MaterialDynamicColors.onError)
	end
	function DynamicScheme:get_errorContainer()
		return self:getArgb(MaterialDynamicColors.errorContainer)
	end
	function DynamicScheme:get_onErrorContainer()
		return self:getArgb(MaterialDynamicColors.onErrorContainer)
	end
	function DynamicScheme:get_primaryFixed()
		return self:getArgb(MaterialDynamicColors.primaryFixed)
	end
	function DynamicScheme:get_primaryFixedDim()
		return self:getArgb(MaterialDynamicColors.primaryFixedDim)
	end
	function DynamicScheme:get_onPrimaryFixed()
		return self:getArgb(MaterialDynamicColors.onPrimaryFixed)
	end
	function DynamicScheme:get_onPrimaryFixedVariant()
		return self:getArgb(MaterialDynamicColors.onPrimaryFixedVariant)
	end
	function DynamicScheme:get_secondaryFixed()
		return self:getArgb(MaterialDynamicColors.secondaryFixed)
	end
	function DynamicScheme:get_secondaryFixedDim()
		return self:getArgb(MaterialDynamicColors.secondaryFixedDim)
	end
	function DynamicScheme:get_onSecondaryFixed()
		return self:getArgb(MaterialDynamicColors.onSecondaryFixed)
	end
	function DynamicScheme:get_onSecondaryFixedVariant()
		return self:getArgb(MaterialDynamicColors.onSecondaryFixedVariant)
	end
	function DynamicScheme:get_tertiaryFixed()
		return self:getArgb(MaterialDynamicColors.tertiaryFixed)
	end
	function DynamicScheme:get_tertiaryFixedDim()
		return self:getArgb(MaterialDynamicColors.tertiaryFixedDim)
	end
	function DynamicScheme:get_onTertiaryFixed()
		return self:getArgb(MaterialDynamicColors.onTertiaryFixed)
	end
	function DynamicScheme:get_onTertiaryFixedVariant()
		return self:getArgb(MaterialDynamicColors.onTertiaryFixedVariant)
	end
end
return {
	DynamicScheme = DynamicScheme,
}
