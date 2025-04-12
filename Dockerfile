FROM python:3.11-slim

WORKDIR /app

# Install system dependencies for aiortc and other packages
RUN apt-get update && apt-get install -y \
    build-essential \
    libavdevice-dev \
    libavfilter-dev \
    libopus-dev \
    libvpx-dev \
    pkg-config \
    libsrtp2-dev \
    libssl-dev \
    nodejs \
    npm \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for better caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install NodeJS dependencies for agent-processor
WORKDIR /app/agent-processor
COPY agent-processor/package*.json ./
RUN npm install ws

# Return to app directory and copy all files
WORKDIR /app
COPY . .

# Set executable permissions for run script
RUN chmod +x run.sh

# Command to run when container starts
CMD ["./run.sh"] 