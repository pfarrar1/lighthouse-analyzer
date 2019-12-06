#!/bin/bash

allLighthouseReportResults=();
PERF_ARRAY=();

for jsonfile in ./results/**/**/**.json ;
do
    allLighthouseReportResults+=(${jsonfile})
done;

for reports in ${allLighthouseReportResults[@]} ;
do
    REPORT=$reports
    REPORT_FETCH_TIME=$(jq -r '.fetchTime' "$REPORT")
    REPORT_FINAL_URL=$(jq -r '.finalUrl' "$REPORT")
    PERFORMANCE_SCORE=$(jq -r '.categories.performance.score' "$REPORT")
    ACCESSIBILITY_SCORE=$(jq -r '.categories.accessibility.score' "$REPORT")
    BEST_PRACTICES_SCORE=$(jq -r '.categories."best-practices".score' "$REPORT")
    SEO_SCORE=$(jq -r '.categories.seo.score' "$REPORT")
    PWA_SCORE=$(jq -r '.categories.pwa.score' "$REPORT")
    SITE_PATH=$(echo $REPORT | cut -d '/' -f -3)

    REPORT_SUMMARY=$( jq -n \
                         --arg rft "$REPORT_FETCH_TIME" \
                         --arg rfu "$REPORT_FINAL_URL" \
                         --arg ps "$PERFORMANCE_SCORE" \
                         --arg acs "$ACCESSIBILITY_SCORE" \
                         --arg bps "$BEST_PRACTICES_SCORE" \
                         --arg ss "$SEO_SCORE" \
                         --arg pwas "$PWA_SCORE" \
                         --arg sp "$SITE_PATH" \
                         '{report_fetch_time:$rft,report_final_url:$rfu,score_performance:$ps,score_accessibility:$acs,score_best_practices:$bps,score_seo:$ss,score_pwa:$pwas,site_path:$sp}')

    PERF_ARRAY+=$REPORT_SUMMARY
done;

echo "${PERF_ARRAY[@]}" |
  jq -s '{results: .,}' > ./results/report-summary.json

cat results/report-summary.json | jq -c '.results | group_by(.site_path) | map({(.[0].site_path): map(.)})' > ./results/report-summary-breakdown.json
