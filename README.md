# lighthouse-analyzer
Script for running Lighthouse (https://developers.google.com/web/tools/lighthouse) against multiple urls.

## Running

Must have lighthouse installed locally to run script. Instructions to install can be found here (https://developers.google.com/web/tools/lighthouse#cli)

* run `bash run-audit.sh`. 

The output will create a copy of the JSON and HTML output of the Lighthouse reports by timestamp in the `results` directory. 

![Results](/docs/images/results-directory.png)