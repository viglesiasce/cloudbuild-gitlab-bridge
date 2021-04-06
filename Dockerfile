FROM gitlab/gitlab-runner

# Download gcloud
RUN apt-get update && apt-get install -y python
ENV VERSION=334.0.0
RUN curl https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${VERSION}-linux-x86_64.tar.gz > /tmp/google-cloud-sdk.tar.gz

# Installing the gcloud
RUN mkdir -p /usr/local/gcloud \
  && tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
  && /usr/local/gcloud/google-cloud-sdk/install.sh

# Adding the package path to local
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin
ENV URL https://gitlab.com/

COPY scripts/*.sh cloudbuild.yaml config.toml /

ENTRYPOINT [ "/entrypoint.sh" ]
