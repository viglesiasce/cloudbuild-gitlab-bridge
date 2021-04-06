#!/bin/bash

TOKEN=$(gcloud secrets versions access latest --secret="gitlab-runner-token")
sed -i s#TOKEN#$TOKEN# /config.toml
sed -i s#URL#$URL# /config.toml

gitlab-runner run -c /config.toml
