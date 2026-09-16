# Color Cycling — Animating the Palette, Not the Pixels

**Source:** [Modern Vintage Gamer](https://www.youtube.com/@ModernVintageGamer) (YouTube)
**Title:** The Beauty of Color Cycling in Video Games
**Date:** 2026-09-14
**URL:** https://www.youtube.com/watch?v=k9i17JizmcU
**Duration:** 10:39
**Views:** ~154K (at capture)

## Description (from the video)

> Color Cycling is a classic technique that brought life to early video games and computer art. This episode we examine the mechanics behind Color Cycling, a method used to create animations and visual effects without using extra processing power or memory — and by looking at examples from games like Sonic the Hedgehog and Shovel Knight, we can see how developers maximized the limitations of their hardware. We also break down the technical side of things, specifically focusing on how Amiga bitplanes and computer color palettes functioned to produce these iconic visuals.

## The Technique

**Indexed color** stores a short index per pixel instead of an RGB triple. The index points into a palette (a colour look-up table, CLUT). Change one palette entry and every pixel using that index changes at once, with no pixel data rewritten.

**Color cycling** rotates a *range* of palette entries in sequence (entry 5 → 6 → 7 → … → 5). Because the pixels are laid out so that consecutive indices form a spatial sequence (bands of a waterfall, segments of a sphere, ripples on water), shifting the colors through the indices reads as motion. Zero extra frames, almost zero CPU, a fraction of the storage of frame animation.

**Palette swapping** is the related, discrete operation: replace some or all palette entries in one step. Same sprite data becomes player 2, a stronger enemy, a damaged variant, or a white "hit" flash. A mid-frame swap can tint everything below a waterline blue or green. Mortal Kombat's mirror matches and most 8/16-bit enemy variants are palette swaps.

### Why the Amiga was the platform for it

- **Planar graphics.** Images are built from 1–5 bitplanes on the original chipset; the bits at one pixel position across the planes form the palette index. Common modes: 32 colors from 4,096 (12-bit). **Extra Half-Brite** adds a sixth plane giving 64 colors, the second 32 being automatically half-brightness copies of the first. AGA (A1200/A4000) raised this to 256 from 16.7M. The Amiga never got a native chunky mode.
- **The Copper co-processor** can rewrite palette registers per scanline with almost no CPU involvement, so cycling runs timed to the display, in the background.
- **Deluxe Paint** exposed the hardware directly to artists: multiple independent cycle ranges, each with its own speed and direction, previewed live with the Tab key. Water, fire and metallic shimmer "came for free" while the CPU stayed available for gameplay.

### Canonical examples

| Example | Platform | What cycles |
| --- | --- | --- |
| Boing Ball demo | Amiga | Fixed checker pattern; rotation is a red/white palette range cycling while background and shadow entries stay fixed |
| Mark Ferrari's landscapes (Loom, Monkey Island backgrounds; later Thimbleweed Park) | Amiga / PC (EGA/VGA) / HTML5 | Water, rain, snow, fire, time-of-day, entirely via ordered palette ranges; no animation frames exist |
| Sonic the Hedgehog 3 special stage | Sega Genesis | Rolling checkerboard spheres — palette shifting, not real-time 3D |
| Mickey Mania | Sega Genesis | Pseudo-3D cylindrical floor from cycling colors along single-pixel lines |
| Defender of the Crown, Ports of Call | Amiga | Title screen effects; water surfaces |
| Metamor Jupiter | PC Engine | Background depth/motion via controlled palette shifts |
| SimCity 2000 | PC (chunky) | Flowing rivers and coastlines via palette-driven animation |
| Windows 95 boot screen | PC | A simple cycle in the bottom bar indicates loading |
| Shovel Knight (2014) | modern | Deliberate brief color-cycle flash on enemy damage, referencing 8/16-bit visual language |

### Where it survives

Pro Motion NG (cosmigo) is one of the few modern pixel-art packages that supports genuine palette cycling out of the box. Deluxe Paint still runs under emulation. Joseph Huckaby's HTML5 "Canvas Cycle" demo (2010) reproduces Ferrari's 8-bit scenes with true cycling in the browser, and Ferrari's *Living Worlds* app ports twelve landscapes with their 24-hour time-of-day features to iOS/Android.

## Why This Matters for Color Work

- **It is a color technique, not a graphics hack.** The artist designs a *palette ramp* whose order is also a spatial order. Ferrari's skill is in building 32-entry palettes where each range is a smooth, hue-shifted ramp (dark→blue, light→yellow, as in [pixel-art palette practice](pixel-art-color-palettes.md)) so cycling reads as light moving over a surface instead of bands flickering. Dithering between adjacent indices lets one range serve two textures.
- **Ramp quality is what you see.** A cycling range is a closed loop through color space; if the perceptual steps are uneven, the animation stutters visually even at constant speed. The same flat-derivative test used for [sequential colormaps](viridis-matplotlib-colormap-design.md) applies. Ferrari's "blend" mode (interpolating between palette states) is the software fix for coarse steps.
- **Indexed color as a design constraint** is the same idea as a modern design-token system: pixels reference *roles*, and the palette maps roles to values. Swap the mapping and the whole scene retints consistently. See [Design Book](designbook-reactive-design-token-spec.md) for the same structure applied to UI.
- **Generative/creative-coding use today:** store an index buffer and a small palette, then animate the palette (rotate, ease, or drive from OKLCH hue trajectories with [RampenSau](rampensau-palette-generation.md)). One texture lookup per pixel — the same shape as [LUT color grading](glsl-lut-color-grading.md) — gives frame-independent motion for free.

## Transcript

I was messing around with my Amiga 1200 the other day, playing various scene demos and whatnot, and I stumbled across this slideshow of gorgeous hand-drawn art that was animated, otherworldly, striking, and just perfect. The attention to detail and clarity was impeccable. These pieces were created by artist Mark Ferrari, well known for his artwork in LucasArts adventure games Loom and The Secret of Monkey Island. Despite his lack of computer experience, Ferrari would revolutionize the way video game backgrounds were rendered. He was very skilled at pixel dithering. But what he's best known for, and the topic of today's video, is color cycling: that is, the creation of moving animations without using any extra memory or frames.

Now, given what we know about an Amiga, it's a 7 MHz machine, although this one is a 1200 running at 14 MHz. But ultimately, how is it possible to animate a high-res image running at 640×480 with this level of animation? Well, back in the day, home computers and game consoles had limitations around memory and processing power. So developers and artists would constantly invent workarounds that would let them deliver moving images without the luxury of full-frame animations or large video files. These would come later. And one of the coolest techniques for animating still images was known as color cycling.

The idea itself is pretty straightforward. Instead of redrawing pixels, what you do is you just change the color that those pixels point to. On limited hardware like the Amiga, this was very efficient. A single static image could appear to move, shimmer, or flow, and there was almost zero CPU time and a fraction of the storage that a conventional animation would require.

The technique itself depends on indexed color, which means rather than storing a full RGB value for every pixel like a conventional frame buffer, each pixel holds a short index that refers to an entry in a color palette. Alter one palette entry and every pixel that uses that index updates at once. And when you cycle a range of these entries in sequence, the eye interprets shifting colors as movement.

The Amiga was particularly well suited for this approach because of the way its graphics system handled color. Unlike what we saw on the PC with its chunky format, the Amiga used a planar system. Images were built from multiple bitplanes, typically between one and five on the original chipset, and each combination of bits across these planes formed an index into a color palette. The most common low-resolution mode that artists could choose from was 32 colors from a palette of 4,096. There was a sixth bitplane, or an Extra Half-Brite mode, that extended to 64 colors by automatically generating a darker version of the first 32, and later machines like the Amiga 1200 raised that limit to a full 256 colors selected from more than 16 million. But the majority of Amiga games on the original chipset ran with just 16 or 32 colors. And for better or for worse, the Amiga would never see native chunky graphics, maintaining its planar format for the entire generation.

But this in turn would make color cycling on the Amiga a useful technique for both artists and developers. Because every visible pixel is just an index, changing the actual color values in the palette registers updated the entire screen instantly. The Amiga's co-processor, or Copper, made this even more powerful. It could rewrite palette entries on a per-scanline basis with almost no CPU involvement. So color changes could be timed precisely to the display and run in the background.

And one of the killer apps of the Amiga, Deluxe Paint, exposed this capability directly to artists. They could define multiple independent cycling ranges, set different speeds and directions for each, and with a simple press of the Tab key, these results could be previewed in real time. This effect came for free on the Amiga. Water could ripple, fire could flicker, and metallic surfaces could shimmer while the processor remained free for gameplay and other graphics work. The combination of a flexible indexed palette combined with Copper hardware register changes and artist-friendly software like Deluxe Paint is one of the reasons why so many memorable color cycling examples originated on the Amiga.

And perhaps one of the most popular demonstrations of continuous color cycling is the Boing Ball demo. What appears to be a three-dimensional sphere spinning across the screen is actually a fixed pattern. The rotation is produced entirely by cycling a block of red and white palette entries while a handful of background and shadow colors remain fixed.

But color cycling was not exclusive to the Amiga. The same approach also appears in various console games. For example, the special stage in Sonic the Hedgehog 3 on the Sega Genesis. The distinctive rolling checkerboard spheres rely on precisely the same palette-shifting method, which turns a static graphic into a convincing rotating surface on hardware that had no dedicated 3D capability — if you've convinced yourself all these years that this is a real-time technique.

Now, fellow YouTuber RobSmithDev did a very good breakdown about recreating this effect using AMOS on the Amiga: "If I re-render the ball and split each segment into eight strips, and then I give each of those eight strips a different color, then we can use a special trick to animate this. Loading this into AMOS and issuing the shift down command, you can instantly see it starts moving. This command is cycling the palette. If I stop it and change the palette to be black and red, you get this. And finally, white and red, and you get the familiar Boing Ball. I'll show you this in Deluxe Paint so you can see what's happening. First by setting the range and then hitting the Tab key to start the cycling. As you can see, nothing's actually moving. We're just changing the palette. By simply generating a strip of palette entries means that it's possible to cycle the colors. And then just by setting this palette to red and black, you can see that this effect has quickly come to life."

The color cycling technique would spread rapidly through games. Defender of the Crown used it on its title screen and for the environmental effects throughout. Ports of Call and other titles employed it for convincing water surfaces. On the Genesis, Mickey Mania contains a memorable sequence in which a pseudo-3D cylindrical floor is created by cycling colors along carefully arranged single-pixel lines. The PC Engine would also make effective use of this method. In Metamor Jupiter, some of the later background stages employ sequences that depend on controlled palette shifts to add depth and motion. Even on the PC with its chunky graphics, SimCity 2000 employed palette-driven animation for its water to allow for rivers and coastlines to flow and reflect without the memory overhead and processing of traditional multi-frame sequences.

But we have to go back to Mark Ferrari. Across his background work for LucasArts titles and later projects such as Thimbleweed Park, Ferrari would construct entire images with water and weather effects driven entirely by color cycling. His images contain no animation frames at all, only a precisely ordered palette. Did you even know the Windows 95 boot screen contains a simple cycle indicating that the operating system was loading?

Closely related but distinct is palette swapping. Where color cycling continuously rotates a range of colors to create ongoing motion, palette swapping replaces some or all of the palette entries in a single step. The underlying graphics data stays exactly the same; only the colors they point to will change. And this was also an extremely efficient way to create visual variety without storing extra artwork. The same sprite could become the second-player character, a stronger enemy, or a damaged version of itself by simply loading a different set of palette values. The famous mirror matches in the Mortal Kombat games indicate a second-player character that has its palette swapped. And on consoles, it could be used for environmental effects. A mid-frame palette swap could tint everything below a waterline to make it blue or green, or flash a character white when hit, all without altering a single pixel of the source art.

These days, of course, as hardware capacities increased, the need for techniques such as color cycling has diminished. However, there are some deliberate homages, such as Shovel Knight, where Yacht Club Games trigger a brief color cycle flash when enemies take damage, a reference to the visual language of the 8- and 16-bit era. And today, very few tools still expose genuine palette cycling, but there are some websites where you can certainly tinker around with the effect and build your own color cycling techniques, which is pretty cool. Packages such as Pro Motion still remain among the few that support it out of the box. And of course, you can always use Deluxe Paint.

What remains striking is how much visual richness was extracted from such a minimal mechanism. The constraints of the time forced a particular kind of ingenuity, and the results can look absolutely incredible. But that's going to do it for today's episode. What is your favorite example of color cycling that you remember in a game or artwork that you've seen in the past? As always, thanks for watching, and we'll catch you in the next episode.

## Links

- Video: https://www.youtube.com/watch?v=k9i17JizmcU
- Channel: https://www.youtube.com/@ModernVintageGamer
- Mark Ferrari — site, Living Worlds app, Thimbleweed Park art: https://www.markferrari.com/
- Mark Ferrari — GDC 2016 talk "8 Bit & '8 Bitish' Graphics — Outside the Box" (the definitive first-person account of the technique): https://www.youtube.com/watch?v=aMcJ1Jvtef0
- Joseph Huckaby — Canvas Cycle: True 8-bit Color Cycling with HTML5 (Ferrari's scenes, live, with speed/blend controls): https://www.effectgames.com/demos/canvascycle/
- Amiga Graphics Archive — Color Cycling specials (dozens of IFF images with cycle ranges, Deluxe Paint 1989 onward, Boing Ball, Defender of the Crown, Ports of Call): https://amiga.lychesis.net/specials/ColorCycling.html
- GameHut — Mickey Mania's "Impossible" 3D Chase, How Was It Done? (cited in the video): https://www.youtube.com/watch?v=nt-AxAqlrOo
- RobSmithDev — How Bunny's "Boing Ball" Bounty was made (AMOS + Deluxe Paint cycling demo, cited in the video): https://www.youtube.com/watch?v=Mb1xrYORwuY&t=137s
- Pro Motion NG (cosmigo) — modern pixel-art editor with palette cycling: https://www.cosmigo.com/

## Related

- [Pixel Art Color Palettes](pixel-art-color-palettes.md) — hue-shifted ramps, the palettes that cycle well
- [Pixel Parmesan — Color Theory for Pixel Artists](pixel-parmesan-color-theory-pixel-artists.md)
- [Kensler — Palette Generation, Mapping & Dithering](kensler-palette-generation-mapping-dithering.md) — building and mapping small palettes
- [glsl-lut — LUT Color Grading](glsl-lut-color-grading.md) — the same index→palette lookup on the GPU
- [Viridis — flat perceptual derivative](viridis-matplotlib-colormap-design.md)
- [Acerola — Your Colors Suck](../contemporary/your-colors-suck-acerola.md) — palette swapping in a modern pipeline
