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
local mathUtils = require(script.Parent.Parent:WaitForChild("utils"):WaitForChild("math_utils"))
--[[
	*
	 * A class containing a value that changes with the contrast level.
	 *
	 * Usually represents the contrast requirements for a dynamic color on its
	 * background. The four values correspond to values for contrast levels -1.0,
	 * 0.0, 0.5, and 1.0, respectively.
	 
]]
local ContrastCurve
do
	ContrastCurve = setmetatable({}, {
		__tostring = function()
			return "ContrastCurve"
		end,
	})
	ContrastCurve.__index = ContrastCurve
	function ContrastCurve.new(...)
		local self = setmetatable({}, ContrastCurve)
		return self:constructor(...) or self
	end
	function ContrastCurve:constructor(low, normal, medium, high)
		self.low = low
		self.normal = normal
		self.medium = medium
		self.high = high
	end
	function ContrastCurve:get(contrastLevel)
		if contrastLevel <= -1.0 then
			return self.low
		elseif contrastLevel < 0.0 then
			return mathUtils.lerp(self.low, self.normal, (contrastLevel - (-1)) / 1)
		elseif contrastLevel < 0.5 then
			return mathUtils.lerp(self.normal, self.medium, (contrastLevel - 0) / 0.5)
		elseif contrastLevel < 1.0 then
			return mathUtils.lerp(self.medium, self.high, (contrastLevel - 0.5) / 0.5)
		else
			return self.high
		end
	end
end
return {
	ContrastCurve = ContrastCurve,
}
