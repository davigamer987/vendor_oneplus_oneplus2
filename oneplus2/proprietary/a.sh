#!/bin/bash

# Base URL for downloading
BASE_URL="https://dumps.tadiphone.dev/dumps/fairphone/fp3/-/raw/fp3_gms-user-13-6.A.031.5-gms-fa7632b5-release-keys"

# List of files to download
FILES=(
    "vendor/bin/sensors.qti"
    "vendor/lib/libsensor1.so"
    "vendor/lib/libsensor_reg.so"
    "vendor/lib/sensor_calibrate.so"
    "vendor/lib/sensors.ssc.so"
    "vendor/lib64/libsensor1.so"
    "vendor/lib64/libsensor_reg.so"
    "vendor/lib64/sensor_calibrate.so"
    "vendor/lib64/sensors.ssc.so"
    "vendor/lib/libqmi_cci.so"
    "vendor/lib64/libqmi_cci.so"
)

# Loop to download files and compute hashes
for FILE in "${FILES[@]}"; do
    # Extract directory path
    DIR=$(dirname "$FILE")

    # Ensure directory exists
    mkdir -p "$DIR"

    # Delete the file if it exists (to prevent .1 duplicates)
    [ -f "$FILE" ] && rm -f "$FILE"

    # Download the file quietly (-q suppresses output)
    wget --content-disposition -q -P "$DIR" "$BASE_URL/$FILE"

    # Compute SHA1 hash and output in the requested format
    [ -f "$FILE" ] && echo "$FILE|$(sha1sum "$FILE" | awk '{print $1}')"
done
