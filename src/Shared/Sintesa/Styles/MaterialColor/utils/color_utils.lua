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
local mathUtils = require(script.Parent:WaitForChild("math_utils"))
--[[
	*
	 * Color science utilities.
	 *
	 * Utility methods for color science constants and color space
	 * conversions that aren't HCT or CAM16.
	 
]]
local SRGB_TO_XYZ = { { 0.41233895, 0.35762064, 0.18051042 }, { 0.2126, 0.7152, 0.0722 }, { 0.01932141, 0.11916382, 0.95034478 } }
local XYZ_TO_SRGB = { { 3.2413774792388685, -1.5376652402851851, -0.49885366846268053 }, { -0.9691452513005321, 1.8758853451067872, 0.04156585616912061 }, { 0.05562093689691305, -0.20395524564742123, 1.0571799111220335 } }
local WHITE_POINT_D65 = { 95.047, 100.0, 108.883 }
--[[
	*
	 * Converts a color from RGB components to ARGB format.
	 
]]
local function argbFromRgb(red, green, blue)
	return bit32.rshift((bit32.bor(bit32.bor(bit32.bor(bit32.lshift(255, 24), bit32.lshift((bit32.band(red, 255)), 16)), bit32.lshift((bit32.band(green, 255)), 8)), bit32.band(blue, 255))), 0)
end
--[[
	*
	 * Converts a color from linear RGB components to ARGB format.
	 
]]
local delinearized
local function argbFromLinrgb(linrgb)
	local r = delinearized(linrgb[1])
	local g = delinearized(linrgb[2])
	local b = delinearized(linrgb[3])
	return argbFromRgb(r, g, b)
end
--[[
	*
	 * Returns the alpha component of a color in ARGB format.
	 
]]
local function alphaFromArgb(argb)
	return bit32.band(bit32.arshift(argb, 24), 255)
end
--[[
	*
	 * Returns the red component of a color in ARGB format.
	 
]]
local function redFromArgb(argb)
	return bit32.band(bit32.arshift(argb, 16), 255)
end
--[[
	*
	 * Returns the green component of a color in ARGB format.
	 
]]
local function greenFromArgb(argb)
	return bit32.band(bit32.arshift(argb, 8), 255)
end
--[[
	*
	 * Returns the blue component of a color in ARGB format.
	 
]]
local function blueFromArgb(argb)
	return bit32.band(argb, 255)
end
--[[
	*
	 * Returns whether a color in ARGB format is opaque.
	 
]]
local function isOpaque(argb)
	return alphaFromArgb(argb) >= 255
end
--[[
	*
	 * Converts a color from ARGB to XYZ.
	 
]]
local function argbFromXyz(x, y, z)
	local matrix = XYZ_TO_SRGB
	local linearR = matrix[1][1] * x + matrix[1][2] * y + matrix[1][3] * z
	local linearG = matrix[2][1] * x + matrix[2][2] * y + matrix[2][3] * z
	local linearB = matrix[3][1] * x + matrix[3][2] * y + matrix[3][3] * z
	local r = delinearized(linearR)
	local g = delinearized(linearG)
	local b = delinearized(linearB)
	return argbFromRgb(r, g, b)
end
--[[
	*
	 * Converts a color from XYZ to ARGB.
	 
]]
local linearized
local function xyzFromArgb(argb)
	local r = linearized(redFromArgb(argb))
	local g = linearized(greenFromArgb(argb))
	local b = linearized(blueFromArgb(argb))
	return mathUtils.matrixMultiply({ r, g, b }, SRGB_TO_XYZ)
end
--[[
	*
	 * Converts a color represented in Lab color space into an ARGB
	 * integer.
	 
]]
local labInvf
local function argbFromLab(l, a, b)
	local whitePoint = WHITE_POINT_D65
	local fy = (l + 16.0) / 116.0
	local fx = a / 500.0 + fy
	local fz = fy - b / 200.0
	local xNormalized = labInvf(fx)
	local yNormalized = labInvf(fy)
	local zNormalized = labInvf(fz)
	local x = xNormalized * whitePoint[1]
	local y = yNormalized * whitePoint[2]
	local z = zNormalized * whitePoint[3]
	return argbFromXyz(x, y, z)
end
--[[
	*
	 * Converts a color from ARGB representation to L*a*b*
	 * representation.
	 *
	 * @param argb the ARGB representation of a color
	 * @return a Lab object representing the color
	 
]]
local labF
local function labFromArgb(argb)
	local linearR = linearized(redFromArgb(argb))
	local linearG = linearized(greenFromArgb(argb))
	local linearB = linearized(blueFromArgb(argb))
	local matrix = SRGB_TO_XYZ
	local x = matrix[1][1] * linearR + matrix[1][2] * linearG + matrix[1][3] * linearB
	local y = matrix[2][1] * linearR + matrix[2][2] * linearG + matrix[2][3] * linearB
	local z = matrix[3][1] * linearR + matrix[3][2] * linearG + matrix[3][3] * linearB
	local whitePoint = WHITE_POINT_D65
	local xNormalized = x / whitePoint[1]
	local yNormalized = y / whitePoint[2]
	local zNormalized = z / whitePoint[3]
	local fx = labF(xNormalized)
	local fy = labF(yNormalized)
	local fz = labF(zNormalized)
	local l = 116.0 * fy - 16
	local a = 500.0 * (fx - fy)
	local b = 200.0 * (fy - fz)
	return { l, a, b }
end
--[[
	*
	 * Converts an L* value to an ARGB representation.
	 *
	 * @param lstar L* in L*a*b*
	 * @return ARGB representation of grayscale color with lightness
	 * matching L*
	 
]]
local yFromLstar
local function argbFromLstar(lstar)
	local y = yFromLstar(lstar)
	local component = delinearized(y)
	return argbFromRgb(component, component, component)
end
--[[
	*
	 * Computes the L* value of a color in ARGB representation.
	 *
	 * @param argb ARGB representation of a color
	 * @return L*, from L*a*b*, coordinate of the color
	 
]]
local function lstarFromArgb(argb)
	local y = xyzFromArgb(argb)[2]
	return 116.0 * labF(y / 100.0) - 16.0
end
--[[
	*
	 * Converts an L* value to a Y value.
	 *
	 * L* in L*a*b* and Y in XYZ measure the same quantity, luminance.
	 *
	 * L* measures perceptual luminance, a linear scale. Y in XYZ
	 * measures relative luminance, a logarithmic scale.
	 *
	 * @param lstar L* in L*a*b*
	 * @return Y in XYZ
	 
]]
function yFromLstar(lstar)
	return 100.0 * labInvf((lstar + 16.0) / 116.0)
end
--[[
	*
	 * Converts a Y value to an L* value.
	 *
	 * L* in L*a*b* and Y in XYZ measure the same quantity, luminance.
	 *
	 * L* measures perceptual luminance, a linear scale. Y in XYZ
	 * measures relative luminance, a logarithmic scale.
	 *
	 * @param y Y in XYZ
	 * @return L* in L*a*b*
	 
]]
local function lstarFromY(y)
	return labF(y / 100.0) * 116.0 - 16.0
end
--[[
	*
	 * Linearizes an RGB component.
	 *
	 * @param rgbComponent 0 <= rgb_component <= 255, represents R/G/B
	 * channel
	 * @return 0.0 <= output <= 100.0, color channel converted to
	 * linear RGB space
	 
]]
function linearized(rgbComponent)
	local normalized = rgbComponent / 255.0
	if normalized <= 0.040449936 then
		return normalized / 12.92 * 100.0
	else
		return math.pow((normalized + 0.055) / 1.055, 2.4) * 100.0
	end
end
--[[
	*
	 * Delinearizes an RGB component.
	 *
	 * @param rgbComponent 0.0 <= rgb_component <= 100.0, represents
	 * linear R/G/B channel
	 * @return 0 <= output <= 255, color channel converted to regular
	 * RGB space
	 
]]
function delinearized(rgbComponent)
	local normalized = rgbComponent / 100.0
	local delinearized = 0.0
	if normalized <= 0.0031308 then
		delinearized = normalized * 12.92
	else
		delinearized = 1.055 * math.pow(normalized, 1.0 / 2.4) - 0.055
	end
	return mathUtils.clampInt(0, 255, math.round(delinearized * 255.0))
end
--[[
	*
	 * Returns the standard white point; white on a sunny day.
	 *
	 * @return The white point
	 
]]
local function whitePointD65()
	return WHITE_POINT_D65
end
--[[
	*
	 * RGBA component
	 * 
	 * @param r Red value should be between 0-255
	 * @param g Green value should be between 0-255
	 * @param b Blue value should be between 0-255
	 * @param a Alpha value should be between 0-255
	 
]]
--[[
	*
	 * Return RGBA from a given int32 color
	 *
	 * @param argb ARGB representation of a int32 color.
	 * @return RGBA representation of a int32 color.
	 
]]
local function rgbaFromArgb(argb) : {r : number, g : number, b: number, a : number}
	local r = redFromArgb(argb)
	local g = greenFromArgb(argb)
	local b = blueFromArgb(argb)
	local a = alphaFromArgb(argb)
	return {
		r = r,
		g = g,
		b = b,
		a = a,
	}
end
--[[
	*
	 * Return int32 color from a given RGBA component
	 * 
	 * @param rgba RGBA representation of a int32 color.
	 * @returns ARGB representation of a int32 color.
	 
]]
local clampComponent
local function argbFromRgba(_param)
	local r = _param.r
	local g = _param.g
	local b = _param.b
	local a = _param.a
	local rValue = clampComponent(r)
	local gValue = clampComponent(g)
	local bValue = clampComponent(b)
	local aValue = clampComponent(a)
	return bit32.bor(bit32.bor(bit32.bor((bit32.lshift(aValue, 24)), (bit32.lshift(rValue, 16))), (bit32.lshift(gValue, 8))), bValue)
end
function clampComponent(value)
	if value < 0 then
		return 0
	end
	if value > 255 then
		return 255
	end
	return value
end
function labF(t)
	local e = 216.0 / 24389.0
	local kappa = 24389.0 / 27.0
	if t > e then
		return math.pow(t, 1.0 / 3.0)
	else
		return (kappa * t + 16) / 116
	end
end
function labInvf(ft)
	local e = 216.0 / 24389.0
	local kappa = 24389.0 / 27.0
	local ft3 = ft * ft * ft
	if ft3 > e then
		return ft3
	else
		return (116 * ft - 16) / kappa
	end
end
return {
	argbFromRgb = argbFromRgb,
	argbFromLinrgb = argbFromLinrgb,
	alphaFromArgb = alphaFromArgb,
	redFromArgb = redFromArgb,
	greenFromArgb = greenFromArgb,
	blueFromArgb = blueFromArgb,
	isOpaque = isOpaque,
	argbFromXyz = argbFromXyz,
	xyzFromArgb = xyzFromArgb,
	argbFromLab = argbFromLab,
	labFromArgb = labFromArgb,
	argbFromLstar = argbFromLstar,
	lstarFromArgb = lstarFromArgb,
	yFromLstar = yFromLstar,
	lstarFromY = lstarFromY,
	linearized = linearized,
	delinearized = delinearized,
	whitePointD65 = whitePointD65,
	rgbaFromArgb = rgbaFromArgb,
	argbFromRgba = argbFromRgba,
}
