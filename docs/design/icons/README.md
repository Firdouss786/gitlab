## Icons
Icons are in SVG format, and are drawn on a 20x20 artboard. Most graphics applications like Sketch or Figma add extraneous SVG syntax, and so we 'compress' SVG's using [SVG OMG](https://jakearchibald.github.io/svgomg/)

We also ensure that every SVG has the following `viewBox`:
```
viewBox="0 0 20 20"
```

A standard SVG icon example:
```
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
  <path d="M17.889 4.6L7.017 15.471a1.056 1.056 0 11-1.478-1.5L16.39 3.113h-3.779a1.056 1.056 0 010-2.112h6.333C19.527 1 20 1.473 20 2.056v6.333a1.056 1.056 0 01-2.111 0v-3.79zm-2.111 8.011a1.056 1.056 0 012.11 0v5.278A2.111 2.111 0 0115.779 20H3.11A2.111 2.111 0 011 17.889V5.222c0-1.16.95-2.11 2.111-2.11H8.39a1.056 1.056 0 010 2.11H3.11V17.89h12.667V12.61z" />
</svg>
```

We then use [TailwindCSS](https://tailwindcss.com/course/working-with-svg-icons/#app) to size and color the SVG:
```
<svg class="h-6 w-6 fill-current text-gray-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
  <path d="M17.889 4.6L7.017 15.471a1.056 1.056 0 11-1.478-1.5L16.39 3.113h-3.779a1.056 1.056 0 010-2.112h6.333C19.527 1 20 1.473 20 2.056v6.333a1.056 1.056 0 01-2.111 0v-3.79zm-2.111 8.011a1.056 1.056 0 012.11 0v5.278A2.111 2.111 0 0115.779 20H3.11A2.111 2.111 0 011 17.889V5.222c0-1.16.95-2.11 2.111-2.11H8.39a1.056 1.056 0 010 2.11H3.11V17.89h12.667V12.61z" />
</svg>
```
