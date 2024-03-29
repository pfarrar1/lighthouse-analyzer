#!/bin/bash

TIMESTAMP=$(date +%s)

for url in $(cat urls.txt); do
    URL=${url}
    URL_NOPRO=${URL:7}
    URL_REL=${URL_NOPRO#*/}
    FILEPATH=${URL_REL%%\?*}
    URI=$(echo "$FILEPATH" | tr / . )

    echo "$URI"
    echo "$TIMESTAMP"

    URL_PATH="results/$URI/$TIMESTAMP/"
    mkdir -p "${URL_PATH}"

    lighthouse "${url}" --output=json --output-path="$URL_PATH/report-$URI.json" --output json --output html --view
done