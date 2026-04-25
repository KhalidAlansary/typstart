// Document metadata
#set document(
  title: "Typstart",
  description: [A starter template for collaborative Typst documents.],
)

// Color palette
#let accent = rgb("#5E81F4")
#let muted = rgb("#888888")
#let subtle = luma(245)

// Page
#set page(
  margin: (x: 3cm, y: 2.5cm),
  header: context {
    if counter(page).get().first() > 1 {
      set text(size: 8.5pt, fill: muted)
      grid(
        columns: (1fr, 1fr),
        align(left)[Typstart], align(right, counter(page).display()),
      )
      v(-4pt)
      line(length: 100%, stroke: 0.4pt + muted)
    }
  },
)

// Base typography
#set text(font: "New Computer Modern", size: 11pt, lang: "en")
#set par(leading: 0.8em, justify: true)
#set list(indent: 1em)
#set enum(indent: 1em)

// Heading styles
#show heading.where(level: 1): it => {
  v(1.8em, weak: true)
  text(size: 20pt, weight: "bold", fill: accent, it.body)
  v(0.25em, weak: true)
  line(length: 100%, stroke: 1.5pt + accent)
  v(0.6em, weak: true)
}

#show heading.where(level: 2): it => {
  v(1.2em, weak: true)
  text(size: 13pt, weight: "bold", it.body)
  v(0.3em, weak: true)
}

#show heading.where(level: 3): it => {
  v(0.8em, weak: true)
  text(size: 11pt, weight: "bold", fill: muted, it.body)
  v(0.2em, weak: true)
}

// Code
#show raw.where(block: true): it => block(
  width: 100%,
  fill: subtle,
  radius: 4pt,
  inset: (x: 14pt, y: 10pt),
  text(size: 9pt, it),
)

#show raw.where(block: false): it => box(
  fill: subtle,
  radius: 2pt,
  inset: (x: 3pt, y: 1pt),
  text(size: 9pt, it),
)

// Callout box
#let note(title: none, body) = rect(
  width: 100%,
  fill: accent.lighten(88%),
  stroke: (left: 3pt + accent),
  inset: (left: 14pt, right: 12pt, top: 9pt, bottom: 9pt),
  radius: (right: 4pt),
  {
    if title != none { text(weight: "bold")[#title\ ] }
    body
  },
)

// Demo helper — pass a raw block; shows source then live result.
// Any user-defined names the snippet references go in demo-scope.
#let demo-scope = (accent: accent, muted: muted, subtle: subtle)

#let demo(code) = {
  code
  block(
    width: 100%,
    stroke: (left: 2pt + muted.lighten(50%)),
    inset: (left: 12pt, y: 8pt),
    eval(code.text, mode: "markup", scope: demo-scope),
  )
}

// =============
//  TITLE
// =============

#v(2.5em)
#align(center)[
  #text(size: 42pt, weight: "bold", fill: accent)[Typstart]
  #v(0.3em)
  #text(size: 13pt, fill: muted)[A Typst Starter Template]
  #v(1.2em)
  #line(length: 35%, stroke: 0.8pt + muted)
  #v(1.2em)
  #text(size: 11pt)[
    A ready-to-go repo for writing, collaborating on, and publishing\
    Typst documents — compiled by GitHub Actions, hosted on Cloudflare Pages.
  ]
]
#v(2.5em)

// ==================
//  INTRODUCTION
// ==================

= Introduction

*Typstart* is a template repository that gets you from zero to a published document in minutes.
It pairs #link("https://typst.app")[Typst] — a modern, markup-based typesetting system — with a
CI/CD pipeline that compiles and deploys your document automatically on every push.

#note(title: "Getting started")[
  Everything you write lives in `src/main.typ`. Edit it, commit, and your changes
  go live at your Cloudflare Pages URL automatically.
]

== Why Typst?

Typst offers a compelling alternative to LaTeX:

- *Fast* — incremental compilation with instant previews.
- *Readable* — markup that looks like what it produces.
- *Programmable* — functions, variables, loops, and conditionals are built in.
- *Beautiful* — PDF and experimental HTML export out of the box.

= Getting Started

The repo includes a `Makefile` that compiles everything in one shot:

```bash
make        # build PDF + HTML into the out/ directory
make clean  # remove out/
```

Or invoke the Typst compiler directly for more control:

```bash
# Live preview as you write
typst watch src/main.typ main.pdf --open

# One-shot compile to PDF
typst compile src/main.typ main.pdf

# Compile to HTML (experimental)
typst compile --features=html src/main.typ main.html
```

Pushing to `master` triggers the GitHub Actions workflow, which publishes both
a PDF and an HTML version to Cloudflare Pages.

= Typst Feature Showcase

The rest of this document demonstrates the most commonly used Typst features.
Each example shows the *source* followed by the live *result*.

// Text & Typography

== Text & Typography

#demo(```typst
*bold* _italic_ `inline code` #underline[underlined] #strike[struck]
```)

=== Headings

Headings use `=` signs, nested by adding more `=`. The heading styles you see
throughout this document are Level 1, 2, and 3:

```typst
= Level 1
== Level 2
=== Level 3
```

// Lists

== Lists

*Unordered* lists use `-`:

#demo(```typst
- Apples
- Oranges
  - Navel
  - Blood
- Bananas
```)

*Ordered* lists use `1.`:

#demo(```typst
1. Compile
2. Review
3. Publish
```)

// Math

== Math

Inline math uses `$...$`; block math puts the expression on its own line:

#demo(```typst
The area of a circle is $A = pi r^2$.

$ integral_0^oo e^(-x^2) dif x = sqrt(pi) / 2 $

$ e^(i pi) + 1 = 0 $

$ mat(a, b; c, d) vec(x, y) = vec(a x + b y, c x + d y) $

$ sum_(k=1)^n k = (n(n+1)) / 2 $
```)

// Code blocks

== Code Blocks

Fenced code blocks support syntax highlighting for 100+ languages.
Use triple backticks followed by the language name:

```python
def greet(name: str) -> str:
    return f"Hello, {name}!"

print(greet("Typst"))
```

```rust
fn fibonacci(n: u64) -> u64 {
    match n {
        0 | 1 => n,
        _ => fibonacci(n - 1) + fibonacci(n - 2),
    }
}
```

// Tables

== Tables

#demo(```typst
#table(
  columns: (auto, 1fr, auto),
  [*Feature*],        [*Description*],                 [*Status*],
  [PDF output],       [Stable, production-ready],       [✓],
  [HTML output],      [Experimental, improving fast],   [~],
  [Math],             [Full LaTeX parity],              [✓],
  [Syntax highlight], [Built-in, 100+ languages],       [✓],
  [Scripting],        [Functions, loops, conditionals], [✓],
)
```)

// Quotes

== Quotes

#demo(```typst
#quote(attribution: [Richard Feynman], block: true)[
  If you think you understand quantum mechanics,
  you don't understand quantum mechanics.
]
```)

// Links

== Links

#demo(```typst
Visit #link("https://typst.app/docs")[typst.app/docs] for the full reference.
```)

// Show & Set Rules

== Show & Set Rules

`set` rules configure default parameters; `show` rules transform how elements render.
They are Typst's primary tool for global styling and are applied to everything that follows.

```typst
// Change paragraph defaults
#set text(size: 12pt)
#set par(justify: true, leading: 0.9em)

// Style every level-1 heading with a colored underline
#show heading.where(level: 1): it => {
  text(fill: blue, weight: "bold", it.body)
  line(length: 100%, stroke: blue)
}

// Wrap all block code in a gray box
#show raw.where(block: true): it => block(
  fill: luma(245),
  radius: 4pt,
  inset: 12pt,
  it,
)
```

The heading and code styles you see throughout this document are applied exactly this way
at the top of `src/main.typ`.

// Functions & Variables

== Functions & Variables

Typst is programmable. Define reusable helpers with `#let`:

#demo(```typst
#let badge(color, label) = box(
  fill: color,
  radius: 3pt,
  inset: (x: 5pt, y: 2pt),
  text(fill: white, size: 9pt, weight: "bold", label),
)

#badge(green, "DONE") #badge(orange, "WIP") #badge(red, "TODO")
```)

Loops and conditionals work inside content too:

#demo(```typst
#for lang in ("Typst", "Rust", "Python") [
  - Compiled with #text(fill: accent, weight: "bold")[#lang]
]
```)

// Grid Layout

== Grid Layout

#demo(```typst
#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  rect(fill: luma(230), inset: 10pt, radius: 4pt, width: 100%)[Left column],
  rect(fill: luma(230), inset: 10pt, radius: 4pt, width: 100%)[Right column],
)
```)

// ===================
//  NEXT STEPS
// ===================

= Next Steps

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  block(fill: subtle, radius: 4pt, inset: 14pt, width: 100%)[
    *Write your document* \
    #v(0.3em)
    Replace this file with your own content. The template is yours — delete,
    extend, or restructure freely.
  ],
  block(fill: subtle, radius: 4pt, inset: 14pt, width: 100%)[
    *Explore Typst* \
    #v(0.3em)
    The #link("https://typst.app/docs")[Typst docs] cover every feature in depth
    with interactive examples.
  ],
)

#v(3em)
#align(center)[
  #text(fill: muted, size: 9pt)[
    Built with #link("https://typst.app")[Typst]
    · Hosted on Cloudflare Pages
    · Source on GitHub
  ]
]
