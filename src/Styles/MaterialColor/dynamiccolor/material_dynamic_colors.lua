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
local DislikeAnalyzer = require(script.Parent.Parent:WaitForChild("dislike"):WaitForChild("dislike_analyzer")).DislikeAnalyzer
local Hct = require(script.Parent.Parent:WaitForChild("hct"):WaitForChild("hct")).Hct
local ContrastCurve = require(script.Parent:WaitForChild("contrast_curve")).ContrastCurve
local DynamicColor = require(script.Parent:WaitForChild("dynamic_color")).DynamicColor
local ToneDeltaPair = require(script.Parent:WaitForChild("tone_delta_pair")).ToneDeltaPair
local Variant = require(script.Parent:WaitForChild("variant")).Variant
local function isFidelity(scheme)
	return scheme.variant == Variant.FIDELITY or scheme.variant == Variant.CONTENT
end
local function isMonochrome(scheme)
	return scheme.variant == Variant.MONOCHROME
end
local function findDesiredChromaByTone(hue, chroma, tone, byDecreasingTone)
	local answer = tone
	local closestToChroma = Hct:from(hue, chroma, tone)
	if closestToChroma:get_chroma() < chroma then
		local chromaPeak = closestToChroma:get_chroma()
		while closestToChroma:get_chroma() < chroma do
			answer += if byDecreasingTone then -1.0 else 1.0
			local potentialSolution = Hct:from(hue, chroma, answer)
			if chromaPeak > potentialSolution:get_chroma() then
				break
			end
			if math.abs(potentialSolution:get_chroma() - chroma) < 0.4 then
				break
			end
			local potentialDelta = math.abs(potentialSolution:get_chroma() - chroma)
			local currentDelta = math.abs(closestToChroma:get_chroma() - chroma)
			if potentialDelta < currentDelta then
				closestToChroma = potentialSolution
			end
			chromaPeak = math.max(chromaPeak, potentialSolution:get_chroma())
		end
	end
	return answer
end
--[[
	*
	 * DynamicColors for the colors in the Material Design system.
	 
]]
-- Material Color Utilities namespaces the various utilities it provides.
-- tslint:disable-next-line:class-as-namespace
local MaterialDynamicColors
do
	MaterialDynamicColors = setmetatable({}, {
		__tostring = function()
			return "MaterialDynamicColors"
		end,
	})
	MaterialDynamicColors.__index = MaterialDynamicColors
	function MaterialDynamicColors.new(...)
		local self = setmetatable({}, MaterialDynamicColors)
		return self:constructor(...) or self
	end
	function MaterialDynamicColors:constructor()
	end
	function MaterialDynamicColors:highestSurface(s)
		return if s.isDark then MaterialDynamicColors.surfaceBright else MaterialDynamicColors.surfaceDim
	end
	MaterialDynamicColors.contentAccentToneDelta = 15.0
	MaterialDynamicColors.primaryPaletteKeyColor = DynamicColor.fromPalette({
		name = "primary_palette_key_color",
		palette = function(s)
			return s.primaryPalette
		end,
		tone = function(s)
			return s.primaryPalette.keyColor:get_tone()
		end,
	})
	MaterialDynamicColors.secondaryPaletteKeyColor = DynamicColor.fromPalette({
		name = "secondary_palette_key_color",
		palette = function(s)
			return s.secondaryPalette
		end,
		tone = function(s)
			return s.secondaryPalette.keyColor:get_tone()
		end,
	})
	MaterialDynamicColors.tertiaryPaletteKeyColor = DynamicColor.fromPalette({
		name = "tertiary_palette_key_color",
		palette = function(s)
			return s.tertiaryPalette
		end,
		tone = function(s)
			return s.tertiaryPalette.keyColor:get_tone()
		end,
	})
	MaterialDynamicColors.neutralPaletteKeyColor = DynamicColor.fromPalette({
		name = "neutral_palette_key_color",
		palette = function(s)
			return s.neutralPalette
		end,
		tone = function(s)
			return s.neutralPalette.keyColor:get_tone()
		end,
	})
	MaterialDynamicColors.neutralVariantPaletteKeyColor = DynamicColor.fromPalette({
		name = "neutral_variant_palette_key_color",
		palette = function(s)
			return s.neutralVariantPalette
		end,
		tone = function(s)
			return s.neutralVariantPalette.keyColor:get_tone()
		end,
	})
	MaterialDynamicColors.background = DynamicColor.fromPalette({
		name = "background",
		palette = function(s)
			return s.neutralPalette
		end,
		tone = function(s)
			return if s.isDark then 6 else 98
		end,
		isBackground = true,
	})
	MaterialDynamicColors.onBackground = DynamicColor.fromPalette({
		name = "on_background",
		palette = function(s)
			return s.neutralPalette
		end,
		tone = function(s)
			return if s.isDark then 90 else 10
		end,
		background = function(s)
			return MaterialDynamicColors.background
		end,
		contrastCurve = ContrastCurve.new(3, 3, 4.5, 7),
	})
	MaterialDynamicColors.surface = DynamicColor.fromPalette({
		name = "surface",
		palette = function(s)
			return s.neutralPalette
		end,
		tone = function(s)
			return if s.isDark then 6 else 98
		end,
		isBackground = true,
	})
	MaterialDynamicColors.surfaceDim = DynamicColor.fromPalette({
		name = "surface_dim",
		palette = function(s)
			return s.neutralPalette
		end,
		tone = function(s)
			return if s.isDark then 6 else ContrastCurve.new(87, 87, 80, 75):get(s.contrastLevel)
		end,
		isBackground = true,
	})
	MaterialDynamicColors.surfaceBright = DynamicColor.fromPalette({
		name = "surface_bright",
		palette = function(s)
			return s.neutralPalette
		end,
		tone = function(s)
			return if s.isDark then ContrastCurve.new(24, 24, 29, 34):get(s.contrastLevel) else 98
		end,
		isBackground = true,
	})
	MaterialDynamicColors.surfaceContainerLowest = DynamicColor.fromPalette({
		name = "surface_container_lowest",
		palette = function(s)
			return s.neutralPalette
		end,
		tone = function(s)
			return if s.isDark then ContrastCurve.new(4, 4, 2, 0):get(s.contrastLevel) else 100
		end,
		isBackground = true,
	})
	MaterialDynamicColors.surfaceContainerLow = DynamicColor.fromPalette({
		name = "surface_container_low",
		palette = function(s)
			return s.neutralPalette
		end,
		tone = function(s)
			return if s.isDark then ContrastCurve.new(10, 10, 11, 12):get(s.contrastLevel) else ContrastCurve.new(96, 96, 96, 95):get(s.contrastLevel)
		end,
		isBackground = true,
	})
	MaterialDynamicColors.surfaceContainer = DynamicColor.fromPalette({
		name = "surface_container",
		palette = function(s)
			return s.neutralPalette
		end,
		tone = function(s)
			return if s.isDark then ContrastCurve.new(12, 12, 16, 20):get(s.contrastLevel) else ContrastCurve.new(94, 94, 92, 90):get(s.contrastLevel)
		end,
		isBackground = true,
	})
	MaterialDynamicColors.surfaceContainerHigh = DynamicColor.fromPalette({
		name = "surface_container_high",
		palette = function(s)
			return s.neutralPalette
		end,
		tone = function(s)
			return if s.isDark then ContrastCurve.new(17, 17, 21, 25):get(s.contrastLevel) else ContrastCurve.new(92, 92, 88, 85):get(s.contrastLevel)
		end,
		isBackground = true,
	})
	MaterialDynamicColors.surfaceContainerHighest = DynamicColor.fromPalette({
		name = "surface_container_highest",
		palette = function(s)
			return s.neutralPalette
		end,
		tone = function(s)
			return if s.isDark then ContrastCurve.new(22, 22, 26, 30):get(s.contrastLevel) else ContrastCurve.new(90, 90, 84, 80):get(s.contrastLevel)
		end,
		isBackground = true,
	})
	MaterialDynamicColors.onSurface = DynamicColor.fromPalette({
		name = "on_surface",
		palette = function(s)
			return s.neutralPalette
		end,
		tone = function(s)
			return if s.isDark then 90 else 10
		end,
		background = function(s)
			return MaterialDynamicColors:highestSurface(s)
		end,
		contrastCurve = ContrastCurve.new(4.5, 7, 11, 21),
	})
	MaterialDynamicColors.surfaceVariant = DynamicColor.fromPalette({
		name = "surface_variant",
		palette = function(s)
			return s.neutralVariantPalette
		end,
		tone = function(s)
			return if s.isDark then 30 else 90
		end,
		isBackground = true,
	})
	MaterialDynamicColors.onSurfaceVariant = DynamicColor.fromPalette({
		name = "on_surface_variant",
		palette = function(s)
			return s.neutralVariantPalette
		end,
		tone = function(s)
			return if s.isDark then 80 else 30
		end,
		background = function(s)
			return MaterialDynamicColors:highestSurface(s)
		end,
		contrastCurve = ContrastCurve.new(3, 4.5, 7, 11),
	})
	MaterialDynamicColors.inverseSurface = DynamicColor.fromPalette({
		name = "inverse_surface",
		palette = function(s)
			return s.neutralPalette
		end,
		tone = function(s)
			return if s.isDark then 90 else 20
		end,
	})
	MaterialDynamicColors.inverseOnSurface = DynamicColor.fromPalette({
		name = "inverse_on_surface",
		palette = function(s)
			return s.neutralPalette
		end,
		tone = function(s)
			return if s.isDark then 20 else 95
		end,
		background = function(s)
			return MaterialDynamicColors.inverseSurface
		end,
		contrastCurve = ContrastCurve.new(4.5, 7, 11, 21),
	})
	MaterialDynamicColors.outline = DynamicColor.fromPalette({
		name = "outline",
		palette = function(s)
			return s.neutralVariantPalette
		end,
		tone = function(s)
			return if s.isDark then 60 else 50
		end,
		background = function(s)
			return MaterialDynamicColors:highestSurface(s)
		end,
		contrastCurve = ContrastCurve.new(1.5, 3, 4.5, 7),
	})
	MaterialDynamicColors.outlineVariant = DynamicColor.fromPalette({
		name = "outline_variant",
		palette = function(s)
			return s.neutralVariantPalette
		end,
		tone = function(s)
			return if s.isDark then 30 else 80
		end,
		background = function(s)
			return MaterialDynamicColors:highestSurface(s)
		end,
		contrastCurve = ContrastCurve.new(1, 1, 3, 4.5),
	})
	MaterialDynamicColors.shadow = DynamicColor.fromPalette({
		name = "shadow",
		palette = function(s)
			return s.neutralPalette
		end,
		tone = function(s)
			return 0
		end,
	})
	MaterialDynamicColors.scrim = DynamicColor.fromPalette({
		name = "scrim",
		palette = function(s)
			return s.neutralPalette
		end,
		tone = function(s)
			return 0
		end,
	})
	MaterialDynamicColors.surfaceTint = DynamicColor.fromPalette({
		name = "surface_tint",
		palette = function(s)
			return s.primaryPalette
		end,
		tone = function(s)
			return if s.isDark then 80 else 40
		end,
		isBackground = true,
	})
	MaterialDynamicColors.primary = DynamicColor.fromPalette({
		name = "primary",
		palette = function(s)
			return s.primaryPalette
		end,
		tone = function(s)
			if isMonochrome(s) then
				return if s.isDark then 100 else 0
			end
			return if s.isDark then 80 else 40
		end,
		isBackground = true,
		background = function(s)
			return MaterialDynamicColors:highestSurface(s)
		end,
		contrastCurve = ContrastCurve.new(3, 4.5, 7, 7),
		toneDeltaPair = function(s)
			return ToneDeltaPair.new(MaterialDynamicColors.primaryContainer, MaterialDynamicColors.primary, 10, "nearer", false)
		end,
	})
	MaterialDynamicColors.onPrimary = DynamicColor.fromPalette({
		name = "on_primary",
		palette = function(s)
			return s.primaryPalette
		end,
		tone = function(s)
			if isMonochrome(s) then
				return if s.isDark then 10 else 90
			end
			return if s.isDark then 20 else 100
		end,
		background = function(s)
			return MaterialDynamicColors.primary
		end,
		contrastCurve = ContrastCurve.new(4.5, 7, 11, 21),
	})
	MaterialDynamicColors.primaryContainer = DynamicColor.fromPalette({
		name = "primary_container",
		palette = function(s)
			return s.primaryPalette
		end,
		tone = function(s)
			if isFidelity(s) then
				return s.sourceColorHct:get_tone()
			end
			if isMonochrome(s) then
				return if s.isDark then 85 else 25
			end
			return if s.isDark then 30 else 90
		end,
		isBackground = true,
		background = function(s)
			return MaterialDynamicColors:highestSurface(s)
		end,
		contrastCurve = ContrastCurve.new(1, 1, 3, 4.5),
		toneDeltaPair = function(s)
			return ToneDeltaPair.new(MaterialDynamicColors.primaryContainer, MaterialDynamicColors.primary, 10, "nearer", false)
		end,
	})
	MaterialDynamicColors.onPrimaryContainer = DynamicColor.fromPalette({
		name = "on_primary_container",
		palette = function(s)
			return s.primaryPalette
		end,
		tone = function(s)
			if isFidelity(s) then
				return DynamicColor:foregroundTone(MaterialDynamicColors.primaryContainer.tone(s), 4.5)
			end
			if isMonochrome(s) then
				return if s.isDark then 0 else 100
			end
			return if s.isDark then 90 else 10
		end,
		background = function(s)
			return MaterialDynamicColors.primaryContainer
		end,
		contrastCurve = ContrastCurve.new(4.5, 7, 11, 21),
	})
	MaterialDynamicColors.inversePrimary = DynamicColor.fromPalette({
		name = "inverse_primary",
		palette = function(s)
			return s.primaryPalette
		end,
		tone = function(s)
			return if s.isDark then 40 else 80
		end,
		background = function(s)
			return MaterialDynamicColors.inverseSurface
		end,
		contrastCurve = ContrastCurve.new(3, 4.5, 7, 7),
	})
	MaterialDynamicColors.secondary = DynamicColor.fromPalette({
		name = "secondary",
		palette = function(s)
			return s.secondaryPalette
		end,
		tone = function(s)
			return if s.isDark then 80 else 40
		end,
		isBackground = true,
		background = function(s)
			return MaterialDynamicColors:highestSurface(s)
		end,
		contrastCurve = ContrastCurve.new(3, 4.5, 7, 7),
		toneDeltaPair = function(s)
			return ToneDeltaPair.new(MaterialDynamicColors.secondaryContainer, MaterialDynamicColors.secondary, 10, "nearer", false)
		end,
	})
	MaterialDynamicColors.onSecondary = DynamicColor.fromPalette({
		name = "on_secondary",
		palette = function(s)
			return s.secondaryPalette
		end,
		tone = function(s)
			if isMonochrome(s) then
				return if s.isDark then 10 else 100
			else
				return if s.isDark then 20 else 100
			end
		end,
		background = function(s)
			return MaterialDynamicColors.secondary
		end,
		contrastCurve = ContrastCurve.new(4.5, 7, 11, 21),
	})
	MaterialDynamicColors.secondaryContainer = DynamicColor.fromPalette({
		name = "secondary_container",
		palette = function(s)
			return s.secondaryPalette
		end,
		tone = function(s)
			local initialTone = if s.isDark then 30 else 90
			if isMonochrome(s) then
				return if s.isDark then 30 else 85
			end
			if not isFidelity(s) then
				return initialTone
			end
			return findDesiredChromaByTone(s.secondaryPalette.hue, s.secondaryPalette.chroma, initialTone, if s.isDark then false else true)
		end,
		isBackground = true,
		background = function(s)
			return MaterialDynamicColors:highestSurface(s)
		end,
		contrastCurve = ContrastCurve.new(1, 1, 3, 4.5),
		toneDeltaPair = function(s)
			return ToneDeltaPair.new(MaterialDynamicColors.secondaryContainer, MaterialDynamicColors.secondary, 10, "nearer", false)
		end,
	})
	MaterialDynamicColors.onSecondaryContainer = DynamicColor.fromPalette({
		name = "on_secondary_container",
		palette = function(s)
			return s.secondaryPalette
		end,
		tone = function(s)
			if not isFidelity(s) then
				return if s.isDark then 90 else 10
			end
			return DynamicColor:foregroundTone(MaterialDynamicColors.secondaryContainer.tone(s), 4.5)
		end,
		background = function(s)
			return MaterialDynamicColors.secondaryContainer
		end,
		contrastCurve = ContrastCurve.new(4.5, 7, 11, 21),
	})
	MaterialDynamicColors.tertiary = DynamicColor.fromPalette({
		name = "tertiary",
		palette = function(s)
			return s.tertiaryPalette
		end,
		tone = function(s)
			if isMonochrome(s) then
				return if s.isDark then 90 else 25
			end
			return if s.isDark then 80 else 40
		end,
		isBackground = true,
		background = function(s)
			return MaterialDynamicColors:highestSurface(s)
		end,
		contrastCurve = ContrastCurve.new(3, 4.5, 7, 7),
		toneDeltaPair = function(s)
			return ToneDeltaPair.new(MaterialDynamicColors.tertiaryContainer, MaterialDynamicColors.tertiary, 10, "nearer", false)
		end,
	})
	MaterialDynamicColors.onTertiary = DynamicColor.fromPalette({
		name = "on_tertiary",
		palette = function(s)
			return s.tertiaryPalette
		end,
		tone = function(s)
			if isMonochrome(s) then
				return if s.isDark then 10 else 90
			end
			return if s.isDark then 20 else 100
		end,
		background = function(s)
			return MaterialDynamicColors.tertiary
		end,
		contrastCurve = ContrastCurve.new(4.5, 7, 11, 21),
	})
	MaterialDynamicColors.tertiaryContainer = DynamicColor.fromPalette({
		name = "tertiary_container",
		palette = function(s)
			return s.tertiaryPalette
		end,
		tone = function(s)
			if isMonochrome(s) then
				return if s.isDark then 60 else 49
			end
			if not isFidelity(s) then
				return if s.isDark then 30 else 90
			end
			local proposedHct = s.tertiaryPalette:getHct(s.sourceColorHct:get_tone())
			return DislikeAnalyzer:fixIfDisliked(proposedHct):get_tone()
		end,
		isBackground = true,
		background = function(s)
			return MaterialDynamicColors:highestSurface(s)
		end,
		contrastCurve = ContrastCurve.new(1, 1, 3, 4.5),
		toneDeltaPair = function(s)
			return ToneDeltaPair.new(MaterialDynamicColors.tertiaryContainer, MaterialDynamicColors.tertiary, 10, "nearer", false)
		end,
	})
	MaterialDynamicColors.onTertiaryContainer = DynamicColor.fromPalette({
		name = "on_tertiary_container",
		palette = function(s)
			return s.tertiaryPalette
		end,
		tone = function(s)
			if isMonochrome(s) then
				return if s.isDark then 0 else 100
			end
			if not isFidelity(s) then
				return if s.isDark then 90 else 10
			end
			return DynamicColor:foregroundTone(MaterialDynamicColors.tertiaryContainer.tone(s), 4.5)
		end,
		background = function(s)
			return MaterialDynamicColors.tertiaryContainer
		end,
		contrastCurve = ContrastCurve.new(4.5, 7, 11, 21),
	})
	MaterialDynamicColors.error = DynamicColor.fromPalette({
		name = "error",
		palette = function(s)
			return s.errorPalette
		end,
		tone = function(s)
			return if s.isDark then 80 else 40
		end,
		isBackground = true,
		background = function(s)
			return MaterialDynamicColors:highestSurface(s)
		end,
		contrastCurve = ContrastCurve.new(3, 4.5, 7, 7),
		toneDeltaPair = function(s)
			return ToneDeltaPair.new(MaterialDynamicColors.errorContainer, MaterialDynamicColors.error, 10, "nearer", false)
		end,
	})
	MaterialDynamicColors.onError = DynamicColor.fromPalette({
		name = "on_error",
		palette = function(s)
			return s.errorPalette
		end,
		tone = function(s)
			return if s.isDark then 20 else 100
		end,
		background = function(s)
			return MaterialDynamicColors.error
		end,
		contrastCurve = ContrastCurve.new(4.5, 7, 11, 21),
	})
	MaterialDynamicColors.errorContainer = DynamicColor.fromPalette({
		name = "error_container",
		palette = function(s)
			return s.errorPalette
		end,
		tone = function(s)
			return if s.isDark then 30 else 90
		end,
		isBackground = true,
		background = function(s)
			return MaterialDynamicColors:highestSurface(s)
		end,
		contrastCurve = ContrastCurve.new(1, 1, 3, 4.5),
		toneDeltaPair = function(s)
			return ToneDeltaPair.new(MaterialDynamicColors.errorContainer, MaterialDynamicColors.error, 10, "nearer", false)
		end,
	})
	MaterialDynamicColors.onErrorContainer = DynamicColor.fromPalette({
		name = "on_error_container",
		palette = function(s)
			return s.errorPalette
		end,
		tone = function(s)
			return if s.isDark then 90 else 10
		end,
		background = function(s)
			return MaterialDynamicColors.errorContainer
		end,
		contrastCurve = ContrastCurve.new(4.5, 7, 11, 21),
	})
	MaterialDynamicColors.primaryFixed = DynamicColor.fromPalette({
		name = "primary_fixed",
		palette = function(s)
			return s.primaryPalette
		end,
		tone = function(s)
			return if isMonochrome(s) then 40.0 else 90.0
		end,
		isBackground = true,
		background = function(s)
			return MaterialDynamicColors:highestSurface(s)
		end,
		contrastCurve = ContrastCurve.new(1, 1, 3, 4.5),
		toneDeltaPair = function(s)
			return ToneDeltaPair.new(MaterialDynamicColors.primaryFixed, MaterialDynamicColors.primaryFixedDim, 10, "lighter", true)
		end,
	})
	MaterialDynamicColors.primaryFixedDim = DynamicColor.fromPalette({
		name = "primary_fixed_dim",
		palette = function(s)
			return s.primaryPalette
		end,
		tone = function(s)
			return if isMonochrome(s) then 30.0 else 80.0
		end,
		isBackground = true,
		background = function(s)
			return MaterialDynamicColors:highestSurface(s)
		end,
		contrastCurve = ContrastCurve.new(1, 1, 3, 4.5),
		toneDeltaPair = function(s)
			return ToneDeltaPair.new(MaterialDynamicColors.primaryFixed, MaterialDynamicColors.primaryFixedDim, 10, "lighter", true)
		end,
	})
	MaterialDynamicColors.onPrimaryFixed = DynamicColor.fromPalette({
		name = "on_primary_fixed",
		palette = function(s)
			return s.primaryPalette
		end,
		tone = function(s)
			return if isMonochrome(s) then 100.0 else 10.0
		end,
		background = function(s)
			return MaterialDynamicColors.primaryFixedDim
		end,
		secondBackground = function(s)
			return MaterialDynamicColors.primaryFixed
		end,
		contrastCurve = ContrastCurve.new(4.5, 7, 11, 21),
	})
	MaterialDynamicColors.onPrimaryFixedVariant = DynamicColor.fromPalette({
		name = "on_primary_fixed_variant",
		palette = function(s)
			return s.primaryPalette
		end,
		tone = function(s)
			return if isMonochrome(s) then 90.0 else 30.0
		end,
		background = function(s)
			return MaterialDynamicColors.primaryFixedDim
		end,
		secondBackground = function(s)
			return MaterialDynamicColors.primaryFixed
		end,
		contrastCurve = ContrastCurve.new(3, 4.5, 7, 11),
	})
	MaterialDynamicColors.secondaryFixed = DynamicColor.fromPalette({
		name = "secondary_fixed",
		palette = function(s)
			return s.secondaryPalette
		end,
		tone = function(s)
			return if isMonochrome(s) then 80.0 else 90.0
		end,
		isBackground = true,
		background = function(s)
			return MaterialDynamicColors:highestSurface(s)
		end,
		contrastCurve = ContrastCurve.new(1, 1, 3, 4.5),
		toneDeltaPair = function(s)
			return ToneDeltaPair.new(MaterialDynamicColors.secondaryFixed, MaterialDynamicColors.secondaryFixedDim, 10, "lighter", true)
		end,
	})
	MaterialDynamicColors.secondaryFixedDim = DynamicColor.fromPalette({
		name = "secondary_fixed_dim",
		palette = function(s)
			return s.secondaryPalette
		end,
		tone = function(s)
			return if isMonochrome(s) then 70.0 else 80.0
		end,
		isBackground = true,
		background = function(s)
			return MaterialDynamicColors:highestSurface(s)
		end,
		contrastCurve = ContrastCurve.new(1, 1, 3, 4.5),
		toneDeltaPair = function(s)
			return ToneDeltaPair.new(MaterialDynamicColors.secondaryFixed, MaterialDynamicColors.secondaryFixedDim, 10, "lighter", true)
		end,
	})
	MaterialDynamicColors.onSecondaryFixed = DynamicColor.fromPalette({
		name = "on_secondary_fixed",
		palette = function(s)
			return s.secondaryPalette
		end,
		tone = function(s)
			return 10.0
		end,
		background = function(s)
			return MaterialDynamicColors.secondaryFixedDim
		end,
		secondBackground = function(s)
			return MaterialDynamicColors.secondaryFixed
		end,
		contrastCurve = ContrastCurve.new(4.5, 7, 11, 21),
	})
	MaterialDynamicColors.onSecondaryFixedVariant = DynamicColor.fromPalette({
		name = "on_secondary_fixed_variant",
		palette = function(s)
			return s.secondaryPalette
		end,
		tone = function(s)
			return if isMonochrome(s) then 25.0 else 30.0
		end,
		background = function(s)
			return MaterialDynamicColors.secondaryFixedDim
		end,
		secondBackground = function(s)
			return MaterialDynamicColors.secondaryFixed
		end,
		contrastCurve = ContrastCurve.new(3, 4.5, 7, 11),
	})
	MaterialDynamicColors.tertiaryFixed = DynamicColor.fromPalette({
		name = "tertiary_fixed",
		palette = function(s)
			return s.tertiaryPalette
		end,
		tone = function(s)
			return if isMonochrome(s) then 40.0 else 90.0
		end,
		isBackground = true,
		background = function(s)
			return MaterialDynamicColors:highestSurface(s)
		end,
		contrastCurve = ContrastCurve.new(1, 1, 3, 4.5),
		toneDeltaPair = function(s)
			return ToneDeltaPair.new(MaterialDynamicColors.tertiaryFixed, MaterialDynamicColors.tertiaryFixedDim, 10, "lighter", true)
		end,
	})
	MaterialDynamicColors.tertiaryFixedDim = DynamicColor.fromPalette({
		name = "tertiary_fixed_dim",
		palette = function(s)
			return s.tertiaryPalette
		end,
		tone = function(s)
			return if isMonochrome(s) then 30.0 else 80.0
		end,
		isBackground = true,
		background = function(s)
			return MaterialDynamicColors:highestSurface(s)
		end,
		contrastCurve = ContrastCurve.new(1, 1, 3, 4.5),
		toneDeltaPair = function(s)
			return ToneDeltaPair.new(MaterialDynamicColors.tertiaryFixed, MaterialDynamicColors.tertiaryFixedDim, 10, "lighter", true)
		end,
	})
	MaterialDynamicColors.onTertiaryFixed = DynamicColor.fromPalette({
		name = "on_tertiary_fixed",
		palette = function(s)
			return s.tertiaryPalette
		end,
		tone = function(s)
			return if isMonochrome(s) then 100.0 else 10.0
		end,
		background = function(s)
			return MaterialDynamicColors.tertiaryFixedDim
		end,
		secondBackground = function(s)
			return MaterialDynamicColors.tertiaryFixed
		end,
		contrastCurve = ContrastCurve.new(4.5, 7, 11, 21),
	})
	MaterialDynamicColors.onTertiaryFixedVariant = DynamicColor.fromPalette({
		name = "on_tertiary_fixed_variant",
		palette = function(s)
			return s.tertiaryPalette
		end,
		tone = function(s)
			return if isMonochrome(s) then 90.0 else 30.0
		end,
		background = function(s)
			return MaterialDynamicColors.tertiaryFixedDim
		end,
		secondBackground = function(s)
			return MaterialDynamicColors.tertiaryFixed
		end,
		contrastCurve = ContrastCurve.new(3, 4.5, 7, 11),
	})
end
return {
	MaterialDynamicColors = MaterialDynamicColors,
}
