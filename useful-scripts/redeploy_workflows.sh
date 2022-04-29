#!/bin/bash

# Command to run this script:
# $ bash redeploy_workflows.sh {FILE_NAME}
#
#   - FILE_NAME should be a path to a text file that contains a list of
#               workflow resource names, one resource name per line.
#
# Example FILE_NAME: workflows.txt
# Example workflows.txt:
#   projects/my-project/locations/us-central1/workflows/my-workflow1
#   projects/my-project/locations/us-central1/workflows/my-workflow2
# Example command:
# $ bash redeploy_workflows.sh workflows.txt


fileName=$1
cat "$fileName" | while IFS="" read -r line
do
  gcloud workflows describe "$line" | grep -o -P '(?<=serviceAccount: ).*' | xargs gcloud workflows deploy "$line" --service-account
done
