# Pixar in a Box — Color Science (Khan Academy)

**Source:** [Khan Academy Labs](https://www.youtube.com/@KhanAcademyLabs) / Pixar in a Box (YouTube)
**URLs:** see individual lessons below
**Duration:** 2:49
**Views:** 81,281
**Series:** Pixar in a Box — Color Science (Color 101)

## Description

Brief, accessible introduction to the RGB color model from Pixar's color science team. Part of a larger Khan Academy series on color science for animation.

## Transcript

We've just seen the beautiful rainbows you get when you refract light with a prism. Now let's think about how we actually perceive the colors of the rainbow in the first place. What makes yellow look like yellow?

Inside our eyes we have special color receptors called cones that are sensitive to specific wavelengths of light. For example, one kind of cone is most sensitive to red light — so when long wavelength light hits them, that is from the red end of the spectrum, they respond by sending a corresponding electrical signal to the brain. And the magnitude of this signal will depend on how much red light is present in the light.

Our eyes have three main kinds of color receptors: one is sensitive to the longer wavelengths (redder light), one for medium wavelengths (greener light), and one for shorter wavelengths (bluer light). The cool trick is our brain blends signals from these three receptors to represent any color.

Color television and computer monitors borrowed this same idea of color receptors from our eyes. If you zoom into a computer screen you'll see it's made up of tiny rectangles or pixels, each of which contain a red, green, and blue region. To display colors, the monitor illuminates these three colors accordingly. To make the screen appear yellow, the monitor turns on only the red and green regions in each pixel — from far away these blend into yellow.

And that's how we can digitally create any color using just different amounts of red, green, and blue.

It's interesting to note that other animals have different cones in their eyes. For example, dogs only have cones that are sensitive to yellow and blue, so red light doesn't send signals to their brain at all. The mantis shrimp on the other hand holds the current record for the most number of color receptors in its eyes — 12 different kinds, and scientists still don't know how they're all used to perceive color.

Beyond that, there's also a certain class of people — they're all female as it turns out — who we call tetrachromats. They have four different color receptors in the eye, whereas the vast majority of the population has three. And so we think that their ability to discriminate colors — to basically tell the difference between two very similar shades — is probably much more precise for the tetrachromats. I wish I was one.

## Key Concepts

- **Three cone types:** L (long/red), M (medium/green), S (short/blue) — brain blends their signals
- **RGB monitors mimic cone architecture:** pixels have R, G, B subpixels; additive mixing from distance
- **Yellow on screen = red + green subpixels** — no yellow light emitted
- **Other animals:**
  - Dogs: 2 cone types (yellow + blue) — dichromatic
  - Mantis shrimp: 12 cone types — purpose still unknown
  - Human tetrachromats: 4 cone types (all female) — enhanced color discrimination

## Full Pixar Color Science Series (Khan Academy)

| Lesson                 | URL                                                                           |
| ---------------------- | ----------------------------------------------------------------------------- |
| Spectrum of Light      | https://www.khanacademy.org/computing/pixar/color/color-101/v/colorscience-1  |
| RGB Color Model        | https://www.khanacademy.org/computing/pixar/color/color-101/v/color-2         |
| Color Science overview | https://www.khanacademy.org/computing/pixar/color/color-101/v/color-science-1 |
| Color Contrast         | https://www.khanacademy.org/computing/pixar/color/color-101/v/color4-master   |
| Color Correction       | https://www.khanacademy.org/computing/pixar/color/color-101/v/color5-final    |
| Full course page       | https://www.khanacademy.org/computing/pixar/color                             |

## Links

- **Khan Academy — Pixar Color Science:** https://www.khanacademy.org/computing/pixar/color

---

## Lesson: Spectrum of Light

**URL:** https://www.youtube.com/watch?v=0vJOkO43KI4
**Duration:** 3:45 | **Views:** 98,003

### Transcript

You may be surprised that there is such a thing as a color scientist, but at Pixar color plays a role in almost every artistic decision that we make. While this lesson will focus on the science of color, there is obviously a whole world of color that artists think about.

Here we are in the color mastering suite — the equipment that we use is basically a supercomputer version of Photoshop, but it kind of looks a little bit like the Star Trek Enterprise. My goal in this lesson is to show you that color is really part physics and part human perception.

Color is a property of light, and light comes from light sources. There are all different kinds of light sources — for example, I'm currently being lit by these lamps. Using a flame as our light source like these two candles really changes the feel of the scene. The light is not only dimmer but it emits a reddish orange light.

The key is to think of all light as a mixture of colors. Sir Isaac Newton famously demonstrated this when he used a glass prism to break up sunlight. When sunlight passes in and out of the prism it bends or refracts and splits up into a spectrum of colors. After Newton, other scientists discovered that the light's wavelength is what determines how much it will refract and what color it will be. Bluer light has a shorter wavelength and bends more; red light with longer wavelengths bends less.

Sunlight looks white because it contains all visible colors. Scientists have developed a 2D graph to easily visualize the colors contained in any given light source. Along the x-axis is the wavelength and along the y-axis is the intensity of that wavelength. This is known as the **spectral power distribution**.

Here's the spectral power distribution of daylight. And here's the spectral power distribution of candle light — notice it doesn't contain the same intensity of blue and green wavelengths. If we shine candle light through a prism we can't see a full rainbow — the reds are strong but the blue wavelengths are much weaker.

### Key Concepts

- **Color = property of light** — part physics, part human perception
- **Spectral power distribution (SPD)** — 2D graph: wavelength (x) vs intensity (y) for any light source
- **Daylight SPD** — broad, relatively flat across visible spectrum → white
- **Candle light SPD** — weak in blue/green, strong in red → reddish orange
- **Prism refraction** — shorter wavelengths (blue) bend more, longer (red) bend less
- **White light** = contains all visible wavelengths

---

## Lesson: HSL Color Model

**URL:** https://www.youtube.com/watch?v=Ceur-ARJ4Wc
**Duration:** 2:16 | **Views:** 82,624

### Transcript

You've just seen how any color can be represented by blending together different amounts of three colors — red, green, and blue. For example, the RGB value of this gold color is 100% red, slightly less green, and no blue. But as you may have noticed, it's fairly difficult to find the correct RGB values to match a desired color. So artists have developed new ways to specify colors in a more intuitive way.

One popular method they use is called HSL — short for hue, saturation, and lightness (similar to the HSV we saw earlier). Artists use a tool called a color wheel to pick the hue and saturation they like.

**Hue** is what we normally call "color" — it's based on the position around the wheel, such as this red.

**Saturation** defines how pure a color is, based on the distance from the center of the wheel. If we want to desaturate we move inward; if we want to saturate we move outward. For example, to saturate this shade of red we remove any contribution of green and blue, whereas to desaturate we instead increase the contribution of green and blue. Taken to the extreme, this trends towards gray because the three color contributions are equal. So at full desaturation our red becomes achromatic or colorless.

**Lightness** is adjusted using a separate slider. For example, we can take our yellow from very low lightness to a very high lightness.

You can already see that this is a much more intuitive way of finding colors compared to using RGB values.

### Key Concepts

- **HSL** = Hue (position on wheel) + Saturation (distance from center) + Lightness (separate slider)
- **More intuitive than RGB** for finding/matching colors
- **Desaturation** = increasing equal contributions of all three RGB channels → trends toward gray
- **Achromatic** = fully desaturated = colorless (equal R, G, B)
- Note: this is the basic intro; doesn't cover HSL's perceptual non-uniformity issues (see HSLuv entry)

---

## Lesson: Color Contrast

**URL:** https://www.youtube.com/watch?v=bHVZNSD9r2s
**Duration:** 3:48 | **Views:** 59,675

### Transcript

So far we've been talking about color in terms of wavelength of light and human color receptors — that's the physics part of color. Now let's turn to the perceptual part.

We just learned that every color has a hue, saturation, and lightness. But colors appear in our world alongside other colors, and that can really affect how they appear — it's also when things can get really, really weird.

For example, look at this image. Notice the two inner color rings — the one on the left looks green, the one on the right looks blue. They're different colors, right? Nope. If you take away the other colors, you'll see that they are in fact the same color.

And it's not only color which can trick us. Different brightness levels will also affect how we perceive an image. Look at the following grayscale image — take a closer look at squares A and B. One is a black square in the light, the other is a light square in shadow. Do you think they are different shades of gray? Nope — they are in fact the same shade of gray.

So clearly not everything is what it seems. How we perceive contrast or brightness depends very much on the surrounding image. The structure of our visual system is optimized so that we can do important things like survive. A key survival trait is the ability to very quickly identify danger — this requires the ability to rapidly refocus our attention when we need to. Our brain does this by automatically refocusing our attention to dramatic changes in color, brightness, or movement. We call this difference in color or illumination "contrast." Our brains are hardwired to notice when the colors contrast with each other.

In the color mastering suite we can adjust the contrast of an entire image using a contrast slider — it works by increasing or decreasing the differences in brightness across the image.

Getting this contrast level right is really important in Pixar movies. For example, at the end of Inside Out, the character Anger gets really angry, and to heighten this sense of flames exploding from his head, the surrounding area of the image is darkened so that the contrast difference is really quite extreme.

Another great example is from Toy Story 3 — Lotso the bear has been the only really pink thing in the scene. It's very much about an emotion of love between Lotso's owner and the bear. Then as the bear is lost, there's a scene where Lotso is looking in the window at his owner and the replacement bear. What we're trying to do there is have Lotso seem less pink than the new bear, which is very much the center of attention of love. Heightening that perception of the difference between how pink each of them are was very much central to the emotion.

### Key Concepts

- **Simultaneous contrast** — surrounding colors change how we perceive a color (same color looks green or blue depending on context)
- **Checker shadow illusion** — squares A and B are the same gray but look different due to surrounding brightness context
- **Contrast = difference in color or illumination** — brains are hardwired to notice it (survival mechanism)
- **Pixar uses contrast for storytelling:**
  - _Inside Out:_ darken surroundings to make Anger's flames contrast extremely
  - _Toy Story 3:_ make Lotso less pink than replacement bear to shift emotional focus
- **Director of Photography (DP)** makes all color/lighting decisions in Pixar films

---

## Lesson: Color Correction

**URL:** https://www.youtube.com/watch?v=FbQ4MO-qq8g
**Duration:** 3:04 | **Views:** 50,616

### Transcript

One of the final polishing steps in making a film is the final color adjustments to every single frame of the film in order to increase its impact on the audience — and that's exactly what we do here in the color mastering suite.

Colorist Mark DiNicola operates the color mastering system — a colorist is responsible for actually making all adjustments to a finished film. For example, on a shot from Ratatouille, we might start by adding contrast, then add some saturation. Normally when I do this, the DP is sitting here with me.

Sharon Calahan, DP on Ratatouille: "Ratatouille was a film that had a very unique stylized look. A lot of it is just carrying it all the way through to make sure the final product has that vision in it. Some of those things were having nice rich shadows, making sure there's adequate contrast and saturation, making sure the eye looks where it's supposed to look.

Stylistically, one of the things that was really important to me was making the human skin look good and the food look really good and tying it all together. One of the ways I use color correction to help with that is to add a little bit of red to the deep darks — so that it kind of tied the look together and almost made the film feel like it was dipped in chocolate a little bit. I wanted the audience to leave feeling hungry."

### Key Concepts

- **Color correction** — final polishing step applied to every frame of a finished film
- **Colorist** (Mark DiNicola) operates the mastering system; **DP** (Sharon Calahan) directs the creative vision
- **Tools:** contrast slider, saturation slider, HSL adjustments; can select entire image or specific regions
- **Ratatouille technique:** added red to deep darks → "dipped in chocolate" feel; made skin and food look appealing
- **Region-based correction** — adjust only selected areas while leaving the rest untouched
- **Goal:** increase emotional impact on audience through color

---

---

## Bonus: Getting to Know Dominic Glynn (Pixar Color Scientist)

**URL:** https://www.youtube.com/watch?v=auZL8CuHXUU
**Duration:** 5:51 | **Views:** 37,012

### Key Points

- **Background:** computer systems engineering + music → color science ("a little math and a little perception, smash them together")
- **Retinal hemorrhage** at high altitude during mountaineering → became fascinated with his own damaged visual system, comparing left vs right eye → pivoted to studying human vision
- **35mm film era at Pixar:** film chemistry was a "black art" — Pixar went back to first principles, analyzed film at low level, pushed/pulled exposures, measured everything until they knew more than the film manufacturers about how to control color on film
- **His role:** communicates with DPs and lighting leads 1-3 years in advance; translates artistic vision into repeatable color pipelines and processes
- **Laser projectors:** next-gen cinema uses RGB lasers → can create extremely saturated colors "way out on the spectral locus" — potentially showing audiences colors they've literally never seen before
- **Advice:** "everything that you have a passion for has a value in this world"

### Key Concepts

- **Color science = math + perception** — engineering background provides tools to learn at speed
- **Film color control** — understanding the medium at a deeper level than its manufacturers
- **RGB laser projection** — can reach spectral locus colors (most saturated colors humans can perceive)
- **Color pipeline design** — building foundations years in advance so artists can express themselves repeatably under time pressure

---

## Lesson: CIE Chromaticity Diagram (Color Space section)

**URL:** https://www.youtube.com/watch?v=SDLHsGVeR2Y
**Duration:** 1:33 | **Views:** 61,872

### Transcript

Now let's return to the human eye for a moment. Remember the human eye is the sensor which light must pass through to be perceived, so we need to understand the limit of the human visual system.

In the 1920s, experiments were done to map the color space perceivable by humans — from purple all the way around the rainbow to this red. This defines all colors of a single wavelength. These are known as spectral colors. And inside this region we have all combinations of those pure colors.

Scientists plotted the limit of the pure colors we can perceive. Notice it takes this funny-looking shape. One reason this shape is useful is something called perceptual uniformity — that's a fancy way of saying that we can find the mixture of two colors, such as this red and this green, by simply looking at the midpoint of them right here.

It's known as the CIE chromaticity diagram. CIE refers to the scientific group that published the findings.

Compare this to the hue-saturation color wheel, which is NOT perceptually uniform. Pure red is here, pure green is here, but the middle of these two points is not pure yellow at all — it's a very desaturated yellow.

### Key Concepts

- **CIE chromaticity diagram** — maps all colors perceivable by humans; the funny shape defines spectral color limits
- **Spectral colors** — pure single-wavelength colors forming the outer boundary (spectral locus)
- **Perceptual uniformity** — midpoint of two colors on the diagram approximates their mixture
- **HSL wheel is NOT perceptually uniform** — midpoint of red and green on the HSL wheel ≠ yellow; it's desaturated yellow
- Note: the CIE 1931 diagram is only approximately perceptually uniform — CIELUV/CIELAB were later improvements

_This completes the full Pixar in a Box: Color Science series (5 core lessons + bonus + color space lesson)._
