# Platform Engineer Go Application

This repository contains a small Go HTTP server that responds with a greeting message.

### Build locally

```bash
cd platform-engineer
docker build -t platform-engineer:latest .
```

### Run locally

```bash
docker run -p 8080:8080 -e PORT=8080 platform-engineer:latest
```

You can also omit `-e PORT=8080` and the app will use the default port `8080`.

## GitHub Actions CI Pipeline

A workflow has been added at `.github/workflows/build-push-platform-engineer.yml`.
It builds a multi-platform container image for `x86_64` and `linux/arm64` using Docker Buildx.
The workflow pushes the image to GitHub Container Registry at:

```text
ghcr.io/${{ github.repository_owner }}/platform-engineer:latest
```

## Kubernetes Deployment

Kubernetes manifests are available under `platform-engineer/k8s`.

### Apply the manifests

```bash
kubectl apply -f platform-engineer/k8s/deployment.yaml -f platform-engineer/k8s/service.yaml
```

### Update the image reference

Edit `platform-engineer/k8s/deployment.yaml` and replace `ghcr.io/<OWNER>/platform-engineer:latest` with your actual image path.

### Access the app

The service exposes the app on port `80` and forwards traffic to container port `8080`.

## Files

- `platform-engineer/main.go` - Go web server
- `platform-engineer/Dockerfile` - multi-arch container build
- `platform-engineer/.dockerignore` - files excluded from the image build
- `.github/workflows/build-push-platform-engineer.yml` - CI pipeline
- `platform-engineer/k8s/deployment.yaml` - Kubernetes deployment manifest
- `platform-engineer/k8s/service.yaml` - Kubernetes service manifest
