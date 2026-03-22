# Accessibility

**Source:** [Color & Contrast](https://colorandcontrast.com/) — A comprehensive guide to color for UI designers

_69 content fragments extracted from SPA bundle_

---

Web Content Accessibility Guidelines (WCAG) 2.1

(Chromatic luminance) The illusion where increased saturation of a color is perceived as an increase in the color's lightness.

in order to ensure appropriate contrast is provided, regardless of the affects of chromatic luminance.

This secondary process creates the red-green, blue-yellow, and luminance channels of vision (used in

Color vision deficiencies are anomalies in wavelength sensitivity or absence of photoreceptor cells.

Color vision deficiencies are anomalies in wavelength sensitivity or absence of

. Approximately 8% of males and 0.5% of females have a color vision deficiency.

Types of color vision deficiency include:

Designing with color vision deficiencies in mind is important. Most issues can be resolved by compliance with

Contrast sensitivity is affected by lighting intensity and spatial frequency. Sensitivity thresholds are unique to individuals based on a number of factors (such as cataracts or damage to the optic nerve).

Results are plotted against a chart (like the example above) to identify the individual's contrast sensitivity.

This is a simulation of the contrast sensitivity test and is not intended to be used for actual contrast sensitivity testing or diagnosis.

Not all people have the same contrast sensitivity. WCAG

will help users with low contrast sensitivity.

A process that emphasizes boundaries or edges between objects of different luminance. Used to assist detecting objects by increasing the perceived brightness contrast between them.

The sequence of grays appear as gradients, demonstrated by chart of percieved luminance, despite being solid colors as demonstrated by step chart of actual luminance.

A relative measurement of luminance used in color appearance models where adaptive light is a factor. The relative luminance formula is used by the Web Content Accessibility Guidelines (WCAG) for calculating lightness contrast, and used in the definition of their success criteria.

A comparison of relative luminance is used by the Web Content Accessibility Guidelines (WCAG) for calculating

Relative luminance formula is used for contrast calculations to ensure text and components are distinguishable. Check contrast for colors to ensure you are in compliance with WCAG

Relative luminance contrast performs poorly for evaluating contrast in dark

. Light text colors on dark backgrounds need increased relative luminance contrast.

APCA (accessible perceptual contrast algorithm)

which uses an alternative to relative luminance when calculating contrast.

,c.colorContrast1=c.defaultcolorContrast1,c.colorContrast2=c.defaultcolorContrast2,c.diff=Object(tt.a)(Object(tt.b)(Je()(c.colorContrast1).rgba()),Object(tt.b)(Je()(c.colorContrast2).rgba())),c.rounded=it(c.diff);var o=Je.a.contrast(c.defaultcolorContrast1,c.defaultcolorContrast2);return c.wcagContrast=it(o),c.update=function(){var e=Object(tt.b)(Je()(c.colorContrast1).rgba()),t=Object(tt.b)(Je()(c.colorContrast2).rgba()),i=Object(tt.a)(e,t),o=it(i);document.getElementById(

).innerHTML=o;var s=Je.a.contrast(c.colorContrast1,c.colorContrast2);c.wcagContrast=it(s),document.getElementById(

).innerHTML=c.wcagContrast},c}return Object(Q.a)(i,[{key:

(Accessible perceptual contrast algorithm) An algorithm in progress set to replace Web Content Accessibility Guidelines' (WCAG) relative luminance method for contrast calculation.

An algorithm in progress set to replace Web Content Accessibility Guidelines' (WCAG)

APCA takes into account various aspects of contrast & color perception, such as

APCA is not an official standard formula and should not be used in replacement of WCAG

if you want to use APCA while still meeting WCAG 2 criteria.

APCA formula is based on typographic shapes, which exist in a higher

)},st=i(19),rt=i(7),nt=i(5),at=i(45),lt=i(30),dt=i(50),ht=dt.cam({whitePoint:lt.illuminant.D65,adaptingLuminance:40,backgroundLuminance:20,surroundType:

A type of color vision deficiency where one of the cone pigments in the eye has a different wavelength sensitivity than normal.

Most simulation tools imply a fixed experience for each vision type. Anomalous trichromats vary in the strength of their color deficiencies. Reliance on these tools (along with subjective decisions) can result in falsely identifying safe colors.

(Dichromatic vision) A type of color vision deficiency where one of the cone pigments is missing, resulting in only two wavelength sensitivities.

(Monochromatic vision, Achromatopsia) A type of color vision deficiency that can be the result missing cone pigments.

Example image simulating scotopic (rod-only) monochromacy.

Example image simulating blue cone monochromacy with full loss of color discrimination, lowered visual acuity, and light sensitivity.

It is difficult to distinguish blue cone monochromacy from achromatopsia. Blue cone monochromacy is very rare and affects 0.00001% of people.

that can be the result of missing cone pigments. Cerebral achromatopsia is a type of monochromacy resulting from stroke or damage to areas of the brain.

Most tools improperly simulate types of monochromacy, as they fail to account for increased

Monochromatic colors are tints or shades of a color with the same hue.

Monochromatic colors can be used to create uniform

Opacity can be used to create subtle, or low-contrast colors. Translucent colors adapt well when placed on different surfaces, and retain a consistent WCAG

may not match. Ensure your colors meet or exceed WCAG

for users who need more contrast than WCAG

provide options for various use cases of color in a digital experience, including options to meet WCAG contrast.

To begin, you will need to know if your product is targeting WCAG AA or AAA compliance.

If you're using APCA contrast, you can evenly distribute contrast values (linearly) and it will give you the best result. This is because APCA has accounted for Steven's law within the formula itself.

the same. WCAG criteria can help, however personalization will give more sighted users an improved overall experience.

The colorfulness (chroma) of a color increases with it's luminance.

A measure of the intensity of emitted light, which describes the amount of light passing through, emitting from, or reflecting off a surface. Luminance is not a perceptual measurement.

Luminance is distinctly different from color properties such as

Luminance relates to a device's unique screen brightness levels, as the amount of light emitted from the screen.

Not all people have the same visual acuity. WCAG

A process of the visual system to increase or decrease contrast sensitivity in response to surrounding contrast.

Contrast and luminance adaptation alter neuronal coding and perception of stimulus orientation

A color space representing the three different cone responses of trichromatic vision. LMS is used in studying and simulating color vision deficiencies.

Lines in a CIE chromaticity diagram that intersect colors that are difficult to distinguish for people with color vision deficiencies.

The point where confusion lines converge is the

Some color tools provide visualization of color confusion lines to assist in color picking.

,{children:['Confusion lines alone are insufficient for determining

contrast formula accounts for the perceptual differences of contrast polarity.

The effect of contrast polarity on letter identification

Influence of contrast polarity on the accommodative response

Luminance Contrast Shifts Dominance Balance between ON and OFF Pathways in Human Vision

Reading and Myopia: Contrast Polarity Matters

Effect of display polarity and luminance contrast on visual lobe shape characteristics
