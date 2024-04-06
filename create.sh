#!/bin/bash

PROJECT_ID=$1
IMAGE=$2

gcloud auth configure-docker europe-west1-docker.pkg.dev

docker build -t $IMAGE/minecraft-server:latest . --platform linux/amd64 --no-cache

docker push $IMAGE/minecraft-server:latest

gcloud compute instances create-with-container mcserver \
  --project=$PROJECT_ID \
  --zone=europe-west1-b \
  --machine-type=e2-custom-2-6144 \
  --network-interface=network-tier=PREMIUM,private-network-ip=10.132.0.7,subnet=default \
  --maintenance-policy=MIGRATE \
  --provisioning-model=STANDARD \
  --scopes=https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append,https://www.googleapis.com/auth/devstorage.read_write \
  --tags=mcserver \
  --image=projects/cos-cloud/global/images/cos-stable-109-17800-147-54 \
  --boot-disk-size=50GB \
  --boot-disk-type=pd-balanced \
  --boot-disk-device-name=mcserver \
  --container-image=$IMAGE/minecraft-server:latest \
  --container-restart-policy=always \
  --container-privileged \
  --no-shielded-secure-boot \
  --shielded-vtpm \
  --shielded-integrity-monitoring \
  --labels=goog-ec-src=vm_add-gcloud,container-vm=cos-stable-109-17800-147-54

gcloud compute --project=$PROJECT_ID firewall-rules create mcserver \
  --direction=INGRESS \
  --priority=1000 \
  --network=default \
  --action=ALLOW \
  --rules=tcp:25565 \
  --source-ranges=0.0.0.0/0 \
  --target-tags=mcserver