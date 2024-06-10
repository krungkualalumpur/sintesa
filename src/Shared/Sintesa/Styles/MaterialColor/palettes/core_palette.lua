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
local Hct = require(script.Parent.Parent:WaitForChild("hct"):WaitForChild("hct")).Hct
local TonalPalette = require(script.Parent:WaitForChild("tonal_palette")).TonalPalette
--[[
	*
	 * Set of colors to generate a [CorePalette] from
	 
]]
--[[
	*
	 * An intermediate concept between the key color for a UI theme, and a full
	 * color scheme. 5 sets of tones are generated, all except one use the same hue
	 * as the key color, and all vary in chroma.
	 
]]
local CorePalette
do
	CorePalette = setmetatable({}, {
		__tostring = function()
			return "CorePalette"
		end,
	})
	CorePalette.__index = CorePalette
	function CorePalette.new(...)
		local self = setmetatable({}, CorePalette)
		return self:constructor(...) or self
	end
	function CorePalette:constructor(argb, isContent)
		local hct = Hct:fromInt(argb)
		local hue = hct:get_hue()
		local chroma = hct:get_chroma()
		if isContent then
			self.a1 = TonalPalette:fromHueAndChroma(hue, chroma)
			self.a2 = TonalPalette:fromHueAndChroma(hue, chroma / 3)
			self.a3 = TonalPalette:fromHueAndChroma(hue + 60, chroma / 2)
			self.n1 = TonalPalette:fromHueAndChroma(hue, math.min(chroma / 12, 4))
			self.n2 = TonalPalette:fromHueAndChroma(hue, math.min(chroma / 6, 8))
		else
			self.a1 = TonalPalette:fromHueAndChroma(hue, math.max(48, chroma))
			self.a2 = TonalPalette:fromHueAndChroma(hue, 16)
			self.a3 = TonalPalette:fromHueAndChroma(hue + 60, 24)
			self.n1 = TonalPalette:fromHueAndChroma(hue, 4)
			self.n2 = TonalPalette:fromHueAndChroma(hue, 8)
		end
		self.error = TonalPalette:fromHueAndChroma(25, 84)
	end
	function CorePalette:of(argb)
		return CorePalette.new(argb, false)
	end
	function CorePalette:contentOf(argb)
		return CorePalette.new(argb, true)
	end
	function CorePalette:fromColors(colors)
		return CorePalette:createPaletteFromColors(false, colors)
	end
	function CorePalette:contentFromColors(colors)
		return CorePalette:createPaletteFromColors(true, colors)
	end
	function CorePalette:createPaletteFromColors(content, colors)
		local palette = CorePalette.new(colors.primary, content)
		local _value = colors.secondary
		if _value ~= 0 and _value == _value and _value then
			local p = CorePalette.new(colors.secondary, content)
			palette.a2 = p.a1
		end
		local _value_1 = colors.tertiary
		if _value_1 ~= 0 and _value_1 == _value_1 and _value_1 then
			local p = CorePalette.new(colors.tertiary, content)
			palette.a3 = p.a1
		end
		local _value_2 = colors.error
		if _value_2 ~= 0 and _value_2 == _value_2 and _value_2 then
			local p = CorePalette.new(colors.error, content)
			palette.error = p.a1
		end
		local _value_3 = colors.neutral
		if _value_3 ~= 0 and _value_3 == _value_3 and _value_3 then
			local p = CorePalette.new(colors.neutral, content)
			palette.n1 = p.n1
		end
		local _value_4 = colors.neutralVariant
		if _value_4 ~= 0 and _value_4 == _value_4 and _value_4 then
			local p = CorePalette.new(colors.neutralVariant, content)
			palette.n2 = p.n2
		end
		return palette
	end
end
return {
	CorePalette = CorePalette,
}
