
export PROJECT=$(gcloud config get-value project)

gcloud iam service-accounts create gitlab-runner
gcloud projects add-iam-policy-binding ${PROJECT} --member=serviceAccount:gitlab-runner@${PROJECT}.iam.gserviceaccount.com --role='roles/editor'

gcloud secrets create gitlab-runner-token
echo "GITLAB_RUNNER_TOKEN" | gcloud secrets versions add gitlab-runner-token --data-file=-
gcloud secrets add-iam-policy-binding gitlab-runner-token --member=serviceAccount:gitlab-runner@${PROJECT}.iam.gserviceaccount.com --role='roles/secretmanager.secretAccessor'

gcloud builds submit -t gcr.io/$PROJECT/gitlab-runner-cloudbuild .

gcloud compute instances create-with-container gitlab-runner-cloudbuild-$(date +%s) --machine-type=e2-standard-2 --service-account=gitlab-runner@${PROJECT}.iam.gserviceaccount.com --scopes=https://www.googleapis.com/auth/cloud-platform --image-family=cos-stable --image-project=cos-cloud --container-image=gcr.io/$PROJECT/gitlab-runner-cloudbuild --container-restart-policy=always --boot-disk-size=200GB

gsutil mb gs://$PROJECT-gitlab-cache
