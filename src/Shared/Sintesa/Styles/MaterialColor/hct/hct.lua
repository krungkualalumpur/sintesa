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
--[[
	*
	 * A color system built using CAM16 hue and chroma, and L* from
	 * L*a*b*.
	 *
	 * Using L* creates a link between the color system, contrast, and thus
	 * accessibility. Contrast ratio depends on relative luminance, or Y in the XYZ
	 * color space. L*, or perceptual luminance can be calculated from Y.
	 *
	 * Unlike Y, L* is linear to human perception, allowing trivial creation of
	 * accurate color tones.
	 *
	 * Unlike contrast ratio, measuring contrast in L* is linear, and simple to
	 * calculate. A difference of 40 in HCT tone guarantees a contrast ratio >= 3.0,
	 * and a difference of 50 guarantees a contrast ratio >= 4.5.
	 
]]
local utils = require(script.Parent.Parent:WaitForChild("utils"):WaitForChild("color_utils"))
local Cam16 = require(script.Parent:WaitForChild("cam16")).Cam16
local HctSolver = require(script.Parent:WaitForChild("hct_solver")).HctSolver
local ViewingConditions = require(script.Parent:WaitForChild("viewing_conditions")).ViewingConditions
--[[
	*
	 * HCT, hue, chroma, and tone. A color system that provides a perceptually
	 * accurate color measurement system that can also accurately render what colors
	 * will appear as in different lighting environments.
	 
]]
local Hct
do
	Hct = setmetatable({}, {
		__tostring = function()
			return "Hct"
		end,
	})
	Hct.__index = Hct
	function Hct.new(...)
		local self = setmetatable({}, Hct)
		return self:constructor(...) or self
	end
	function Hct:constructor(argb)
		self.argb = argb
		local cam = Cam16:fromInt(argb)
		self.internalHue = cam.hue
		self.internalChroma = cam.chroma
		self.internalTone = utils.lstarFromArgb(argb)
		self.argb = argb
	end
	function Hct:from(hue, chroma, tone)
		return Hct.new(HctSolver:solveToInt(hue, chroma, tone))
	end
	function Hct:fromInt(argb)
		return Hct.new(argb)
	end
	function Hct:toInt()
		return self.argb
	end
	function Hct:get_hue()
		return self.internalHue
	end
	function Hct:set_hue(newHue)
		self:setInternalState(HctSolver:solveToInt(newHue, self.internalChroma, self.internalTone))
	end
	function Hct:get_chroma()
		return self.internalChroma
	end
	function Hct:set_chroma(newChroma)
		self:setInternalState(HctSolver:solveToInt(self.internalHue, newChroma, self.internalTone))
	end
	function Hct:get_tone()
		return self.internalTone
	end
	function Hct:set_tone(newTone)
		self:setInternalState(HctSolver:solveToInt(self.internalHue, self.internalChroma, newTone))
	end
	function Hct:setInternalState(argb)
		local cam = Cam16:fromInt(argb)
		self.internalHue = cam.hue
		self.internalChroma = cam.chroma
		self.internalTone = utils.lstarFromArgb(argb)
		self.argb = argb
	end
	function Hct:inViewingConditions(vc)
		-- 1. Use CAM16 to find XYZ coordinates of color in specified VC.
		local cam = Cam16:fromInt(self:toInt())
		local viewedInVc = cam:xyzInViewingConditions(vc)
		-- 2. Create CAM16 of those XYZ coordinates in default VC.
		local recastInVc = Cam16:fromXyzInViewingConditions(viewedInVc[1], viewedInVc[2], viewedInVc[3], ViewingConditions:make())
		-- 3. Create HCT from:
		-- - CAM16 using default VC with XYZ coordinates in specified VC.
		-- - L* converted from Y in XYZ coordinates in specified VC.
		local recastHct = Hct:from(recastInVc.hue, recastInVc.chroma, utils.lstarFromY(viewedInVc[2]))
		return recastHct
	end
end
return {
	Hct = Hct,
}
