--!strict
--services
--packages
--modules
local Hct = require(script.Parent.Parent:WaitForChild("hct"):WaitForChild("hct"))
local TonalPalette = require(script.Parent.Parent:WaitForChild("palettes"):WaitForChild("tonal_palette"))
--types
type Hct = Hct.Hct
type TonalPalette = TonalPalette.TonalPalette
export type Variant = {
	[number] : string,
	MONOCHROME : number,
	NEUTRAL : number,
	TONAL_SPOT : number,
	VIBRANT : number,
	EXPRESSIVE : number,
	FIDELITY : number,
	CONTENT : number,
	RAINBOW : number,
	FRUIT_SALAD : number
}

export type TonePolarity = 'darker' | 'lighter' | 'nearer' | 'farther';

export type ToneDeltaPair = {
	roleA : DynamicColor,
	roleB : DynamicColor,
	delta : number,
	polarity : TonePolarity,
	stayTogether : boolean
}
export type FromPaletteOptions = {
	name : string, palette : (scheme : DynamicScheme) -> TonalPalette, 
	tone : (scheme : DynamicScheme) -> number, isBackground : boolean?, 
	background : ((scheme : DynamicScheme) -> DynamicColor) ?, secondBackground  : ((scheme : DynamicScheme) -> DynamicColor) ?, 
	contrastCurve : ContrastCurve?, toneDeltaPair : ((scheme : DynamicScheme) -> ToneDeltaPair)?
}

export type DynamicSchemeOptions = {
    sourceColorArgb: number;
    variant: Variant;
    contrastLevel: number;
    isDark: boolean;
    primaryPalette: TonalPalette;
    secondaryPalette: TonalPalette;
    tertiaryPalette: TonalPalette;
    neutralPalette: TonalPalette;
    neutralVariantPalette: TonalPalette;
}

export type ContrastCurve = {
	__index : ContrastCurve,
	low : number,
	normal : number,
	medium : number,
	high : number,

	new : (... any) -> ContrastCurve,
	constructor : (self : any, low : number, normal : number, medium : number, high : number) -> (),
	get : (contrastLevel : number) -> number
}

export type DynamicColor = {
	__index : DynamicColor,

	new : (name : string, palette : (scheme : DynamicScheme) -> TonalPalette, 
        tone : (scheme : DynamicScheme) -> number, isBackground : boolean?, 
        background : ((scheme : DynamicScheme) -> DynamicColor) ?, secondBackground  : ((scheme : DynamicScheme) -> DynamicColor) ?, 
        contrastCurve : ContrastCurve?, toneDeltaPair : ((scheme : DynamicScheme) -> ToneDeltaPair)?
    ) -> DynamicColor,
	constructor : (self : DynamicColor, name : string, palette : (scheme : DynamicScheme) -> TonalPalette, 
		tone : (scheme : DynamicScheme) -> number, isBackground : boolean?, 
		background : ((scheme : DynamicScheme) -> DynamicColor) ?, secondBackground  : ((scheme : DynamicScheme) -> DynamicColor) ?, 
		contrastCurve : ContrastCurve?, toneDeltaPair : ((scheme : DynamicScheme) -> ToneDeltaPair)?
	) -> (),
	fromPalette : (args : FromPaletteOptions) -> DynamicColor,
	getArgb : (self : DynamicColor, DynamicScheme) -> number,
	getHct : (self : DynamicColor, DynamicScheme) -> Hct,
	getTone : (self : DynamicColor, DynamicScheme) -> number,

	foregroundTone : (self : DynamicColor, bgTone : number, ratio : number) -> number,

	tonePrefersLightForeground : (self : DynamicColor, tone : number) -> boolean,
	toneAllowsLightForeground : (self : DynamicColor, tone : number) -> boolean,
	enableLightForeground : (self : DynamicColor, tone : number) -> boolean,
}


export type DynamicScheme = {
	__index : DynamicScheme,

	new : (DynamicSchemeOptions) -> DynamicScheme,
	constructor : (self : any, 
		DynamicSchemeOptions
	) -> (),

	getRotatedHue : (self : DynamicScheme, sourceColor : Hct, hues : {number}, rotations : {number}) -> number,
	getArgb : (self : DynamicScheme, DynamicColor) -> number,
	getHct : (self : DynamicScheme, DynamicColor) -> (),
	get_primaryPaletteKeyColor : (self : DynamicScheme) -> number,
	get_secondaryPaletteKeyColor : (self : DynamicScheme) -> number;
    get_tertiaryPaletteKeyColor : (self : DynamicScheme) -> number;
    get_neutralPaletteKeyColor : (self : DynamicScheme) -> number;
    get_neutralVariantPaletteKeyColor : (self : DynamicScheme) -> number;
    get_background : (self : DynamicScheme) -> number;
    get_onBackground : (self : DynamicScheme) -> number;
    get_surface : (self : DynamicScheme) -> number;
    get_surfaceDim : (self : DynamicScheme) -> number;
    get_surfaceBright : (self : DynamicScheme) -> number;
    get_surfaceContainerLowest : (self : DynamicScheme) -> number;
    get_surfaceContainerLow : (self : DynamicScheme) -> number;
    get_surfaceContainer : (self : DynamicScheme) -> number;
    get_surfaceContainerHigh : (self : DynamicScheme) -> number;
    get_surfaceContainerHighest : (self : DynamicScheme) -> number;
    get_onSurface : (self : DynamicScheme) -> number;
    get_surfaceVariant : (self : DynamicScheme) -> number;
    get_onSurfaceVariant : (self : DynamicScheme) -> number;
    get_inverseSurface : (self : DynamicScheme) -> number;
    get_inverseOnSurface : (self : DynamicScheme) -> number;
    get_outline : (self : DynamicScheme) -> number;
    get_outlineVariant : (self : DynamicScheme) -> number;
    get_shadow : (self : DynamicScheme) -> number;
    get_scrim : (self : DynamicScheme) -> number;
    get_surfaceTint : (self : DynamicScheme) -> number;
    get_primary : (self : DynamicScheme) -> number;
    get_onPrimary : (self : DynamicScheme) -> number;
    get_primaryContainer : (self : DynamicScheme) -> number;
    get_onPrimaryContainer : (self : DynamicScheme) -> number;
    get_inversePrimary : (self : DynamicScheme) -> number;
    get_secondary : (self : DynamicScheme) -> number;
    get_onSecondary : (self : DynamicScheme) -> number;
    get_secondaryContainer : (self : DynamicScheme) -> number;
    get_onSecondaryContainer : (self : DynamicScheme) -> number;
    get_tertiary : (self : DynamicScheme) -> number;
    get_onTertiary : (self : DynamicScheme) -> number;
    get_tertiaryContainer : (self : DynamicScheme) -> number;
    get_onTertiaryContainer : (self : DynamicScheme) -> number;
    get_error : (self : DynamicScheme) -> number;
    get_onError : (self : DynamicScheme) -> number;
    get_errorContainer : (self : DynamicScheme) -> number;
    get_onErrorContainer : (self : DynamicScheme) -> number;
    get_primaryFixed : (self : DynamicScheme) -> number;
    get_primaryFixedDim : (self : DynamicScheme) -> number;
    get_onPrimaryFixed : (self : DynamicScheme) -> number;
    get_onPrimaryFixedVariant : (self : DynamicScheme) -> number;
    get_secondaryFixed : (self : DynamicScheme) -> number;
    get_secondaryFixedDim : (self : DynamicScheme) -> number;
    get_onSecondaryFixed : (self : DynamicScheme) -> number;
    get_onSecondaryFixedVariant : (self : DynamicScheme) -> number;
    get_tertiaryFixed : (self : DynamicScheme) -> number;
    get_tertiaryFixedDim : (self : DynamicScheme) -> number;
    get_onTertiaryFixed : (self : DynamicScheme) -> number;
    get_onTertiaryFixedVariant : (self : DynamicScheme) -> number;
}
--constants
--remotes
--variables
--references
--local functions
--class

return {}