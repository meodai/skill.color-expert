# Color Theory's Dogma Problem — Approachable vs. Accurate

**Source:** [Color Nerd](https://www.youtube.com/@ColorNerd1) (YouTube) — Color Wheel Wednesday, episode 27
**Date:** 2026-09-16
**URL:** https://www.youtube.com/watch?v=qQHWBE4ngBA
**Duration:** 8:46
**Subject:** The Jack Richeson color wheel (a stock 12-hue RYB wheel, ~2004) used as a foil for the argument that traditional color theory is a *sigil*, not a tool — and that "easy" and "accurate" are different goals that usually conflict.

Companion episode (the chart being defended): [Why There is No Color Wheel in My Art Classroom](https://www.youtube.com/watch?v=JPNM4nYXhHQ) (ep. 26, 2026-09-09). The framework it leans on: [The Only Color Wheel I Use](https://www.youtube.com/watch?v=EACRRXynk1w) (ep. 9, 2026-05-06, on Bruce MacEvoy's handprint.com pigment chart).

## Description (from the video)

> This week we've got the Jack Richeson Color Wheel: a typical basic, traditional, twelve-hue wheel. It's also, I'll argue, emblematic of a problem in art education: inflexible dogma. A viewer called my own color chart "pretentious nonsense" compared to something like this, so I'm using the comparison to unpack what color wheels are actually supposed to do... and why I think an honest map of color options is a better tool for artists.

## The Core Argument

### 1. "Easy" and "accurate" are two different things

> "Yes, there are a lot of things that are not easy about my color chart, but easy and accurate are two different things, and **easy often gets in the way of accurate**. It's a balance I've struggled with since day one of posting color theory videos online. How can I share the color science I've learned with people in a way that is accessible and approachable? It's tricky. It'll never not be tricky."

The traditional wheel is *easier to read* precisely because it summarizes a fixed set of beliefs in clean geometry. The pigment chart is *harder to read* because it refuses to summarize — it shows where the actual paints in the room sit. The mess is honest: "so is the reality of the actual paints I have in my classroom."

### 2. The traditional wheel is a sigil, not a map

The Richeson wheel gives 12 evenly spaced hues in a circle and encodes a set of abstract beliefs in the geometry: *these* are primaries and form a triad, *these* are secondaries, opposites are complements. "That makes a color wheel like this a kind of sigil, a sign that carries cultural power more than actual useful color theory information."

The mirror observation: to artists who dislike the science-based approach, the scatter-plot chart is *also* a sigil — one whose power comes from "old traumas surrounding math and science." Art was the refuge from the subjects that made people feel stupid; a chart with axes and data reads as a threat.

### 3. "Does it work?" depends on what the job is

From episode 9, the three jobs a color wheel can try to do:

1. **Predict the results of colorant mixtures**
2. **Assess and choose harmonious combinations**
3. **Visualize colors' positions and relationships within a color space**

Most common wheels fail at one or more. The chief failure is the **notion of primary colors** — that RYB are primary, "pure," unmixable from other hues, abstract entities no real pigment perfectly represents. If you accept all of that, the wheel "works" tautologically: it does what it sets out to do. Reject the premises and the wheel is left doing no job well.

### 4. A map is only useful if you ask it something specific

> "Where am I? Where am I trying to go? How do I get there? How far apart are these things really?"

Concrete cases where the wheel and the chart disagree, from the classroom acrylics plotted in OKLAB:

| Question | Traditional wheel says | Chart of actual paints says |
| --- | --- | --- |
| Opposite of red? | Green | Cadmium red, quinacridone red and alizarin crimson (masstone) all sit opposite **cobalt teal**, or slightly bluer |
| Opposite of chrome oxide green? | Red / orange-red | A **purple** |
| Distance yellow→blue vs. yellow→red? | Equal (120° each) | Yellows are **very far** from blues; a line from either yellow to ultramarine crosses the entire color space. For a vivid lime, mix yellow with a nearby green/teal, not "yellow + blue" |
| Can you mix blue? | No — it's primary | Draw a line between a tint of phthalo green and a tint of dioxazine purple: it passes through the **low-chroma blue** region. Green + purple = blue |

"My chart is a more accurate map of visual opposites than the traditional color wheel. And if I'm wrong, then so is a century plus of science that has examined color perception."

### 5. Why "dogma" is the right word

Science is falsifiable and keeps evolving. Traditional color theory's adherents resist attempts to falsify its claims and "are happy with ideas that ossified in the 1830s" — the Richeson wheel "could have come out of a book from like Charles Blanc in 1860." The wheel presents belief as settled fact; the chart presents measurements that could be wrong.

### 6. How the chart is actually used in class

Not lectured. Not a summary of a doctrine. Used as a visual aid when a student asks a specific question about a specific paint. It is *not* a mixing-path predictor — but it lets students see more possibilities than "red, yellow, blue."

## How the Chart Was Made (from episode 26)

1. Swatched every acrylic paint in the supply closet on canvas paper.
2. Scanned each swatch with a **spectrophotometer** → spreadsheet of Lab data.
3. Rejected **CIELAB** for the plot: "it isn't really perceptually even... it doesn't line up with color spaces like the Munsell system."
4. Converted to **OKLAB** using Ottosson's published math in a spreadsheet. The convincing evidence was Ottosson's plots of a Munsell value-5 slice in different spaces: HSV performs worst; OKLAB shows "really even concentric rings of chroma."
5. Cut the swatches out and mounted them on a giant sheet of graph paper on the a/b plane — "the graph paper kind of inspired me to just ditch the circle conceit altogether."

Observations the chart made visible:

- Earth tones cluster in the orange region.
- Quinacridone red and alizarin crimson sit on top of each other.
- Raw umber, burnt umber and the blacks sit much closer together than the old hue-and-chroma chart implied.
- **Some transparent pigments are more chromatic as tints than as masstone**: phthalo green + white lands on par with cobalt teal; cerulean hue ≈ phthalo; green gold's tint gets halfway to yellow.
- Quinacridone magenta's tint and dioxazine purple's tint are neighbors.

The claim carried over from episode 9: a **pigment chart** (à la MacEvoy) is the only "color wheel" the author uses as an artist — it's more practical than wheels that promise harmonies or neutral-mixing pairs, "which are never going to quite work. They're always going to be more theoretical than practical."

## Why This Matters for the Skill

- **Teaching tension:** an accurate answer about color is often harder to hold than the tidy one. When explaining, name the tidy model *and* say where it breaks, rather than choosing one; don't let "approachable" quietly become "wrong."
- **Complements are pigment-specific.** "Red is opposite green" is a category statement; *which* red and *which* green matters. Compute the opposite in a perceptual space (OKLCH hue + 180°) from the actual color, not from its name.
- **Mixing distance ≠ wheel distance.** Yellow→blue is the long road; yellow→red is short (consistent with the "extroverted octopus" mixing paths, see [Briggs](briggs-controlling-colour-history.md)).
- **Tints can exceed masstone chroma** for transparent, dark-valued pigments. Don't assume adding white only reduces chroma.
- **OKLAB over CIELAB for pigment plots** — same conclusion as the OKLAB-vs-Munsell comparisons in [Ottosson's articles](bjorn-ottosson-oklab-articles.md).

## Transcript

It's Color Wheel Wednesday, and take a look at this. It's the Jack Richeson color wheel. It's been around for approximately 20 years and I can't find any information on who designed it or when. But my hunch is Richeson and Company, an art supply distributor based in Wisconsin, created it as a house-brand color wheel for the Richeson School of Art, which they launched around 2004. This bad boy doesn't even have rotating parts or anything. It's like the most cut-and-dry, basic, perfect example of the traditional color wheel. As such, it's going to be the perfect prop for my argument this week.

See, last week I posted a video walking through a chart I made of my classroom paints, and a viewer said this: "So, you took something that worked and made it harder to understand. Visually, this is a mess to try to understand — pretentious and superfluous nonsense." I think I'll put that on my business card.

But seriously, I did want to address this because in a way it gets at the heart of everything I do as an educator. One part of that comment is fair. My chart is harder to understand. It's harder to read than something like this. The Richeson wheel gives you 12 evenly spaced hues around a clean circle with a whole set of abstract beliefs summarized in its geometry. These colors are primary, they make a triad; these colors are secondary, they make a triad; colors on opposite sides are complements, and so on. To me, that makes a color wheel like this a kind of sigil — a sign that carries cultural power more than actual useful color theory information. Whereas my chart is a scatter of blobs with arrows and handwriting all over it. It doesn't summarize a pat set of abstract beliefs about color relationships.

To artists and art teachers that disagree with my approach, this is a kind of sigil too. Its power comes from, perhaps, old traumas surrounding math and science. For many of us in the art field, math and science were the subjects in school that maybe made us feel little and stupid, while art was our refuge. I mean, I always got C's in math and science, and I always got A's in art. So I get it. I get the attitude.

So, yes, there are a lot of things that are not easy about my color chart, but easy and accurate are two different things, and easy often gets in the way of accurate. It's a balance I've struggled with since day one of posting color theory videos online. How can I share the color science I've learned with people in a way that is accessible and approachable? It's tricky. It'll never not be tricky.

To return to the comment that this chart is visually messy: yes, it is visually messy, but, well, so is the reality of the actual paints I have in my classroom. I mean, that's true in every art classroom, isn't it? The paints on hand don't match the story that a wheel like this tells, and I'm just being honest about that.

That brings us to the first part of the comment, the comment that characterizes the traditional color wheel as, quote, "something that works." Most of my critics indeed take the stance that if it ain't broke, I shouldn't fix it. But does it work? To answer this, we need to know what jobs, specifically, a color wheel is supposed to do. I've already outlined in episode 9 of this series what I think color wheels are for. As tools, they aim to solve some combination of the following three problems. Number one: how to predict the results of colorant mixtures. Number two: how to assess and choose harmonious combinations of colors. And number three: how to visualize colors' positions and relationships within a color space.

Most common color wheels fail at these tasks for one or more reasons, and you can watch episode nine for more detail on that. But the chief problem is the whole notion of primary colors. The assumption that primary colors are red, yellow, and blue. That they're somehow pure. That they can't be mixed from other hues. And that they're sort of like these abstract entities that no real pigment perfectly represents. And if you believe all of those things are true, then sure, I guess in a tautological way the color wheel works. It does what it sets out to do, and I therefore shouldn't try to make it harder to understand. But I believe none of those things are true.

So then, say we abandon primary colors and the rest — the question remains, what's my chart actually for? Think about any map: a subway map or a trail map, whatever. A map is only useful if you're asking it something specific. Where am I? Where am I trying to go? How do I get there? How far apart are these things really?

A traditional color wheel tells me that green and red are opposite each other. But which green and which red? My chart shows that in fact cadmium red, quinacridone red, the masstone of alizarin crimson — that is, the versions of red that I have in the room — are all actually opposite cobalt teal, or maybe just bluish of there. Another example: if I want to find the opposite of chrome oxide green, my traditional color wheel will say, well, red, or maybe like orangeish red. But my chart shows it's actually a purple. My chart is more accurate. It's a more accurate map of visual opposites than the traditional color wheel. And if I'm wrong, then so is a century-plus of science that has examined color perception. Which is possible, by the way. They might be wrong, because science is always falsifiable.

And that's another reason, by the way, I often talk about traditional color theory as dogma. Its adherents resist people like me that try to falsify its claims and are happy with ideas that ossified in the 1830s. I mean, this could have come out of a book from like Charles Blanc in 1860, whereas color science is always evolving.

Back to the idea that this is a map for my students. Now, it's not really a color mixing map, but it can help us challenge traditional ideas about primary colors, like the claim that you can't mix blue. If I draw a line between this tint of phthalo green and this tint of dioxazine purple, I cross through the low-chroma blue area. You wouldn't believe how many people I confused on TikTok back in the day by mixing green and purple to make blue. People raised on traditional color theory just can't even imagine it's possible. But my students, hopefully, will be able to see more possibilities.

Let's use the map metaphor one last time. My chart can visualize how far apart colors are in ways that a neat circle can't, because it's forcing them all into the same interval. The traditional wheel, in fact, says yellow and blue are the same distance apart as yellow and red, but that's just not true for my classroom paints. Our yellows are very far away from our blues. If I want a vibrant lime green, I should probably mix a yellow with one of these closer pigments than rely on the traditional rule "yellow and blue makes green" — because if I mix either of these yellows with ultramarine, I have to cross the entire color space.

So, no, my chart is not simpler. It takes a little work, a little practice to learn how to read. But I never stand up here and lecture to the class about what it means and how to read it. They wouldn't listen anyway. Instead, I use it as a visual aid when answering specific questions students ask me about paint. And it's not supposed to be a summary of a dogma like the traditional wheel. It's supposed to be accurate to my students' specific palette options. My hope is it also means my students aren't going to be limited to thinking about mixing as a matter of red, yellow, and blue, even though it doesn't really show mixture paths or predictions.

I know I'll probably never set the debate to rest. There will always be artists who dislike a science-based approach, but if you're interested in learning more, I'll be here.

## Links

- Video: https://www.youtube.com/watch?v=qQHWBE4ngBA
- Channel: https://www.youtube.com/@ColorNerd1
- Ep. 26 — Why There is No Color Wheel in My Art Classroom (the OKLAB paint chart): https://www.youtube.com/watch?v=JPNM4nYXhHQ
- Ep. 9 — The Only Color Wheel I Use (the three jobs of a color wheel; MacEvoy's pigment chart): https://www.youtube.com/watch?v=EACRRXynk1w
- Bruce MacEvoy — handprint.com watercolor pigment charts: https://www.handprint.com/HP/WCL/water.html
- Björn Ottosson — "A perceptual color space for image processing" (the OKLAB math and the Munsell-slice comparison plots): https://bottosson.github.io/posts/oklab/
- Jack Richeson & Co. (Kimberly, Wisconsin): https://www.richesonart.com
- Charles Blanc — *Grammaire des arts du dessin* (1867), the "ossified 1830s–1860s" theory the wheel resembles: https://archive.org/details/grammairedesarts00blan_2
- Charles Blanc — *The Grammar of Painting and Engraving* (1874 English translation, Kate Newell Doggett): https://archive.org/details/grammarpainting00blangoog — local copy: `historical/pdfs/blanc-1874-grammar-of-painting-and-engraving.pdf`

## Related

- [Moses Harris 1769 — Origin of Bad RYB](../historical/moses-harris-1769-color-wheel.md) — where the equal-120° RYB geometry came from
- [RYB vs. CMY Color Wheels](../historical/ryb-vs-cmy-color-wheels.md)
- [Itten's Seven Contrasts — Critical Review](../historical/itten-seven-contrasts-critical-review.md)
- [Color Theory: A Critical Introduction (Fine 2022)](color-theory-critical-fine.md)
- [Everything TikTok Taught Me (CSA)](everything-tiktok-taught-color-theory.md)
- [Björn Ottosson — OKLAB Articles](bjorn-ottosson-oklab-articles.md)
- [Briggs — Controlling Colour: History](briggs-controlling-colour-history.md)
