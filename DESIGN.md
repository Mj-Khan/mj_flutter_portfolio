---
name: MJ Flutter Portfolio
colors:
  # ── Light theme ──────────────────────────────────────────────
  scaffold-light: "#F3F7F4"        # warm white-green tint
  accent1-light: "#22C55E"         # vibrant green
  accent2-light: "#0EA5E9"         # sky blue

  # ── Dark theme ───────────────────────────────────────────────
  scaffold-dark: "#0C1010"         # deep forest black
  accent1-dark: "#4ADE80"          # bright lime-green
  accent2-dark: "#38BDF8"          # lighter sky blue

  # ── Background blobs (dark theme) ────────────────────────────
  blob1a: "rgba(34, 197, 94, 0.157)"    # green blob outer
  blob1b: "rgba(34, 197, 94, 0.063)"    # green blob inner
  blob2a: "rgba(14, 165, 233, 0.157)"   # sky blob outer
  blob2b: "rgba(14, 165, 233, 0.063)"   # sky blob inner
  blob3a: "rgba(74, 222, 128, 0.102)"   # lime accent blob outer
  blob3b: "rgba(74, 222, 128, 0.039)"   # lime accent blob inner
  blob4a: "rgba(14, 165, 233, 0.102)"   # right-side blue outer
  blob4b: "rgba(14, 165, 233, 0.020)"
  blob5a: "rgba(34, 197, 94, 0.082)"    # right-side pale green outer
  blob5b: "rgba(34, 197, 94, 0.020)"
  blob6a: "rgba(56, 189, 248, 0.082)"   # sky accent outer
  blob6b: "rgba(56, 189, 248, 0.020)"
  blob7a: "rgba(74, 222, 128, 0.063)"   # far-corner faint lime outer
  blob7b: "rgba(74, 222, 128, 0.008)"

  # ── Text & UI ─────────────────────────────────────────────────
  text-muted: "#9E9E9E"            # secondary labels, captions (~grey 500)
  text-sub: "#757575"              # tertiary text (~grey 600)
  drawer-handle: "#BDBDBD"         # mobile sheet drag handle (~grey 400)
  available: "#22C55E"             # "Open to Work" status indicator

  # ── Glass system ──────────────────────────────────────────────
  glass-border-default: "rgba(255, 255, 255, 0.15)"
  glass-border-hover: "rgba(255, 255, 255, 0.30)"
  glass-fill-dark-start: "rgba(255, 255, 255, 0.08)"
  glass-fill-dark-end: "rgba(255, 255, 255, 0.03)"
  glass-fill-light-start: "rgba(255, 255, 255, 0.35)"
  glass-fill-light-end: "rgba(255, 255, 255, 0.15)"
  glass-shadow-dark: "rgba(0, 0, 0, 0.55)"
  glass-shadow-light: "rgba(0, 0, 0, 0.12)"

  # ── Dividers & borders ────────────────────────────────────────
  divider-light: "rgba(0, 0, 0, 0.05)"
  divider-dark: "rgba(255, 255, 255, 0.08)"
  rail-border: "rgba(158, 158, 158, 0.20)"   # left-rail right border
  topbar-border: "rgba(128, 128, 128, 0.10)"

  # ── Cursor spotlight ─────────────────────────────────────────
  cursor-glow-core: "rgba(accent1, 0.10)"
  cursor-glow-mid: "rgba(accent1, 0.04)"

  # ── Semantic overlays ─────────────────────────────────────────
  skill-chip-dark: "rgba(255, 255, 255, 0.07)"
  skill-chip-light: "rgba(0, 0, 0, 0.05)"
  skill-chip-border: "rgba(accent1, 0.25)"
  tag-chip-dark: "rgba(255, 255, 255, 0.05)"
  tag-chip-light: "rgba(0, 0, 0, 0.04)"
  availability-fill: "rgba(34, 197, 94, 0.12)"
  availability-border: "rgba(34, 197, 94, 0.35)"
  icon-tile-fill: "rgba(accent1, 0.12)"
  contact-rule-fade: "rgba(accent1, 0.5) → rgba(accent2, 0.0)"

typography:
  display:
    fontFamily: Inter
    fontSize: 64px
    fontWeight: "800"
    lineHeight: 1.1
    letterSpacing: "-0.01em"
  heading-xl:
    fontFamily: Inter
    fontSize: 52px
    fontWeight: "800"
    lineHeight: 1.15
  heading-lg:
    fontFamily: Inter
    fontSize: 36px
    fontWeight: "600"
    lineHeight: 1.3
  heading-md:
    fontFamily: Inter
    fontSize: 22px
    fontWeight: "700"
    lineHeight: 1.4
  heading-sm:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: "600"
    lineHeight: 1.4
  body-lg:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: "400"
    lineHeight: 1.8
  body-md:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: "500"
    lineHeight: 1.5
  body-sm:
    fontFamily: Inter
    fontSize: 15px
    fontWeight: "400"
    lineHeight: 1.6
  label-lg:
    fontFamily: Inter
    fontSize: 17px
    fontWeight: "400"
    lineHeight: 1.35
  label-md:
    fontFamily: Inter
    fontSize: 15px
    fontWeight: "600"
    lineHeight: 1.35
  label-sm:
    fontFamily: Inter
    fontSize: 13px
    fontWeight: "500"
    lineHeight: 1.35
  caption:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: "600"
    letterSpacing: "3px"
    lineHeight: 1.2
  overline:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: "600"
    letterSpacing: "2.5px"
    lineHeight: 1.2

spacing:
  unit: 8px
  xs: 4px      # 0.5u
  sm: 8px      # 1u
  md: 16px     # 2u
  lg: 24px     # 3u
  xl: 40px     # 5u
  2xl: 48px    # 6u
  3xl: 80px    # 10u
  4xl: 120px   # 15u  (inter-section gap)
  section-padding-desktop: "80px (top) / 80px (left) / 120px (right)"
  section-padding-mobile: "40px (top) / 32px (horizontal)"
  card-padding: 40px
  rail-padding: "44px (horizontal) / 56px (vertical)"
  topbar-padding: "28px (horizontal) / 18px (vertical)"
  drawer-padding: "32px (horizontal) / 40px (vertical)"

radii:
  sm: 2px
  md: 10px
  lg: 14px
  xl: 20px
  card: 24px
  pill: 9999px
  sheet: 28px
  toggle: 30px
  icon-tile: 10px
  chip: 20px

elevation:
  blob-layer:
    description: Animated radial-gradient circles; no shadow; lowest layer
  glass-card-default:
    background: "linear-gradient(glass-fill-*-start, glass-fill-*-end)"
    border: "1px solid glass-border-default"
    shadow: "0 10px 20px glass-shadow-*"
    blurRadius: 20px
  glass-card-hover:
    border: "1px solid glass-border-hover"
    shadow: "0 10px 40px glass-shadow-*"
    blurRadius: 40px
  cursor-glow:
    description: "500dp radial gradient centred on cursor; 3-stop: core→mid→transparent"

motion:
  blob-loop:
    duration: 20000ms
    easing: linear
    repeat: infinite
    amplitude: 55px          # sinusoidal drift per blob
    parallax-factor: 80      # mouse-offset multiplier in logical pixels
  entrance-rail:
    duration: 630ms           # 0.0–0.7 of 900ms controller
    easing: easeOut
    from: "translateX(-4%)"
    to: "translateX(0)"
  entrance-content:
    duration: 765ms           # 0.15–1.0 of 900ms controller
    easing: easeOut
    from: "translateY(3%)"
    to: "translateY(0)"
  scroll-reveal:
    duration: 700ms
    easing: easeOut
    trigger: "element top enters 92% of viewport"
    from: "fade(0) + translateY(6%)"
    to: "fade(1) + translateY(0)"
    delay-step: 100ms         # sequential section delays (0, 100, 200, 300ms)
  glass-card-hover:
    duration: 300ms
    easing: easeInOut
    properties: border-color, box-shadow
  cta-button-hover:
    duration: 200ms
    easing: easeInOut
    properties: background-color, border-color, color
  nav-link-indicator:
    duration: 250ms
    easing: easeInOut
    properties: width, font-weight, color  # indicator bar expands 14→24px
  theme-toggle:
    duration: 400ms
    easing: easeInOut
    properties: gradient, thumb-position
  scroll-to-section:
    duration: 600ms
    easing: easeInOut

components:
  glass-card:
    background: "linear-gradient(180deg, glass-fill-*-start, glass-fill-*-end)"
    border: "1px solid glass-border-default"
    borderRadius: "{radii.card}"
    padding: "{spacing.card-padding}"
    shadow: "0 10px 20px glass-shadow-*"
    hoverShadow: "0 10px 40px glass-shadow-*"
    hoverBorder: "1px solid glass-border-hover"
    transition: "{motion.glass-card-hover}"
  button-primary:
    background: "accent1 @ 85% opacity"
    hoverBackground: "accent1 @ 100% opacity"
    textColor: "#FFFFFF"
    borderRadius: "{radii.lg}"
    paddingHorizontal: 28px
    paddingVertical: 16px
    typography: "{typography.label-md}"
    transition: "{motion.cta-button-hover}"
  button-ghost:
    background: transparent
    border: "1.5px solid accent1 @ 35% opacity"
    hoverBorder: "1.5px solid accent1 @ 70% opacity"
    textColor: "on-surface (70%)"
    hoverTextColor: accent1
    borderRadius: "{radii.lg}"
    paddingHorizontal: 28px
    paddingVertical: 16px
    typography: "{typography.label-md}"
    transition: "{motion.cta-button-hover}"
  nav-link:
    indicatorWidth-default: 14px
    indicatorWidth-active: 24px
    indicatorHeight: 2px
    indicatorRadius: "{radii.sm}"
    paddingVertical: 13px
    typography-default: "{typography.label-lg}"
    typography-active: "{typography.label-lg} fontWeight 600"
    color-default: "#9E9E9E"   # grey 500
    color-hover: "on-surface 70/87%"
    color-active: accent1
    transition: "{motion.nav-link-indicator}"
  skill-chip:
    background: "skill-chip-dark/light"
    border: "1px solid skill-chip-border"
    borderRadius: "{radii.chip}"
    paddingHorizontal: 12px
    paddingVertical: 6px
    typography: "{typography.label-sm}"
  tag-chip:
    background: "tag-chip-dark/light"
    borderRadius: "{radii.chip}"
    paddingHorizontal: 12px
    paddingVertical: 6px
    typography: "{typography.label-sm}"
  icon-tile:
    size: 36px
    borderRadius: "{radii.icon-tile}"
    background: "accent1 @ 12–14% opacity"
    iconSize: 18px
    iconColor: accent1
  availability-badge:
    background: "rgba(34, 197, 94, 0.12)"
    border: "1px solid rgba(34, 197, 94, 0.35)"
    borderRadius: "{radii.pill}"
    paddingHorizontal: 10px
    paddingVertical: 4px
    dotSize: 6px
    dotColor: "{colors.available}"
    typography: "{typography.caption} fontSize 11px"
  avatar:
    shape: circle
    background: "radial-gradient(accent1, accent2)"
    personColor: "rgba(255,255,255,0.92)"
    description: Custom-painted silhouette (head + shoulders)
  theme-toggle:
    width: 70px
    height: 36px
    borderRadius: "{radii.toggle}"
    background: "linear-gradient(accent1, accent2)"
    thumbSize: 28px
    thumbColor: "#FFFFFF"
    thumbShape: circle
    transition: "{motion.theme-toggle}"
  bottom-sheet:
    borderRadius: "{radii.sheet} (top corners only)"
    background: scaffold-*
    border: "1px solid divider-*"
    handleWidth: 40px
    handleHeight: 4px
    handleRadius: "{radii.sm}"
    handleColor: "{colors.drawer-handle}"
  timeline-row:
    yearColumnWidth: 160px
    gap: 40px
    cardComponent: glass-card
  contact-rule:
    height: 1px
    gradient: "linear-gradient(accent1@50%, accent2@0%)"
  gradient-text:
    technique: ShaderMask with LinearGradient(accent1, accent2)
    usedIn: hero-headline, contact-headline
---

## Brand & Style

This is a **dark-first, glassmorphic portfolio** for a senior Flutter / mobile engineer. The overall feel is "premium dev tool meets editorial portfolio" — clean, quiet, and technically self-assured. There are no decorative illustrations or stock images; every visual element is constructed in code (blobs, avatar, gradient text, card surfaces).

The palette is a **green-to-sky-blue duotone** (`#22C55E → #0EA5E9` in light, `#4ADE80 → #38BDF8` in dark). These two accent colours are used everywhere the design "speaks": gradient headlines, active navigation indicators, icon tints, CTA buttons, skill chip borders, and the animated theme toggle. The backgrounds are near-black / warm-off-white, so the accents read with high contrast in both modes.

## Colors

The colour system has three semantic layers:

1. **Scaffold** — an intentionally muted single background colour. Dark mode is `#0C1010` (deep forest black with a green hint); light mode is `#F3F7F4` (warm white with the same green undertone). Neither is pure black or pure white, which creates warmth without competing with the content.

2. **Accent duotone** — the green-and-blue pair is never used as a flat fill on large surfaces. Instead it appears as:
   - Gradient fills on text (hero headline, contact headline)
   - Gradient fills on the theme toggle track
   - Tinted icon tile backgrounds (≈12 % opacity)
   - Status/badge borders (≈35 % opacity)
   - Navigation indicator bars and active link labels
   - CTA button fills

3. **Glass surfaces** — cards have no opaque background. In dark mode the card gradient runs from `rgba(255,255,255,0.08)` to `rgba(255,255,255,0.03)`, giving a barely-there frosted appearance that reveals the animated blobs below. In light mode the opacity range is wider (`0.35 → 0.15`) because the light scaffold needs stronger contrast to define surfaces.

Text roles are intentionally minimal: primary text inherits theme brightness (white in dark, near-black in light via Material defaults); `text-muted` (`#9E9E9E`) is the single muted tier used for section labels, captions, timestamps, and secondary copy.

## Background Animation System

Seven overlapping radial-gradient circles ("blobs") orbit slowly across the viewport using a single continuous `AnimationController` (20 s loop). Each blob oscillates via a `sin`/`cos` with a per-blob phase offset (`index × 1.8 rad`), producing a drift amplitude of ±55 logical pixels. The mouse position adds a parallax layer: as the cursor moves, every blob shifts by `mouseOffset × 80 px`, making the background feel tactile and three-dimensional. All blobs are rendered at very low opacity (max ≈ 16 %) so they never overpower the content; they serve as ambient depth rather than decorative foreground elements.

Additionally, a **cursor spotlight** — a 500 dp radial gradient centred on the cursor position, fading through `accent1@10%` → `accent1@4%` → transparent — follows the mouse in real time. This creates a soft "flashlight" effect that highlights whatever the user is pointing at.

## Typography

The single typeface is **Inter** (set globally via `fontFamily: 'Inter'`). The scale is deliberately condensed — only what is needed, nothing more:

- **Display (64 px / w800)** — hero headline. Rendered as a gradient-masked `ShaderMask`, transitioning from `accent1` to `accent2` across the text baseline.
- **Heading XL (52 px / w800)** — contact section headline; same gradient treatment.
- **Heading LG (36 px / w600)** — section titles (Skills & Expertise, Experience, Projects).
- **Heading MD (22 px / w700)** — project card titles.
- **Heading SM (18 px / w600)** — glass card section labels (e.g. "Focus Areas", company names).
- **Body LG (18 px / lh 1.8)** — hero bio copy. The generous line-height makes it scannable on wide viewports.
- **Body SM (15 px / lh 1.6)** — project descriptions; card body text.
- **Label MD (15 px / w600)** — CTA button text.
- **Label SM (13 px / w500)** — skill / tech chips.
- **Caption (12 px / w600 / ls 3 px)** — the `MOBILE ENGINEER` eyebrow label above the hero headline. All-caps with wide tracking signals section type without competing with headline weight.
- **Overline (12 px / w600 / ls 2.5 px)** — `NAVIGATION` and `CONNECT` left-rail group labels.

## Layout & Spacing

The layout follows a **left-rail + scrollable content** pattern on desktop, collapsing to a **top-bar + single-column** layout on mobile. The breakpoint is 1 000 logical pixels.

**Desktop:**
- Left rail is 320 px wide, fixed, with a 1 px right border (`rail-border`).
- Content area has `80 px left / 120 px right / 80 px top` padding.
- Sections are separated by **120 px** vertical gaps, creating generous "breathing room" between Hero → Expertise → Experience → Projects → Contact.
- The Expertise grid is 2-column with a 24 px gap.

**Mobile:**
- A slim top bar (`28 px horizontal / 18 px vertical padding`) shows the name and a hamburger icon.
- Navigation is hidden in a bottom sheet (modal, transparent background), with a `28 px top-corner radius` and a drag handle.
- Content padding reduces to `32 px horizontal / 40 px top`.
- Section gaps stay at 120 px.

The underlying **grid unit is 8 px**. All padding, gap, and size values are multiples of this unit.

## Elevation & Glass System

Depth is achieved entirely without shadows on background surfaces. The technique is:

1. **Blob layer** — lowest, animated, no shadow, no border.
2. **Cursor glow** — above blobs, pointer-events none.
3. **Glass cards** (GlassCard / ProjectCard) — the central primitive. A linear gradient from top to bottom with low-opacity white creates the frosted appearance. A `1 px rgba(white, 15%)` border defines the edge. On hover, the border opacity jumps to `30%` and the shadow blur doubles (`20 px → 40 px`), providing a clear interactive affordance without any colour change to the fill.

The `GlassCard` component is reused across the Expertise section (skill category cards), the Experience section (timeline entries via `TimelineItem`), and the Hero "Focus Areas" side panel. This makes the glass treatment a **structural pattern**, not decoration.

## Shapes

The corner-radius vocabulary is intentional:

- **Cards (24 px)** — the primary glass surface. The large radius softens the otherwise stark dark scaffolding and makes cards feel "contained" and friendly.
- **CTA Buttons (14 px)** — slightly squarer than cards; clearly interactive but not pill-shaped.
- **Icon tiles (10 px)** — small squares with a medium radius, giving them an app-icon quality that reinforces the "mobile engineer" identity.
- **Chips (20 px)** — near-pill shape, emphasising the tag/label nature of skill and tech chips.
- **Availability badge / theme toggle (pill)** — fully rounded for status indicators and toggle affordances.
- **Bottom sheet (28 px top corners)** — the largest radius in the system, used on the mobile nav sheet to clearly signal "modal overlay from below."

## Animation & Motion

Motion is purposeful and never decorative in isolation:

- **Page entrance**: The left rail fades and slides in from the left (`−4% X`) while the content area fades and rises (`+3% Y`), with a 135 ms stagger between the two. This creates a sense of layers assembling.
- **Scroll reveal**: Every section uses `RevealOnScroll`, which triggers a 700 ms `easeOut` fade + `6% Y` slide when the element's top edge crosses 92% of the viewport height. Sections are staggered in 100 ms increments.
- **Blob animation**: Continuous, looping, 20 s period. Never resets; the `repeat()` call keeps it imperceptible.
- **Hover transitions**: All interactive surfaces animate on a 200–300 ms `easeInOut` curve — fast enough to feel responsive, slow enough to feel premium.
- **Nav indicator**: The 2 px-high horizontal bar beside each nav label animates its **width** (`14 → 24 px`) on activation. This is the primary "you are here" signal and is far more refined than a background highlight.
- **Theme toggle**: The gradient track and thumb slide in 400 ms — the longest transition in the system, reinforcing that it is a *mode* change, not just a tap action.

## Component Interactions

**GlassCard** is the compositional atom of this design. Every content container — focus areas, skill categories, experience entries, project cards — is wrapped in GlassCard or implements the same glass decoration pattern directly. Hover state is managed locally with a `StatefulWidget` + `MouseRegion`; there is no global state for hover effects.

**CtaButton** has two variants: `filled` (solid accent background, white text) and `ghost` (transparent, accent-tinted border and text on hover). The two are always paired side-by-side in the Contact section to create a visual primary / secondary hierarchy.

**NavLink** is stateful and receives an `isActive` boolean from the parent. The indicator bar (`AnimatedContainer`) and the text style (`AnimatedDefaultTextStyle`) both animate simultaneously for a cohesive transition.

**AvatarWidget** is a fully programmatic silhouette — a `CustomPainter` drawing a gradient circle background with a white-tinted head-and-shoulders shape clipped to the circle. This avoids any dependency on a network image or asset file while keeping the left rail feel personal.

**GradientText** applies a `ShaderMask` with a horizontal `LinearGradient` over a `Text` widget. It is used exactly twice — hero headline and contact headline — so it never loses its visual impact.

## Responsive Behaviour

The single breakpoint (`> 1 000 px = desktop`) drives three structural changes:

1. Left rail appears / disappears (replaced by the top bar).
2. The HeroSection switches between a `Row` (2 : 1 flex split at `> 900 px` inner constraint) and a `Column`.
3. The ExpertiseSection switches between a 2-column card grid and a single-column list.

Everything else — card padding, typography scale, spacing rhythm — remains constant across breakpoints, preserving the premium feel on all screen widths.
