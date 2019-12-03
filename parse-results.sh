#!/bin/bash

for jsonfile in ./results/**/**/**.json ;
do
    REPORT="$jsonfile"
    REPORT_FETCH_TIME=$(jq -r '.fetchTime' "$REPORT")
    REPORT_FINAL_URL=$(jq -r '.finalUrl' "$REPORT")
    PERFORMANCE_SCORE=$(jq -r '.categories.performance.score' "$REPORT")
    ACCESSIBILITY_SCORE=$(jq -r '.categories.accessibility.score' "$REPORT")
    BEST_PRACTICES_SCORE=$(jq -r '.categories."best-practices".score' "$REPORT")
    SEO_SCORE=$(jq -r '.categories.seo.score' "$REPORT")
    PWA_SCORE=$(jq -r '.categories.pwa.score' "$REPORT")

#    echo $REPORT_INFORMATION
#    echo $REPORT_FETCH_TIME
#    echo $REPORT_FINAL_URL
#    echo $PERFORMANCE_SCORE
#    echo $ACCESSIBILITY_SCORE
#    echo $BEST_PRACTICES_SCORE
#    echo $SEO_SCORE
#    echo $PWA_SCORE


    REPORT_SUMMARY=$( jq -n \
                         --arg rft "$REPORT_FETCH_TIME" \
                         --arg rfu "$REPORT_FINAL_URL" \
                         --arg ps "$PERFORMANCE_SCORE" \
                         --arg acs "$ACCESSIBILITY_SCORE" \
                         --arg bps "$BEST_PRACTICES_SCORE" \
                         --arg ss "$SEO_SCORE" \
                         --arg pwas "$PWA_SCORE" \
                         '{report_fetch_time:$rft,report_final_url:$rfu,score_performance:$ps,score_accessibility:$acs,score_best_practices:$bps,score_seo:$ss,score_pwa:$pwas}')

    SITE_PATH=$(echo $REPORT | cut -d '/' -f -3)
    echo $REPORT_SUMMARY > $SITE_PATH/report-summary.json
done;
