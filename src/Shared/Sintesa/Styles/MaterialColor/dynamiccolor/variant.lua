-- Compiled with roblox-ts v2.3.0
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
--[[
	*
	 * Set of themes supported by Dynamic Color.
	 * Instantiate the corresponding subclass, ex. SchemeTonalSpot, to create
	 * colors corresponding to the theme.
	 
]]
local Variant
do
	local _inverse = {}
	Variant = setmetatable({}, {
		__index = _inverse,
	})
	Variant.MONOCHROME = 0
	_inverse[0] = "MONOCHROME"
	Variant.NEUTRAL = 1
	_inverse[1] = "NEUTRAL"
	Variant.TONAL_SPOT = 2
	_inverse[2] = "TONAL_SPOT"
	Variant.VIBRANT = 3
	_inverse[3] = "VIBRANT"
	Variant.EXPRESSIVE = 4
	_inverse[4] = "EXPRESSIVE"
	Variant.FIDELITY = 5
	_inverse[5] = "FIDELITY"
	Variant.CONTENT = 6
	_inverse[6] = "CONTENT"
	Variant.RAINBOW = 7
	_inverse[7] = "RAINBOW"
	Variant.FRUIT_SALAD = 8
	_inverse[8] = "FRUIT_SALAD"
end
return {
	Variant = Variant,
}
