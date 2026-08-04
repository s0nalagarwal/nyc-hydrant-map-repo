# NYC Hydrant Density Map

🗺️ **[Live map](https://s0nalagarwal.github.io/nyc-hydrant-map-repo/)**

A web map showing NYC fire hydrant density by neighborhood. Built on the modern open-source stack (MapLibre + PMTiles + GitHub Pages).

![Screenshot of the choropleth](images/density_choropleth.png)

## The question

Where is hydrant coverage densest in NYC, and which neighborhoods are underserved relative to their area?

## The data

- **NYC Neighborhoods.** 262 polygons (Source: [NYC Open Data](https://opendata.cityofnewyork.us))
- **NYC Fire Hydrants.** 109,725 points (Source: [NYC Open Data](https://opendata.cityofnewyork.us))
- Density was computed in PP2 ([repo link]) using PostGIS and GeoPandas.

## The technology choices

- **MapLibre GL JS** for rendering. Open-source, no vendor lock-in, same API as Mapbox GL JS.
- **PMTiles** for the data layer. One file, no tile server, hosted alongside `index.html` on GitHub Pages.
- **tippecanoe** for tile generation. Polygon recipe with shared-border detection for clean rendering at all zooms.
- **GitHub Pages** for hosting. Free, fast, no infrastructure to maintain.

Total monthly cost: $0. Total servers running: 0.

## How to reproduce

Requires GDAL, tippecanoe, and a tiny local web server.

```bash
git clone https://github.com/{s0nalagarwal}/nyc-hydrant-map.git
cd nyc-hydrant-map

# Place your PP2 output here:
#   data/raw/hydrant_density.parquet

# Rebuild the .pmtiles
./convert.sh

# Test locally
python3 -m http.server 8000
# open http://localhost:8000
```

## What I learned

Understanding tippecanoe conversions took the most iterations in this project, as multiple times I had errors or bugs in the web page. Either it was the hover aspect not functioning or the neighborhood ID's not correctly displaying which caused issues leading me to rewrite parts of the tippecanoe command. 

## Stack

- MapLibre GL JS 4.5.2
- PMTiles 3.2.0
- tippecanoe (felt fork)
- GitHub Pages
