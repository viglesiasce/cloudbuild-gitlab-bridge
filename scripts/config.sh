#!/usr/bin/env bash

cat << EOS
{
  "builds_dir_is_shared": false,
  "driver": {
    "name": "Cloud Build driver",
    "version": "v0.0.1"
  },
  "job_env": {
      "GCP_PROJECT": "$(gcloud config get-value project)"
  }
}
EOS