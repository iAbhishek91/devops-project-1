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
