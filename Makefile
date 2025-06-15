GCP_PROJECT ?= stonai-platform
GCP_REGION ?= us-west1
REPO_NAME ?= docker
IMAGE_NAME ?= trident
IMAGE_TAG ?= $(shell ./docker/get_image_tag.sh)
IMAGE_URI ?= ${GCP_REGION}-docker.pkg.dev/${GCP_PROJECT}/${REPO_NAME}/${IMAGE_NAME}:${IMAGE_TAG}

.PHONY: image-pushed image-built show-tag

image-pushed: image-built
	docker push ${IMAGE_URI}

image-built: docker/Dockerfile
	docker build -t ${IMAGE_URI} -f docker/Dockerfile .

show-tag:
	@echo "IMAGE_URI: ${IMAGE_URI}"
