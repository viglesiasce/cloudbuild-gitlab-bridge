#!/bin/bash

echo "Cleaning up"
gsutil rm -r gs://vic-gcloud-dest-100-gitlab-cache/"${CUSTOM_ENV_CI_BUILD_REF}"