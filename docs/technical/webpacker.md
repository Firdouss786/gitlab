# Webpacker

When writing Javascript, it's best to have the webpacker dev server running, which automatically compiles and reloads the browser. This helps to speed up development:

`./bin/webpack-dev-server`

You can run this in a separate terminal tab, and continue to run the Rails server like normal.

## Tailwind

If you need to update the `tailwind.config.js` file, you will need to manually rebuild webpack dependencies.

`./bin/webpack`

This will also let you know if anything is not compiling properly.
