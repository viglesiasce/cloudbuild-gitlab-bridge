#!/bin/bash
  
SCRIPT=$1
SUB_STAGE=$2

echo "Starting $SUB_STAGE..."
if [[ $SUB_STAGE == "build_script" ]]; then
    cd /builds/"${CUSTOM_ENV_CI_PROJECT_NAMESPACE}"/"${CUSTOM_ENV_CI_PROJECT_NAME}" || exit 1
    cp "$SCRIPT" ./script.sh

    # Ensure gcloud uploads all files, ignore the defualt ignore rules
    touch .gcloudignore
    export PYTHONUNBUFFERED=1
    gcloud builds submit . --config /cloudbuild.yaml \
                           --substitutions _CI_PROJECT_NAMESPACE="${CUSTOM_ENV_CI_PROJECT_NAMESPACE}",_CI_PROJECT_NAME="${CUSTOM_ENV_CI_PROJECT_NAME}",_IMAGE_NAME="${CUSTOM_ENV_CI_JOB_IMAGE}",_CI_BUILD_REF="${CUSTOM_ENV_CI_BUILD_REF}"
    gsutil cp gs://"${GCP_PROJECT}"-gitlab-cache/"${CUSTOM_ENV_CI_BUILD_REF}"/workspace.tgz .
    tar zxf workspace.tgz
    gsutil rm gs://"${GCP_PROJECT}"-gitlab-cache/"${CUSTOM_ENV_CI_BUILD_REF}"/workspace.tgz
else
  bash "$SCRIPT"
fi
