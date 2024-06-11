-- Compiled with roblox-ts v2.3.0
local TS = _G[script]
--[[
	*
	 * @license
	 * Copyright 2021 Google LLC
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
local Hct = require(script.Parent.Parent:WaitForChild("hct"):WaitForChild("hct"))
--[[
	*
	 *  A convenience class for retrieving colors that are constant in hue and
	 *  chroma, but vary in tone.
	 
]]
type Hct = Hct.Hct

type SpecialKeyColor = {
	__index : SpecialKeyColor,
	new : (hue : number, requestedChroma : number) -> SpecialKeyColor,
	constructor : (SpecialKeyColor, hue : number, requestedChroma : number) -> (),
	
	create : (self : SpecialKeyColor) -> Hct,
	maxChroma : (self : SpecialKeyColor, tone : number) -> number
}

export type TonalPalette = {
	__index : TonalPalette,

	hue : number,
	chroma : number,
	keyColor : Hct,
	cache : {number},

	createKeyColor : (hue : number, requestedChroma : number) -> SpecialKeyColor,
	new : (hue : number, chroma : number, keyColor : Hct) -> TonalPalette,
	constructor : (self : TonalPalette, hue : number, chroma : number, keyColor : Hct) -> (),

	fromInt : (argb : number) -> TonalPalette,
	fromHct : (hct : Hct) -> TonalPalette,
	fromHueAndChroma : (hue : number, chroma : number) -> TonalPalette,
	tone : (self : TonalPalette, tone : number) -> number,
	getHct : (self : TonalPalette) -> Hct,
}
local KeyColor
local TonalPalette : any
do
	TonalPalette = setmetatable({}, {
		__tostring = function()
			return "TonalPalette"
		end,
	})
	function TonalPalette.createKeyColor(hue, requestedChroma)
		return KeyColor.new(hue, requestedChroma)
	end

	TonalPalette.__index = TonalPalette
	function TonalPalette.new(...)
		local self = setmetatable({}, TonalPalette)
		return self:constructor(...) or self
	end
	function TonalPalette:constructor(hue, chroma, keyColor)
		self.hue = hue
		self.chroma = chroma
		self.keyColor = keyColor
		self.cache = {}
	end
	function TonalPalette.fromInt(argb)
		local hct = Hct.Hct:fromInt(argb)
		return TonalPalette:fromHct(hct)
	end
	function TonalPalette.fromHct(hct)
		return TonalPalette.new(hct:get_hue(), hct:get_chroma(), hct)
	end
	function TonalPalette.fromHueAndChroma(hue : number, chroma: number)
		local keyColor = KeyColor.new(hue, chroma):create()
		return TonalPalette.new(hue, chroma, keyColor)
	end
	function TonalPalette:tone(tone)
		local _cache = self.cache
		local _tone = tone
		local argb = _cache[_tone]
		if argb == nil then
			argb = Hct.Hct:from(self.hue, self.chroma, tone):toInt()
			local _cache_1 = self.cache
			local _tone_1 = tone
			local _argb = argb
			_cache_1[_tone_1] = _argb
		end
		return argb
	end
	function TonalPalette:getHct(tone)
		return Hct.Hct:fromInt(self:tone(tone))
	end
end
--[[
	*
	 * Key color is a color that represents the hue and chroma of a tonal palette
	 
]]
do
	KeyColor = setmetatable({}, {
		__tostring = function()
			return "KeyColor"
		end,
	})
	KeyColor.__index = KeyColor
	function KeyColor.new(...)
		local self = setmetatable({}, KeyColor)
		return self:constructor(...) or self
	end
	function KeyColor:constructor(hue : number, requestedChroma : number)
		assert(type(hue) == "number" and type(requestedChroma) == "number", "Hue or chroma must be nambee nakrab!")
		self.hue = hue
		self.requestedChroma = requestedChroma
		self.chromaCache = {}
		self.maxChromaValue = 200.0
	end
	function KeyColor:create()
		-- Pivot around T50 because T50 has the most chroma available, on
		-- average. Thus it is most likely to have a direct answer.
		local pivotTone = 50
		local toneStepSize = 1
		-- Epsilon to accept values slightly higher than the requested chroma.
		local epsilon = 0.01
		-- Binary search to find the tone that can provide a chroma that is closest
		-- to the requested chroma.
		local lowerTone = 0
		local upperTone = 100
		while lowerTone < upperTone do
			local midTone = math.floor((lowerTone + upperTone) / 2)
			local isAscending = self:maxChroma(midTone) < self:maxChroma(midTone + toneStepSize)
			local sufficientChroma = self:maxChroma(midTone) >= self.requestedChroma - epsilon
			if sufficientChroma then
				-- Either range [lowerTone, midTone] or [midTone, upperTone] has
				-- the answer, so search in the range that is closer the pivot tone.
				if math.abs(lowerTone - pivotTone) < math.abs(upperTone - pivotTone) then
					upperTone = midTone
				else
					if lowerTone == midTone then
						return Hct.Hct:from(self.hue, self.requestedChroma, lowerTone)
					end
					lowerTone = midTone
				end
			else
				-- As there is no sufficient chroma in the midTone, follow the direction
				-- to the chroma peak.
				if isAscending then
					lowerTone = midTone + toneStepSize
				else
					-- Keep midTone for potential chroma peak.
					upperTone = midTone
				end
			end
		end
		return Hct.Hct:from(self.hue, self.requestedChroma, lowerTone)
	end
	function KeyColor:maxChroma(tone)
		local _chromaCache = self.chromaCache
		local _tone = tone
		if _chromaCache[_tone] ~= nil then
			local _chromaCache_1 = self.chromaCache
			local _tone_1 = tone
			return _chromaCache_1[_tone_1]
		end
		local chroma = Hct.Hct:from(self.hue, self.maxChromaValue, tone):get_chroma()
		local _chromaCache_1 = self.chromaCache
		local _tone_1 = tone
		_chromaCache_1[_tone_1] = chroma
		return chroma
	end
end
return {
	TonalPalette = TonalPalette :: TonalPalette,
}
