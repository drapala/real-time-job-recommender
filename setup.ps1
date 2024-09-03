Write-Output "Setting up Real-Time Job Recommender..."

# Clone the repositories
Write-Output "Cloning repositories..."
git clone https://github.com/drapala/job-recommender-py.git
git clone https://github.com/drapala/job-recommendation-engine.git

# Check if Docker is installed
if (-Not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Output "Docker not found. Please install Docker manually from https://www.docker.com/get-started."
    exit
}

# Check if Docker Compose is installed
if (-Not (Get-Command docker-compose -ErrorAction SilentlyContinue)) {
    Write-Output "Docker Compose not found. Please install Docker Compose manually from https://docs.docker.com/compose/install/"
    exit
}

# Install Python dependencies
Write-Output "Installing Python dependencies..."
Set-Location -Path job-recommender-py
python -m venv venv
.\venv\Scripts\Activate
pip install -r requirements.txt
Deactivate

# Build Docker image for Python service
Write-Output "Building Docker image for Python service..."
docker build -t job-recommender-py .

# Install Java dependencies
Write-Output "Installing Java dependencies..."
Set-Location -Path ../job-recommendation-engine
.\gradlew build

# Build Docker image for Java service
Write-Output "Building Docker image for Java service..."
docker build -t job-recommendation-engine .

# Run Docker Compose
Write-Output "Starting services with Docker Compose..."
Set-Location -Path ..
docker-compose up
