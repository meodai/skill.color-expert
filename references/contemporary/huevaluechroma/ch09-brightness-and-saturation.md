# brightness and saturation

**Source:** David Briggs — [Dimensions of Color](http://www.huevaluechroma.com/)

---

## Page 091

Please note
: The pages forming Part 9 were part of the original
Dimensions of Colour
site uploaded in 2007 and have not been updated recently. They are left here for the moment because some of the diagrams have been linked to by other sites or reproduced in publications. For much more recent discussions of brightness, saturation and colourfulness please see:
Section 1.6 The Dimensions of Colour: Brightness and Colourfulness
http://www.huevaluechroma.com/016.php
Section 1.7 The Dimensions of Colour: Saturation
http://www.huevaluechroma.com/017.php
PART 9. THE DIMENSIONS OF BRIGHTNESS, SATURATION AND COLOURFULNESS
Figure 9.1. Same saturation, different chroma and colourfulness
. All four screen areas A-D emit light of the
same
saturation
(pure red), but they differ among themselves in chroma, both when seen
as surfaces in the subject (A[=B] > C[=D]) and, in a different way, when
seen as surface colours in the image (B > A[=D] > C). Light from these
four areas, though of  the same saturation, exhibits progressively more
colourfulness
in proportion to its brightness.
We saw in the
introduction
that a different set of dimensions applies to the visual appearance of light,
as opposed to surfaces. Brightness is the
perceived intensity
of a light, and saturation is the
perceived purity of colour
or
relative colour intensity
of a light.
Colourfulness

- the
  absolute colour intensity
  of a light stimulus - is a function of brightness and saturation. Brightness is the perceptual correlative of the psychophysical parameter of
  luminance
  , which in turn is the amount of radiant energy (
  radiance
  ) weighted according to the relative sensitivity of human vision to each wavelength. Saturation is the perceptual correlative of physical parameter of
  spectral purity
  . Colours making up an image,
  which can be described in terms of lightness and chroma if looked at as surface
  colours
  ,
  can also be described in terms of brightness, saturation and colourfulness if viewed as light coming from the image.
  In earlier literature, brightness and saturation are often treated as essentially
  subjective parameters, unsuited to quantification, but more recent literature
  on colour appearance models is developing ways of treating these dimensions
  quantitatively (Moroney
  et al
  ., 2002). However, absolute quantitative measures of these parameters, and of their physical correlatives, are not generally used by painters, and for most purposes they do not need to be. Digital artists are able to manipulate measures of
  relative
  brightness and saturation in their images in programmes such as Photoshop. This opens up enormous possibilities for emulating the effects of light from the imagination, as long as artists understand the basic
  principles of colour
  .
  Even so, for most such purposes, digital artists need ony concern themselves
  with the specific measures of brightness and saturation used in these programmes
  (defined in relation to the gamut of available colours), rather than with absolute
  quantitative measures of brightness, saturation, and their physical correlatives.
  Tonal realist painters
  do
  systematically judge the brightness
  and colour intensity of the light coming to their eyes from their subjects,
  but in general they do not think in terms of absolute measures of these parameters,
  but only with
  relationships
  of these parameters between the
  different components of their subject. They typically (and often unconsciously)
  think of these
  relationships of brightness and colourfulness
  in terms of the
  value and chroma
  of the
  paint
  mixtures that they will use, sometimes in relation to an absolute framework
  such as the Munsell System.
  << 1
  2
  3
  4 >>

---

## Page 092

BRIGHTNESS-BASED COLOUR SPACES 1: RGB, CMY AND CMYK SPACES
Figure 9.2. RGB and CMY colour space
. (A) RGB and (B) CMY colour
spaces, illustrated using the programme RGBCube by Philippe Colantoni.
RGB SPACE
Since the colours on a computer monitor or television are produced from various
combinations of R, G and B components, it follows that they can be represented
by a system of three orthogonal axes representing these components. This results
in a cubic volume enclosing all possible screen colours, with black at the origin
and white at the opposite corner. Easygoing artists like ourselves can refer
to this as RGB colour space, but when mixing in strict colourimetric circles,
take care to refer to it as the RGB colour
model
, which can
be embodied in various defined colour spaces, such as sRGB or AdobeRGB.
The R,G and B components are usually reported on a scale of 0 to 255, but
can also be reported on a scale of 0 to 1 (distinguished as r,g and b here).
Confusingly, these RGB values sometimes refer to
linear
units
of light energy, or radiance, and sometimes to
nonlinear
units
of perceived brightness (i.e. in equal perceptual steps). Often no care is taken
to show which of the two kind of units is being used - you need to work it out
in each context (
link
). In
Photoshop, both relative brightness (B) and the R,G and B components are reported
in nonlinear (brightness) units.The conversion is:
(nonlinear) brightness = linear "brightness"
0.45
The formula has a generally similar effect to the more elaborate nonlinear
conversion between CIE luminance (Y) and Lightness (L),
L = 116 (Y/Y
n
)
1/3

- 16; 0.008856 <
  Y/Y
  n
  CMY SPACE
  In CMY space, the same RGB colours are considered as subtractive mixtures of
  varying quantities of cyan (C), magenta (M) and yellow (Y) colourants. The resulting
  cubic space is identical to RGB space, apart from the fact that the origin of
  the C, M and Y axes is at the point representing white instead of black (Figure
  9.2B). The conversion is given by the formulae C = 255 minus R (or 1 - r), M
  = 255 minus G (or 1 - g), and Y = 255 - B (or 1 minus b) respectively (Figure
  9.3). Note that C, M and Y in these formulae refer to the ideal subtractive
  primaries, not actual cyan, magenta and yellow inks, i.e. C,M and Y behave as
  ideal subtractive colourants complementary to the particular R,G and B additive
  primaries that are in use.
  Figure 9.3. Ideal conversion of RGB to CMY
  .
  CMYK SPACE
  Although cyan, magenta and yellow inks might be expected be sufficient for
  colour printing, most actual colour printing uses black ink in addition. This
  is partly because a mixture of the first three inks may not yield a black that
  is neutral enough, or dark enough, but also because the use of black spares
  the use of the more expensive coloured inks, and also reduces the total amount
  of ink used, thus speeding drying times. Conversely, it permits the use of coloured
  inks with better colour rendering properties than would be possible if it was
  necessary that these mix to make a dense black by themselves. The practical
  need for a black component was recognized right from the invention of colour
  printing by the German artist J.C. Le Blon in the early 1700's. After Le Blon's
  death his former pupil, Jacques Gautier D'Agoty, in order to protect his own
  patent for the four-colour process, disputed the claims of Le Blon's workshop
  that the master had ever used more than three colours. Le Blon 's supporters
  replied that their master kept quiet about his use of the fourth plate because
  he used it in spite of himself, and felt that it would dishonour his system
  (Gage, 1999, p. 139).
  The amount of the black component needed is conventionally specified by the
  letter K. CMYK values are typically reported as percentages.
  Ideal
  CMYK
  values can be calculated by simple formulae directly from CMY values, but these
  values are not accurate for colour printing (Ford and Roberts, 1998):
  Black (K) = minimum of C,M,Y
  Cyan
  CMYK
  = (C - K)/(1 - K)
  Magenta
  CMYK
  = (M - K)/(1 - K)
  Yellow
  CMYK
  = (Y - K)/(1 - K)
  These "cheap and nasty" formulae for CMYK in effect divide the CMY
  values into a black component (determined by the minumum value among C, M and
  Y), and the
  relative
  proportions of C, M and Y within the remaining
  coloured component (Figure 9.4). In ideal CMYK, one of the C, M or Y values
  is therefore always zero.
  Figure 9.4. Ideal conversion of CMY to CMYK. Though this idealized conversion
  is only indicative, it at least suggests how the use of black ink can permit
  the same result to be obtained using less coloured ink, and less ink overall,
  than with three coloured inks alone.
  The conversion to CMYK values given by the colour picker in Photoshop does
  not
  use these simple formulae, but is a much more sophisticated
  colour management transformation (via Lab space) that takes account of the colour
  profiles of the monitor display and printer inks specified by the user.
  << 1
  2
  3
  4 >>

---

## Page 093

BRIGHTNESS-BASED COLOUR SPACES 2: HSB (=HSV)
Although all screen colours can be produced by varying the R,G and B components,
graphics programmes offer alternative means of adjusting these components that
are intended to be more intuitive. HSB (=HSV), HSL (=HLS) and HSI are three
such spaces devised for this purpose. All three are designed to resemble the
system of hue, lightness and chroma familiar to artists, but all three lack
a true lightness or chroma dimension. Of the three, HSL is perhaps the most
intuitive for colour selection, but HSB is incomparably more powerful for applying
the
principles of colour
,
because its parameters named saturation (
S
) and brightness (
B
)
relate closely to important parameters of colours seen as light. However both
S and B have specific meanings in HSB that differ from absolute brightness and
saturation, and relate instead to the range of possible values in RGB space.
Both parameters are given on a scale of 1 to 100.
RELATIVE BRIGHTNESS (B)
The parameter called
B or "Brightness"
in particular means
something quite different in HSB space to absolute brightness, and will be referred
to here as relative brightness. B measures the brightness of a colour compared
to the maximum possible for
a colour of the same hue and saturation,
which means having the same ratio of R/G/B. The numerical value of
B is given by the brightness of the brightest RGB component as a percentage
of 255. Thus all colours having at least one RGB component equal to 255 are
said to have a brightness of 100. Such colours include white, all pure colours,
and all
tints
(intermediates between white and a pure colour). These
colours are the brightest possible version of their particular RGB ratio; they
form the ceiling of hue-lightness-chroma colour solids such as CIE Lab or YCbCr
(
link
). These colours range
enormously in lightness, from L=100 for white down to a minimum of L = 30 for
"Monitor Blue" (Figure 9.5).
Figure 9.5.
The top row of colours are all at maximum
relative
brightness
(B=100), because in each case they are the brightest possible
version of that pure colour. They vary greatly in
lightness
,
however, as is confirmed by their measured greyscale value (L).
We might expect that for neutral colours the relative brightness of the
light
coming from an area of the screen surface, measured as a fraction of the maximum
possible brightness for the device (R255 G255 B255), should be numerically equal
to the perceived lightness of that
surface
, since this is also
measured relative to maximum screen brightness. Measures of both lightness (L)
and relative brightness (B) appear in the colour picker of Photoshop, and do
move roughly in step with each other for neutral colours (Table 9.1). The numbers
are not exactly equal, however, because of the different formulae used for the
nonlinear transformation of each (see
RGB
Space
).
B
0
10
20
30
40
50
60
70
80
90
100
L
0
9
22
33
43
53
63
73
82
91
100
Table 9.1. Comparison of relative brightness (B) and lightness (L) values
from the Adobe Colour Picker for neutral colours between black (L=0) and white
(L=100)
.
RELATIVE SATURATION (S)
In HSB space Saturation ("S") similarly refers to saturation compared to the
maximum possible in RGB space. It is quantified by in effect considering a colour
to be divided into a coloured component and a white component, and measures
the
proportion of the coloured component to the whole
(Figure 9.4). Colours
are at the maximum saturation (100) when
one or two
of the
RGB values are zero. Fully saturated colours occupy the outward- and downward-facing
planes of a colour space such as CIE Lab and YCbCr.
Figure 9.6. Calculation of Saturation (S) and Brightness (B) for the light
green colour R 102 G 255 B153.
The total amount of light may be thought
of as being split into a white and a coloured component; S is the proportion
of the coloured component of the total. Brightness (B) for this colour is 100,
because it is the brightest possible colour with this ratio of R/G/B.
HSB space is conventionally visualized as an inverted cone or hexagonal pyramid,
in which the vertical axis represents brightness, and the
angle of divergence
from the vertical axis represents saturation (Figure 9.7). Because the vertical
axis is relative brightness, all of the pure colours, tints, and white appear
at the same level, on the the top plane of the solid. If we transform the hexacone
into a space where lightness is the vertical dimension. the pure colours take
their places at their respective tonal levels, and we get a volume of a kind
that we have already seen - in YCbCr. (A similar though slightly different solid
would result if the vertical dimension was CIE lightness rather than Y or luma).
Figure 9.7. Relationship of HSB hexacone to the hue-lightness-chroma space
YCbCr
.
Figure 9.8 summarizes the conceptual relationship between relative brightness
(B) and saturation (S) to lightness and chroma of a surface, for a single-hue
triangle in a hue-chroma- lightness space. The colours F to Z show a range of
intermediate
tints
between "Monitor Red" and White. All have maximum
relative brightness (100), because all are the brightest possible version of
that colour at that saturation. The measured lightness (L) however ranges from
54 for pure red to 100 (by definition) for white. The colours B to F have R
= 51, 102, 153, 204 and 255 respectively; G and B = 0 in all cases. As light,
these colours all have the same (maximum) saturation, because they are all pure
red; in each case, only the red phosphors are glowing. As surfaces, they are
not all equal in chroma however - F is the strongest colour, the one most different
from grey.
Figure 9.8. Left: Conceptual relationship of lightness, absolute brightness,
relative brightness (B), chroma and saturation
. Letters refer to colour
series discussed below. Right all the possible variants of a single hue angle
(H).
Figure 9.9 Intermediate tints between pure red and white
. The colours
are all at maximum
relative brightness
(B=100), because in
each case they are the brightest possible version of red
at that saturation
.
They progressively increase in
lightness
however from left
to right.
Figure 9.9. Intermediate shades between black and pure red
. The colours
are all at maximum
saturation
(S=100), because all are
pure
red. They progressively increase in relative
brightness
and
chroma
however from left to right.
Uniform saturation series such as B to F are of interest because
within such a series, the brightness changes but the ratio of R to G to
B components, and hence the balance of wavelengths, does not change.
They therefore contain the set of colours that we need to represent a
surface of a single colour under different amounts of illumination.
Figure 9.11.  Four examples of uniform saturation (S) series
.
<< 1
2
3
4 >>

---

## Page 094

BRIGHTNESS-BASED COLOUR SPACES 3: HLS (=HSL) AND HSI
Figure 9.12. HLS and HSI colour spaces.
(A) HLS and (B,C) two views
of HSI colour space.Both spaces could be represented with either a circular
or a hexagonal cross section: the crucial difference between HLS and HSI is in the different levels
assigned to the pure colours, resulting from different definitions of "L"
and "I".
HLS and HSI are two other colour spaces encountered in graphics applications
(Figure 9.12).The parameter
L
in HLS space has a particularly tenuous
connection with perceived lightness. It is given by the formula (maximum of
r,g,b - minimum of r,g,b)/2, which results in all fully saturated colours, irrespective
of how light or dark they look, having an L of 0.5. So-called saturation (S)
in HLS is also calculated very differently from S in HSB, and is essentially
the degree of saturation compared to the maximum possible
at a given
value of L
. Thus for example a very pale pink can have an S of 100.
HLS is the colour space used in the
desaturate
command in Photoshop,
which reduces all colours to a grey of the same "L" in HLS, and thus
has an entirely different effect to converting to
greyscale mode
, which
(with far more realism tonally) converts to a grey of the same CIE lightness.HLS
is the basis of the colour picker in Corel Painter (despite the confusing labelling
of the dimensions as H,S and V!).
The pseudo-lightness dimension I in HSI is given by the formula (r+g+b)/3,
which results in Monitor Red, Green and Blue having an I of 0.33, and Monitor
Yellow, Magenta and Cyan having an I of 0.67. Saturation (S) in HSI is calculated
in yet another way from S in HSV and HLS.
<< 1
2
3
4 >>
Next:
Part 10: Principles of
Colour
