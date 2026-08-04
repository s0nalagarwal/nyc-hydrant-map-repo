#!/usr/bin/env bash
#
# convert.sh. Take the PP2 GeoParquet output, convert to GeoJSON, then to PMTiles.
#
# Usage:    ./convert.sh
# Requires: GDAL (ogr2ogr), tippecanoe (felt fork)
#
# Inputs:  data/raw/hydrant_density.parquet  (output from PP2)
# Output:  hydrant_density.pmtiles            (in repo root, served by GitHub Pages)

set -euo pipefail

INPUT_PARQUET="data/raw/hydrant_density.parquet"
INPUT_GEOJSON="data/raw/hydrant_density.geojson"
OUTPUT_PMTILES="hydrant_density.pmtiles"

# Step 1. Parquet to GeoJSON (tippecanoe doesn't read Parquet directly).
# Reproject to EPSG:4326 if your source is in another CRS.
echo "[1/2] Converting Parquet to GeoJSON"
ogr2ogr -f GeoJSON "$INPUT_GEOJSON" "$INPUT_PARQUET" \
  -t_srs EPSG:4326

# Step 2. GeoJSON to PMTiles using the polygon recipe from R3.3.
echo "[2/2] Building PMTiles with tippecanoe"
tippecanoe -o "$OUTPUT_PMTILES" -l hydrant_density \
  -Z6 -z14 \
  --no-feature-limit \
  --no-tile-size-limit \
  --detect-shared-borders \
  --coalesce-densest-as-needed \
  --simplification=2 \
  -f \
  "$INPUT_GEOJSON"

echo "Done. Output: $OUTPUT_PMTILES"
echo "Inspect: pmtiles show $OUTPUT_PMTILES"
