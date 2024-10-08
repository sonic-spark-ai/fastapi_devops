#!/bin/bash

# Variables
REPO_URL="git@github.com:<your_username>/<your_repo_name>.git"
REPO_DIR="<your_repo_name>"
DOCKER_COMPOSE_FILE="docker-compose.yml"

# Pull the latest changes from the GitHub repository
echo "Checking if the repository exists..."
if [ ! -d "$REPO_DIR" ]; then
    echo "Cloning the repository for the first time..."
    git clone $REPO_URL
else
    echo "Repository exists. Pulling the latest changes..."
    cd $REPO_DIR
    git pull origin main
    cd ..
fi

# Navigate to the repository directory
cd $REPO_DIR

# Build the Docker images
echo "Building Docker images..."
docker-compose -f $DOCKER_COMPOSE_FILE build

# Run the Docker Compose setup
echo "Running Docker Compose..."
docker-compose -f $DOCKER_COMPOSE_FILE up -d

# Display status
echo "Deployment completed successfully."
docker-compose ps
