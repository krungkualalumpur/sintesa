/**
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
 */
import { Hct } from '../hct/hct.js';
import { TonalPalette } from '../palettes/tonal_palette.js';
import { DynamicColor } from './dynamic_color.js';
import { Variant } from './variant.js';
/**
 * @param sourceColorArgb The source color of the theme as an ARGB 32-bit
 *     integer.
 * @param variant The variant, or style, of the theme.
 * @param contrastLevel Value from -1 to 1. -1 represents minimum contrast,
 * 0 represents standard (i.e. the design as spec'd), and 1 represents maximum
 * contrast.
 * @param isDark Whether the scheme is in dark mode or light mode.
 * @param primaryPalette Given a tone, produces a color. Hue and chroma of the
 * color are specified in the design specification of the variant. Usually
 * colorful.
 * @param secondaryPalette Given a tone, produces a color. Hue and chroma of
 * the color are specified in the design specification of the variant. Usually
 * less colorful.
 * @param tertiaryPalette Given a tone, produces a color. Hue and chroma of
 * the color are specified in the design specification of the variant. Usually
 * a different hue from primary and colorful.
 * @param neutralPalette Given a tone, produces a color. Hue and chroma of the
 * color are specified in the design specification of the variant. Usually not
 * colorful at all, intended for background & surface colors.
 * @param neutralVariantPalette Given a tone, produces a color. Hue and chroma
 * of the color are specified in the design specification of the variant.
 * Usually not colorful, but slightly more colorful than Neutral. Intended for
 * backgrounds & surfaces.
 */
interface DynamicSchemeOptions {
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
/**
 * Constructed by a set of values representing the current UI state (such as
 * whether or not its dark theme, what the theme style is, etc.), and
 * provides a set of TonalPalettes that can create colors that fit in
 * with the theme style. Used by DynamicColor to resolve into a color.
 */
export declare class DynamicScheme {
    /**
     * The source color of the theme as an HCT color.
     */
    sourceColorHct: Hct;
    /**
     * Given a tone, produces a reddish, colorful, color.
     */
    errorPalette: TonalPalette;
    /** The source color of the theme as an ARGB 32-bit integer. */
    readonly sourceColorArgb: number;
    /** The variant, or style, of the theme. */
    readonly variant: Variant;
    /**
     * Value from -1 to 1. -1 represents minimum contrast. 0 represents standard
     * (i.e. the design as spec'd), and 1 represents maximum contrast.
     */
    readonly contrastLevel: number;
    /** Whether the scheme is in dark mode or light mode. */
    readonly isDark: boolean;
    /**
     * Given a tone, produces a color. Hue and chroma of the
     * color are specified in the design specification of the variant. Usually
     * colorful.
     */
    readonly primaryPalette: TonalPalette;
    /**
     * Given a tone, produces a color. Hue and chroma of
     * the color are specified in the design specification of the variant. Usually
     * less colorful.
     */
    readonly secondaryPalette: TonalPalette;
    /**
     * Given a tone, produces a color. Hue and chroma of
     * the color are specified in the design specification of the variant. Usually
     * a different hue from primary and colorful.
     */
    readonly tertiaryPalette: TonalPalette;
    /**
     * Given a tone, produces a color. Hue and chroma of the
     * color are specified in the design specification of the variant. Usually not
     * colorful at all, intended for background & surface colors.
     */
    readonly neutralPalette: TonalPalette;
    /**
     * Given a tone, produces a color. Hue and chroma
     * of the color are specified in the design specification of the variant.
     * Usually not colorful, but slightly more colorful than Neutral. Intended for
     * backgrounds & surfaces.
     */
    readonly neutralVariantPalette: TonalPalette;
    constructor(args: DynamicSchemeOptions);
    /**
     * Support design spec'ing Dynamic Color by schemes that specify hue
     * rotations that should be applied at certain breakpoints.
     * @param sourceColor the source color of the theme, in HCT.
     * @param hues The "breakpoints", i.e. the hues at which a rotation should
     * be apply.
     * @param rotations The rotation that should be applied when source color's
     * hue is >= the same index in hues array, and <= the hue at the next index
     * in hues array.
     */
    static getRotatedHue(sourceColor: Hct, hues: number[], rotations: number[]): number;
    getArgb(dynamicColor: DynamicColor): number;
    getHct(dynamicColor: DynamicColor): Hct;
    get_primaryPaletteKeyColor(): number;
    get_secondaryPaletteKeyColor(): number;
    get_tertiaryPaletteKeyColor(): number;
    get_neutralPaletteKeyColor(): number;
    get_neutralVariantPaletteKeyColor(): number;
    get_background(): number;
    get_onBackground(): number;
    get_surface(): number;
    get_surfaceDim(): number;
    get_surfaceBright(): number;
    get_surfaceContainerLowest(): number;
    get_surfaceContainerLow(): number;
    get_surfaceContainer(): number;
    get_surfaceContainerHigh(): number;
    get_surfaceContainerHighest(): number;
    get_onSurface(): number;
    get_surfaceVariant(): number;
    get_onSurfaceVariant(): number;
    get_inverseSurface(): number;
    get_inverseOnSurface(): number;
    get_outline(): number;
    get_outlineVariant(): number;
    get_shadow(): number;
    get_scrim(): number;
    get_surfaceTint(): number;
    get_primary(): number;
    get_onPrimary(): number;
    get_primaryContainer(): number;
    get_onPrimaryContainer(): number;
    get_inversePrimary(): number;
    get_secondary(): number;
    get_onSecondary(): number;
    get_secondaryContainer(): number;
    get_onSecondaryContainer(): number;
    get_tertiary(): number;
    get_onTertiary(): number;
    get_tertiaryContainer(): number;
    get_onTertiaryContainer(): number;
    get_error(): number;
    get_onError(): number;
    get_errorContainer(): number;
    get_onErrorContainer(): number;
    get_primaryFixed(): number;
    get_primaryFixedDim(): number;
    get_onPrimaryFixed(): number;
    get_onPrimaryFixedVariant(): number;
    get_secondaryFixed(): number;
    get_secondaryFixedDim(): number;
    get_onSecondaryFixed(): number;
    get_onSecondaryFixedVariant(): number;
    get_tertiaryFixed(): number;
    get_tertiaryFixedDim(): number;
    get_onTertiaryFixed(): number;
    get_onTertiaryFixedVariant(): number;
}
export {};
