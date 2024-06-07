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
-- material_color_utilities is designed to have a consistent API across
-- platforms and modular components that can be moved around easily. Using a
-- class as a namespace facilitates this.
--
-- tslint:disable:class-as-namespace
local utils = TS.import(script, script.Parent.Parent, "utils", "color_utils")
local mathUtils = TS.import(script, script.Parent.Parent, "utils", "math_utils")
--[[
	*
	 * Utility methods for calculating contrast given two colors, or calculating a
	 * color given one color and a contrast ratio.
	 *
	 * Contrast ratio is calculated using XYZ's Y. When linearized to match human
	 * perception, Y becomes HCT's tone and L*a*b*'s' L*. Informally, this is the
	 * lightness of a color.
	 *
	 * Methods refer to tone, T in the the HCT color space.
	 * Tone is equivalent to L* in the L*a*b* color space, or L in the LCH color
	 * space.
	 
]]
local Contrast
do
	Contrast = setmetatable({}, {
		__tostring = function()
			return "Contrast"
		end,
	})
	Contrast.__index = Contrast
	function Contrast.new(...)
		local self = setmetatable({}, Contrast)
		return self:constructor(...) or self
	end
	function Contrast:constructor()
	end
	function Contrast:ratioOfTones(toneA, toneB)
		toneA = mathUtils.clampDouble(0.0, 100.0, toneA)
		toneB = mathUtils.clampDouble(0.0, 100.0, toneB)
		return Contrast:ratioOfYs(utils.yFromLstar(toneA), utils.yFromLstar(toneB))
	end
	function Contrast:ratioOfYs(y1, y2)
		local lighter = if y1 > y2 then y1 else y2
		local darker = if (lighter == y2) then y1 else y2
		return (lighter + 5.0) / (darker + 5.0)
	end
	function Contrast:lighter(tone, ratio)
		if tone < 0.0 or tone > 100.0 then
			return -1.0
		end
		local darkY = utils.yFromLstar(tone)
		local lightY = ratio * (darkY + 5.0) - 5.0
		local realContrast = Contrast:ratioOfYs(lightY, darkY)
		local delta = math.abs(realContrast - ratio)
		if realContrast < ratio and delta > 0.04 then
			return -1
		end
		-- Ensure gamut mapping, which requires a 'range' on tone, will still result
		-- the correct ratio by darkening slightly.
		local returnValue = utils.lstarFromY(lightY) + 0.4
		if returnValue < 0 or returnValue > 100 then
			return -1
		end
		return returnValue
	end
	function Contrast:darker(tone, ratio)
		if tone < 0.0 or tone > 100.0 then
			return -1.0
		end
		local lightY = utils.yFromLstar(tone)
		local darkY = ((lightY + 5.0) / ratio) - 5.0
		local realContrast = Contrast:ratioOfYs(lightY, darkY)
		local delta = math.abs(realContrast - ratio)
		if realContrast < ratio and delta > 0.04 then
			return -1
		end
		-- Ensure gamut mapping, which requires a 'range' on tone, will still result
		-- the correct ratio by darkening slightly.
		local returnValue = utils.lstarFromY(darkY) - 0.4
		if returnValue < 0 or returnValue > 100 then
			return -1
		end
		return returnValue
	end
	function Contrast:lighterUnsafe(tone, ratio)
		local lighterSafe = Contrast:lighter(tone, ratio)
		return if (lighterSafe < 0.0) then 100.0 else lighterSafe
	end
	function Contrast:darkerUnsafe(tone, ratio)
		local darkerSafe = Contrast:darker(tone, ratio)
		return if (darkerSafe < 0.0) then 0.0 else darkerSafe
	end
end
return {
	Contrast = Contrast,
}
