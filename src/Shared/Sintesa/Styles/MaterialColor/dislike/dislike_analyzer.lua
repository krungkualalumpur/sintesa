-- Compiled with roblox-ts v2.3.0
local TS = _G[script]
--[[
	*
	 * @license
	 * Copyright 2023 Google LLC
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
local Hct = TS.import(script, script.Parent.Parent, "hct", "hct").Hct
-- material_color_utilities is designed to have a consistent API across
-- platforms and modular components that can be moved around easily. Using a
-- class as a namespace facilitates this.
--
-- tslint:disable:class-as-namespace
--[[
	*
	 * Check and/or fix universally disliked colors.
	 * Color science studies of color preference indicate universal distaste for
	 * dark yellow-greens, and also show this is correlated to distate for
	 * biological waste and rotting food.
	 *
	 * See Palmer and Schloss, 2010 or Schloss and Palmer's Chapter 21 in Handbook
	 * of Color Psychology (2015).
	 
]]
local DislikeAnalyzer
do
	DislikeAnalyzer = setmetatable({}, {
		__tostring = function()
			return "DislikeAnalyzer"
		end,
	})
	DislikeAnalyzer.__index = DislikeAnalyzer
	function DislikeAnalyzer.new(...)
		local self = setmetatable({}, DislikeAnalyzer)
		return self:constructor(...) or self
	end
	function DislikeAnalyzer:constructor()
	end
	function DislikeAnalyzer:isDisliked(hct)
		local huePasses = math.round(hct:get_hue()) >= 90.0 and math.round(hct:get_hue()) <= 111.0
		local chromaPasses = math.round(hct:get_chroma()) > 16.0
		local tonePasses = math.round(hct:get_tone()) < 65.0
		return huePasses and chromaPasses and tonePasses
	end
	function DislikeAnalyzer:fixIfDisliked(hct)
		if DislikeAnalyzer:isDisliked(hct) then
			return Hct:from(hct:get_hue(), hct:get_chroma(), 70.0)
		end
		return hct
	end
end
return {
	DislikeAnalyzer = DislikeAnalyzer,
}
