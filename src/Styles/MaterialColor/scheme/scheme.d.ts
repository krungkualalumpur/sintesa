/**
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
 */
import { CorePalette } from '../palettes/core_palette.js';
/**
 * DEPRECATED. The `Scheme` class is deprecated in favor of `DynamicScheme`.
 * Please see
 * https://github.com/material-foundation/material-color-utilities/blob/main/make_schemes.md
 * for migration guidance.
 *
 * Represents a Material color scheme, a mapping of color roles to colors.
 */
export declare class Scheme {
    private readonly props;
    get_primary(): number;
    get_onPrimary(): number;
    get_primaryContainer(): number;
    get_onPrimaryContainer(): number;
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
    get_background(): number;
    get_onBackground(): number;
    get_surface(): number;
    get_onSurface(): number;
    get_surfaceVariant(): number;
    get_onSurfaceVariant(): number;
    get_outline(): number;
    get_outlineVariant(): number;
    get_shadow(): number;
    get_scrim(): number;
    get_inverseSurface(): number;
    get_inverseOnSurface(): number;
    get_inversePrimary(): number;
    /**
     * @param argb ARGB representation of a color.
     * @return Light Material color scheme, based on the color's hue.
     */
    static light(argb: number): Scheme;
    /**
     * @param argb ARGB representation of a color.
     * @return Dark Material color scheme, based on the color's hue.
     */
    static dark(argb: number): Scheme;
    /**
     * @param argb ARGB representation of a color.
     * @return Light Material content color scheme, based on the color's hue.
     */
    static lightContent(argb: number): Scheme;
    /**
     * @param argb ARGB representation of a color.
     * @return Dark Material content color scheme, based on the color's hue.
     */
    static darkContent(argb: number): Scheme;
    /**
     * Light scheme from core palette
     */
    static lightFromCorePalette(core: CorePalette): Scheme;
    /**
     * Dark scheme from core palette
     */
    static darkFromCorePalette(core: CorePalette): Scheme;
    private constructor();
    toJSON(): {
        primary: number;
        onPrimary: number;
        primaryContainer: number;
        onPrimaryContainer: number;
        secondary: number;
        onSecondary: number;
        secondaryContainer: number;
        onSecondaryContainer: number;
        tertiary: number;
        onTertiary: number;
        tertiaryContainer: number;
        onTertiaryContainer: number;
        error: number;
        onError: number;
        errorContainer: number;
        onErrorContainer: number;
        background: number;
        onBackground: number;
        surface: number;
        onSurface: number;
        surfaceVariant: number;
        onSurfaceVariant: number;
        outline: number;
        outlineVariant: number;
        shadow: number;
        scrim: number;
        inverseSurface: number;
        inverseOnSurface: number;
        inversePrimary: number;
    };
}
