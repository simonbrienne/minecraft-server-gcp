# Minecraft Server on GCP

This repository contains a script to deploy a Minecraft server on Google Cloud Platform (GCP).

## Table of contents

- [Minecraft Server on GCP](#minecraft-server-on-gcp)
  - [Table of contents](#table-of-contents)
  - [Pre-requisites](#pre-requisites)
  - [Run locally](#run-locally)
  - [Run from Github Actions](#run-from-github-actions)
  - [Tutorial](#tutorial)

## Pre-requisites

- Docker
- Bash
- Gcloud CLI

## Run locally

Connect to your GCP project : 

```bash
gcloud auth login
gcloud config set project <YOUR_PROJECT_ID>
```

Run the following command :

```bash
# sh ./create.sh <YOUR_PROJECT_ID> <YOUR_IMAGE_URL>

# Exemple :

sh ./create.sh sample-project-419319 europe-west1-docker.pkg.dev/sample-project-419319/containers
```

## Run from Github Actions

- Fork this repository
- Create a service account with the admin role on your project and download the key
- Create a new secret **SERVICE_ACCOUNT_KEY** for storing the service account key
- Create a new variables **PROJECT_ID** and **REGISTRY_URL** in the Github Actions settings

Example :

- ***PROJECT_ID*** : sample-project-419319
- ***REGISTRY_URL*** : europe-west1-docker.pkg.dev/sample-project-419319/containers

Then, push a commit to the repository.

## Tutorial

- [Youtube Video](https://youtu.be/QuEWD0XIbJA) (FR)

