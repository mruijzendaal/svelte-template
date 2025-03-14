#!/bin/bash
# pnpm install
# pnpm run build

# Build the Docker container
docker build -t $DOCKER_TAG:latest . --platform linux/amd64

# Save the Docker container to a tar file
OUTPUT="output/$DOCKER_TAG.tar"
docker save $DOCKER_TAG:latest -o $OUTPUT

# Copy the tar file to the server and load it into Docker
scp $OUTPUT $DOCKER_REMOTE_DEST
scp docker-compose.yml $DOCKER_REMOTE_DEST

# Run this on the server
# docker load -i todo.tar
echo "Run this on the server:"
echo "docker load -i $DOCKER_TAG.tar"