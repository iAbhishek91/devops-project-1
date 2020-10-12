# DevOps Project

This project demonstrates a NodeJs micro service along with React front end application packaged together in a Docker container.

The project has CI and CD to build test and back image and deploy in to GCP

## Quick start

To Run it in local, follow the below steps

### Node Version

v13.10.0

### Install Dependencies

```sh
yarn
```

### Build the project

```sh
yarn build
```

### Start the application

```sh
yarn start
```

### Validate the application from browser

http://localhost:8888

## Docker

Multistage docker file to create a slim image for the service

### Build the image

```sh
docker build -t devops-project-1:1.0.0 .
```

### Run the image

```sh
docker run -d devops-project-1:1.0.0 -p 8888:8888
```

## GitHub Actions

Tracked under .github/workflow folder.

There are two workflow defined triggered:

- **push to master** named ci.yaml (build and test the application)
- **pull_request to master** named cd.yaml (packages the artifact and upload in nexus, perform image bakery process upload the image in GCR and deploy that in GKE)

> Master branch is locked so that there is no direct push to master.

### Create secrets in GitHuB

GKE_PROJECT: PROJECT_ID
GKE_SA_KEY: {} # get the key from IAM manager

## Set up GCP

Below commands are executed on cloud shell

```sh
# Configure environment variable
ZONE=europe-west2-c
PROJECT=$GOOGLE_CLOUD_PROJECT

# Enable services
gcloud services enable containerregistry.googleapis.com

# validate the default values
gcloud container get-server-config --zone=$ZONE

# Create a cluster with minimal preemptive VMs
gcloud beta container --project "nice-beanbag-288720" clusters create "sandbox" --zone "europe-west2-c" --no-enable-basic-auth --cluster-version "1.15.12-gke.20" --machine-type "n1-standard-1" --image-type "COS" --disk-type "pd-standard" --disk-size "50" --metadata disable-legacy-endpoints=true --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" --max-pods-per-node "30" --preemptible --num-nodes "3" --enable-stackdriver-kubernetes --enable-ip-alias --network "projects/nice-beanbag-288720/global/networks/default" --subnetwork "projects/nice-beanbag-288720/regions/europe-west2/subnetworks/default" --default-max-pods-per-node "30" --enable-autoscaling --min-nodes "0" --max-nodes "3" --no-enable-master-authorized-networks --addons HorizontalPodAutoscaling,HttpLoadBalancing --enable-autoupgrade --enable-autorepair --max-surge-upgrade 1 --max-unavailable-upgrade 0
```
