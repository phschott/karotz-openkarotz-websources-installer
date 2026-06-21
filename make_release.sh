#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SOURCES="$SCRIPT_DIR/sources"
TMP=$(mktemp -d)
OUTPUT="$SCRIPT_DIR/package-openkarotz.zip"

echo "Building release zip..."

# Inner zip 1: sources/www -> openkarotzwww
cp -r "$SOURCES/www" "$TMP/openkarotzwww"
(cd "$TMP" && zip -r "$TMP/openkarotzwww.zip" openkarotzwww > /dev/null)

# Inner zip 2: sources/openkarotz -> openkarotzusr
cp -r "$SOURCES/openkarotz" "$TMP/openkarotzusr"
(cd "$TMP" && zip -r "$TMP/openkarotzusr.zip" openkarotzusr > /dev/null)

# Outer zip containing both inner zips
(cd "$TMP" && zip "$OUTPUT" openkarotzwww.zip openkarotzusr.zip)

rm -rf "$TMP"

echo "Done: $OUTPUT"
