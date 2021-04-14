#!/bin/bash

echo "Cleaning up"
gsutil rm -r gs://"${GCP_PROJECT}"-gitlab-cache/"${CUSTOM_ENV_CI_BUILD_REF}"
