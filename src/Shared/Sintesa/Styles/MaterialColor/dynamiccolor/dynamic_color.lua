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
local Contrast = require(script.Parent.Parent:WaitForChild("contrast"):WaitForChild("contrast")).Contrast
local mathUtils = require(script.Parent.Parent:WaitForChild("utils"):WaitForChild("math_utils"))
--[[
	*
	 * @param name The name of the dynamic color. Defaults to empty.
	 * @param palette Function that provides a TonalPalette given
	 * DynamicScheme. A TonalPalette is defined by a hue and chroma, so this
	 * replaces the need to specify hue/chroma. By providing a tonal palette, when
	 * contrast adjustments are made, intended chroma can be preserved.
	 * @param tone Function that provides a tone given DynamicScheme.
	 * @param isBackground Whether this dynamic color is a background, with
	 * some other color as the foreground. Defaults to false.
	 * @param background The background of the dynamic color (as a function of a
	 *     `DynamicScheme`), if it exists.
	 * @param secondBackground A second background of the dynamic color (as a
	 *     function of a `DynamicScheme`), if it
	 * exists.
	 * @param contrastCurve A `ContrastCurve` object specifying how its contrast
	 * against its background should behave in various contrast levels options.
	 * @param toneDeltaPair A `ToneDeltaPair` object specifying a tone delta
	 * constraint between two colors. One of them must be the color being
	 * constructed.
	 
]]
--[[
	*
	 * A color that adjusts itself based on UI state provided by DynamicScheme.
	 *
	 * Colors without backgrounds do not change tone when contrast changes. Colors
	 * with backgrounds become closer to their background as contrast lowers, and
	 * further when contrast increases.
	 *
	 * Prefer static constructors. They require either a hexcode, a palette and
	 * tone, or a hue and chroma. Optionally, they can provide a background
	 * DynamicColor.
	 
]]
local DynamicColor
do
	DynamicColor = setmetatable({}, {
		__tostring = function()
			return "DynamicColor"
		end,
	})
	DynamicColor.__index = DynamicColor
	function DynamicColor.new(...)
		local self = setmetatable({}, DynamicColor)
		return self:constructor(...) or self
	end
	function DynamicColor:constructor(name, palette, tone, isBackground, background, secondBackground, contrastCurve, toneDeltaPair)
		self.name = name
		self.palette = palette
		self.tone = tone
		self.isBackground = isBackground
		self.background = background
		self.secondBackground = secondBackground
		self.contrastCurve = contrastCurve
		self.toneDeltaPair = toneDeltaPair
		self.hctCache = {}
		if (not background) and secondBackground then
			error(`Color {name} has secondBackground` .. `defined, but background is not defined.`)
		end
		if (not background) and contrastCurve then
			error(`Color {name} has contrastCurve` .. `defined, but background is not defined.`)
		end
		if background and not contrastCurve then
			error(`Color {name} has background` .. `defined, but contrastCurve is not defined.`)
		end
	end
	function DynamicColor:fromPalette(args)
		local _condition = args.name
		if _condition == nil then
			_condition = ""
		end
		local _exp = args.palette
		local _exp_1 = args.tone
		local _condition_1 = args.isBackground
		if _condition_1 == nil then
			_condition_1 = false
		end
		return DynamicColor.new(_condition, _exp, _exp_1, _condition_1, args.background, args.secondBackground, args.contrastCurve, args.toneDeltaPair)
	end
	function DynamicColor:getArgb(scheme)
		return self:getHct(scheme):toInt()
	end
	function DynamicColor:getHct(scheme)
		local _hctCache = self.hctCache
		local _scheme = scheme
		local cachedAnswer = _hctCache[_scheme]
		if cachedAnswer ~= nil then
			return cachedAnswer
		end
		local tone = self:getTone(scheme)
		local answer = self.palette(scheme):getHct(tone)
		-- ▼ ReadonlyMap.size ▼
		local _size = 0
		for _ in self.hctCache do
			_size += 1
		end
		-- ▲ ReadonlyMap.size ▲
		if _size > 4 then
			table.clear(self.hctCache)
		end
		local _hctCache_1 = self.hctCache
		local _scheme_1 = scheme
		_hctCache_1[_scheme_1] = answer
		return answer
	end
	function DynamicColor:getTone(scheme)
		local decreasingContrast = scheme.contrastLevel < 0
		-- Case 1: dual foreground, pair of colors with delta constraint.
		if self.toneDeltaPair then
			local toneDeltaPair = self.toneDeltaPair(scheme)
			local roleA = toneDeltaPair.roleA
			local roleB = toneDeltaPair.roleB
			local delta = toneDeltaPair.delta
			local polarity = toneDeltaPair.polarity
			local stayTogether = toneDeltaPair.stayTogether
			local bg = self.background(scheme)
			local bgTone = bg:getTone(scheme)
			local aIsNearer = (polarity == "nearer" or (polarity == "lighter" and not scheme.isDark) or (polarity == "darker" and scheme.isDark))
			local nearer = if aIsNearer then roleA else roleB
			local farther = if aIsNearer then roleB else roleA
			local amNearer = self.name == nearer.name
			local expansionDir = if scheme.isDark then 1 else -1
			-- 1st round: solve to min, each
			local nContrast = nearer.contrastCurve:get(scheme.contrastLevel)
			local fContrast = farther.contrastCurve:get(scheme.contrastLevel)
			-- If a color is good enough, it is not adjusted.
			-- Initial and adjusted tones for `nearer`
			local nInitialTone = nearer.tone(scheme)
			local nTone = if Contrast:ratioOfTones(bgTone, nInitialTone) >= nContrast then nInitialTone else DynamicColor:foregroundTone(bgTone, nContrast)
			-- Initial and adjusted tones for `farther`
			local fInitialTone = farther.tone(scheme)
			local fTone = if Contrast:ratioOfTones(bgTone, fInitialTone) >= fContrast then fInitialTone else DynamicColor:foregroundTone(bgTone, fContrast)
			if decreasingContrast then
				-- If decreasing contrast, adjust color to the "bare minimum"
				-- that satisfies contrast.
				nTone = DynamicColor:foregroundTone(bgTone, nContrast)
				fTone = DynamicColor:foregroundTone(bgTone, fContrast)
			end
			if (fTone - nTone) * expansionDir >= delta then
				-- Good! Tones satisfy the constraint; no change needed.
			else
				-- 2nd round: expand farther to match delta.
				fTone = mathUtils.clampDouble(0, 100, nTone + delta * expansionDir)
				if (fTone - nTone) * expansionDir >= delta then
					-- Good! Tones now satisfy the constraint; no change needed.
				else
					-- 3rd round: contract nearer to match delta.
					nTone = mathUtils.clampDouble(0, 100, fTone - delta * expansionDir)
				end
			end
			-- Avoids the 50-59 awkward zone.
			if 50 <= nTone and nTone < 60 then
				-- If `nearer` is in the awkward zone, move it away, together with
				-- `farther`.
				if expansionDir > 0 then
					nTone = 60
					fTone = math.max(fTone, nTone + delta * expansionDir)
				else
					nTone = 49
					fTone = math.min(fTone, nTone + delta * expansionDir)
				end
			elseif 50 <= fTone and fTone < 60 then
				if stayTogether then
					-- Fixes both, to avoid two colors on opposite sides of the "awkward
					-- zone".
					if expansionDir > 0 then
						nTone = 60
						fTone = math.max(fTone, nTone + delta * expansionDir)
					else
						nTone = 49
						fTone = math.min(fTone, nTone + delta * expansionDir)
					end
				else
					-- Not required to stay together; fixes just one.
					if expansionDir > 0 then
						fTone = 60
					else
						fTone = 49
					end
				end
			end
			-- Returns `nTone` if this color is `nearer`, otherwise `fTone`.
			return if amNearer then nTone else fTone
		else
			-- Case 2: No contrast pair; just solve for itself.
			local answer = self.tone(scheme)
			if self.background == nil then
				return answer
			end
			local bgTone = self.background(scheme):getTone(scheme)
			local desiredRatio = self.contrastCurve:get(scheme.contrastLevel)
			if Contrast:ratioOfTones(bgTone, answer) >= desiredRatio then
				-- Don't "improve" what's good enough.
			else
				-- Rough improvement.
				answer = DynamicColor:foregroundTone(bgTone, desiredRatio)
			end
			if decreasingContrast then
				answer = DynamicColor:foregroundTone(bgTone, desiredRatio)
			end
			if self.isBackground and 50 <= answer and answer < 60 then
				-- Must adjust
				if Contrast:ratioOfTones(49, bgTone) >= desiredRatio then
					answer = 49
				else
					answer = 60
				end
			end
			if self.secondBackground then
				-- Case 3: Adjust for dual backgrounds.
				local bg1, bg2 = self.background, self.secondBackground
				local bgTone1, bgTone2 = bg1(scheme):getTone(scheme), bg2(scheme):getTone(scheme)
				local upper, lower = math.max(bgTone1, bgTone2), math.min(bgTone1, bgTone2)
				if Contrast:ratioOfTones(upper, answer) >= desiredRatio and Contrast:ratioOfTones(lower, answer) >= desiredRatio then
					return answer
				end
				-- The darkest light tone that satisfies the desired ratio,
				-- or -1 if such ratio cannot be reached.
				local lightOption = Contrast:lighter(upper, desiredRatio)
				-- The lightest dark tone that satisfies the desired ratio,
				-- or -1 if such ratio cannot be reached.
				local darkOption = Contrast:darker(lower, desiredRatio)
				-- Tones suitable for the foreground.
				local availables = {}
				if lightOption ~= -1 then
					table.insert(availables, lightOption)
				end
				if darkOption ~= -1 then
					table.insert(availables, darkOption)
				end
				local prefersLight = DynamicColor:tonePrefersLightForeground(bgTone1) or DynamicColor:tonePrefersLightForeground(bgTone2)
				if prefersLight then
					return if (lightOption < 0) then 100 else lightOption
				end
				if #availables == 1 then
					return availables[1]
				end
				return if (darkOption < 0) then 0 else darkOption
			end
			return answer
		end
	end
	function DynamicColor:foregroundTone(bgTone, ratio)
		local lighterTone = Contrast:lighterUnsafe(bgTone, ratio)
		local darkerTone = Contrast:darkerUnsafe(bgTone, ratio)
		local lighterRatio = Contrast:ratioOfTones(lighterTone, bgTone)
		local darkerRatio = Contrast:ratioOfTones(darkerTone, bgTone)
		local preferLighter = DynamicColor:tonePrefersLightForeground(bgTone)
		if preferLighter then
			-- This handles an edge case where the initial contrast ratio is high
			-- (ex. 13.0), and the ratio passed to the function is that high
			-- ratio, and both the lighter and darker ratio fails to pass that
			-- ratio.
			--
			-- This was observed with Tonal Spot's On Primary Container turning
			-- black momentarily between high and max contrast in light mode. PC's
			-- standard tone was T90, OPC's was T10, it was light mode, and the
			-- contrast value was 0.6568521221032331.
			local negligibleDifference = math.abs(lighterRatio - darkerRatio) < 0.1 and lighterRatio < ratio and darkerRatio < ratio
			return if lighterRatio >= ratio or lighterRatio >= darkerRatio or negligibleDifference then lighterTone else darkerTone
		else
			return if darkerRatio >= ratio or darkerRatio >= lighterRatio then darkerTone else lighterTone
		end
	end
	function DynamicColor:tonePrefersLightForeground(tone)
		return math.round(tone) < 60.0
	end
	function DynamicColor:toneAllowsLightForeground(tone)
		return math.round(tone) <= 49.0
	end
	function DynamicColor:enableLightForeground(tone)
		if DynamicColor:tonePrefersLightForeground(tone) and not DynamicColor:toneAllowsLightForeground(tone) then
			return 49.0
		end
		return tone
	end
end
return {
	DynamicColor = DynamicColor,
}
