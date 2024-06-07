-- Compiled with roblox-ts v2.3.0
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
--[[
	*
	 * Describes the different in tone between colors.
	 
]]
--[[
	*
	 * Documents a constraint between two DynamicColors, in which their tones must
	 * have a certain distance from each other.
	 *
	 * Prefer a DynamicColor with a background, this is for special cases when
	 * designers want tonal distance, literally contrast, between two colors that
	 * don't have a background / foreground relationship or a contrast guarantee.
	 
]]
local ToneDeltaPair
do
	ToneDeltaPair = setmetatable({}, {
		__tostring = function()
			return "ToneDeltaPair"
		end,
	})
	ToneDeltaPair.__index = ToneDeltaPair
	function ToneDeltaPair.new(...)
		local self = setmetatable({}, ToneDeltaPair)
		return self:constructor(...) or self
	end
	function ToneDeltaPair:constructor(roleA, roleB, delta, polarity, stayTogether)
		self.roleA = roleA
		self.roleB = roleB
		self.delta = delta
		self.polarity = polarity
		self.stayTogether = stayTogether
	end
end
return {
	ToneDeltaPair = ToneDeltaPair,
}
