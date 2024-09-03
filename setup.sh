#!/bin/bash

echo "Setting up Real-Time Job Recommender..."

# Clone the repositories
echo "Cloning repositories..."
git clone https://github.com/drapala/job-recommender-py.git
git clone https://github.com/drapala/job-recommendation-engine.git

# Install Docker if not installed
if ! [ -x "$(command -v docker)" ]; then
  echo "Docker not found. Installing Docker..."
  sudo apt-get update && sudo apt-get install -y docker.io
else
  echo "Docker is already installed."
fi

# Install Docker Compose if not installed
if ! [ -x "$(command -v docker-compose)" ]; then
  echo "Docker Compose not found. Installing Docker Compose..."
  sudo apt-get update && sudo apt-get install -y docker-compose
else
  echo "Docker Compose is already installed."
fi

# Install Python requirements
echo "Installing Python dependencies..."
sudo apt-get install -y python3-pip python3-venv
cd job-recommender-py
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
deactivate

# Build Docker image for Python service
echo "Building Docker image for Python service..."
docker build -t job-recommender-py .

# Install Java requirements
echo "Installing Java dependencies..."
cd ../job-recommendation-engine
./gradlew build

# Build Docker image for Java service
echo "Building Docker image for Java service..."
docker build -t job-recommendation-engine .

# Run Docker Compose
echo "Starting services with Docker Compose..."
cd ..
docker-compose up
