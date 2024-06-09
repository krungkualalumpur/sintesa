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
-- This file is automatically generated. Do not modify it.
local CorePalette = TS.import(script, script.Parent.Parent, "palettes", "core_palette").CorePalette
--[[
	*
	 * DEPRECATED. The `Scheme` class is deprecated in favor of `DynamicScheme`.
	 * Please see
	 * https://github.com/material-foundation/material-color-utilities/blob/main/make_schemes.md
	 * for migration guidance.
	 *
	 * Represents a Material color scheme, a mapping of color roles to colors.
	 
]]
local Scheme
do
	Scheme = setmetatable({}, {
		__tostring = function()
			return "Scheme"
		end,
	})
	Scheme.__index = Scheme
	function Scheme.new(...)
		local self = setmetatable({}, Scheme)
		return self:constructor(...) or self
	end
	function Scheme:constructor(props)
		self.props = props
	end
	function Scheme:get_primary()
		return self.props.primary
	end
	function Scheme:get_onPrimary()
		return self.props.onPrimary
	end
	function Scheme:get_primaryContainer()
		return self.props.primaryContainer
	end
	function Scheme:get_onPrimaryContainer()
		return self.props.onPrimaryContainer
	end
	function Scheme:get_secondary()
		return self.props.secondary
	end
	function Scheme:get_onSecondary()
		return self.props.onSecondary
	end
	function Scheme:get_secondaryContainer()
		return self.props.secondaryContainer
	end
	function Scheme:get_onSecondaryContainer()
		return self.props.onSecondaryContainer
	end
	function Scheme:get_tertiary()
		return self.props.tertiary
	end
	function Scheme:get_onTertiary()
		return self.props.onTertiary
	end
	function Scheme:get_tertiaryContainer()
		return self.props.tertiaryContainer
	end
	function Scheme:get_onTertiaryContainer()
		return self.props.onTertiaryContainer
	end
	function Scheme:get_error()
		return self.props.error
	end
	function Scheme:get_onError()
		return self.props.onError
	end
	function Scheme:get_errorContainer()
		return self.props.errorContainer
	end
	function Scheme:get_onErrorContainer()
		return self.props.onErrorContainer
	end
	function Scheme:get_background()
		return self.props.background
	end
	function Scheme:get_onBackground()
		return self.props.onBackground
	end
	function Scheme:get_surface()
		return self.props.surface
	end
	function Scheme:get_onSurface()
		return self.props.onSurface
	end
	function Scheme:get_surfaceVariant()
		return self.props.surfaceVariant
	end
	function Scheme:get_onSurfaceVariant()
		return self.props.onSurfaceVariant
	end
	function Scheme:get_outline()
		return self.props.outline
	end
	function Scheme:get_outlineVariant()
		return self.props.outlineVariant
	end
	function Scheme:get_shadow()
		return self.props.shadow
	end
	function Scheme:get_scrim()
		return self.props.scrim
	end
	function Scheme:get_inverseSurface()
		return self.props.inverseSurface
	end
	function Scheme:get_inverseOnSurface()
		return self.props.inverseOnSurface
	end
	function Scheme:get_inversePrimary()
		return self.props.inversePrimary
	end
	function Scheme:light(argb)
		return Scheme:lightFromCorePalette(CorePalette:of(argb))
	end
	function Scheme:dark(argb)
		return Scheme:darkFromCorePalette(CorePalette:of(argb))
	end
	function Scheme:lightContent(argb)
		return Scheme:lightFromCorePalette(CorePalette:contentOf(argb))
	end
	function Scheme:darkContent(argb)
		return Scheme:darkFromCorePalette(CorePalette:contentOf(argb))
	end
	function Scheme:lightFromCorePalette(core)
		return Scheme.new({
			primary = core.a1:tone(40),
			onPrimary = core.a1:tone(100),
			primaryContainer = core.a1:tone(90),
			onPrimaryContainer = core.a1:tone(10),
			secondary = core.a2:tone(40),
			onSecondary = core.a2:tone(100),
			secondaryContainer = core.a2:tone(90),
			onSecondaryContainer = core.a2:tone(10),
			tertiary = core.a3:tone(40),
			onTertiary = core.a3:tone(100),
			tertiaryContainer = core.a3:tone(90),
			onTertiaryContainer = core.a3:tone(10),
			error = core.error:tone(40),
			onError = core.error:tone(100),
			errorContainer = core.error:tone(90),
			onErrorContainer = core.error:tone(10),
			background = core.n1:tone(99),
			onBackground = core.n1:tone(10),
			surface = core.n1:tone(99),
			onSurface = core.n1:tone(10),
			surfaceVariant = core.n2:tone(90),
			onSurfaceVariant = core.n2:tone(30),
			outline = core.n2:tone(50),
			outlineVariant = core.n2:tone(80),
			shadow = core.n1:tone(0),
			scrim = core.n1:tone(0),
			inverseSurface = core.n1:tone(20),
			inverseOnSurface = core.n1:tone(95),
			inversePrimary = core.a1:tone(80),
		})
	end
	function Scheme:darkFromCorePalette(core)
		return Scheme.new({
			primary = core.a1:tone(80),
			onPrimary = core.a1:tone(20),
			primaryContainer = core.a1:tone(30),
			onPrimaryContainer = core.a1:tone(90),
			secondary = core.a2:tone(80),
			onSecondary = core.a2:tone(20),
			secondaryContainer = core.a2:tone(30),
			onSecondaryContainer = core.a2:tone(90),
			tertiary = core.a3:tone(80),
			onTertiary = core.a3:tone(20),
			tertiaryContainer = core.a3:tone(30),
			onTertiaryContainer = core.a3:tone(90),
			error = core.error:tone(80),
			onError = core.error:tone(20),
			errorContainer = core.error:tone(30),
			onErrorContainer = core.error:tone(80),
			background = core.n1:tone(10),
			onBackground = core.n1:tone(90),
			surface = core.n1:tone(10),
			onSurface = core.n1:tone(90),
			surfaceVariant = core.n2:tone(30),
			onSurfaceVariant = core.n2:tone(80),
			outline = core.n2:tone(60),
			outlineVariant = core.n2:tone(30),
			shadow = core.n1:tone(0),
			scrim = core.n1:tone(0),
			inverseSurface = core.n1:tone(90),
			inverseOnSurface = core.n1:tone(20),
			inversePrimary = core.a1:tone(40),
		})
	end
	function Scheme:toJSON()
		local _object = table.clone(self.props)
		setmetatable(_object, nil)
		return _object
	end
end
return {
	Scheme = Scheme,
}