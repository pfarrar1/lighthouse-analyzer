#!/bin/bash

for jsonfile in ./results/**/**/**.json ;
do
    REPORT="$jsonfile"
    REPORT_INFORMATION=$(jq -r '.environment' "$REPORT")
    echo $REPORT_INFORMATION
    SCORES=$(jq -r '.categories | keys[] as $k | "{\($k): \(.[$k] | .score)},"' "$REPORT")
    echo $SCORES

    REPORT_SUMMARY=$( jq -n \
                         --arg rn "$REPORT_INFORMATION" \
                         --arg s "$SCORES" \
                         '{report_information: [$rn], scores: [$s]}' )
    echo $REPORT_SUMMARY
done;
