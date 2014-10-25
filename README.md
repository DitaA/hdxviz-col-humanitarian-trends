## Simple Visualization of OCHA Colombia's Humanitarian Trends Data

This repository contains the code for visualizing OCHA Colombia's data on [Humanitarian Trends](https://data.hdx.rwlabs.org/dataset/humanitarian-trends).

We are also using this script for collecting [population data](https://github.com/luiscape/colombia_population) from Colombia's DANE.

# Dependencies
- `mapbox.js` for style issues
- `leaflet.js` for the main mapping attributes

# Tests
- https://www.mapbox.com/mapbox.js/example/v1.0.0/choropleth-joined-data-multiple-variables/

For performances purposes this visualization loads tiles directly from MapBox's servers instead of trying to load GeoJSON files locally.

This post contains more about that topic: http://blog.thematicmapping.org/2012/11/new-leaflet-plugin-to-handle-multiple.html