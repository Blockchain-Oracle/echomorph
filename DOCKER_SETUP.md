# Running Echomorph with Docker

This guide will help you set up and run the Echomorph project using Docker, avoiding the need to install dependencies on your local machine.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- Twitter developer account with API access

## Setup Instructions

1. **Clone the repository**

```bash
git clone https://github.com/yourusername/echomorph.git
cd echomorph
```

2. **Set up environment variables**

Copy the example environment file and edit it with your Twitter credentials:

```bash
cp .env.example .env
```

Open `.env` with your favorite text editor and fill in your Twitter credentials:

```
TWITTER_USERNAME=your_twitter_username
TWITTER_PASSWORD=your_twitter_password
TWITTER_EMAIL=your_twitter_email
```

3. **Build and start the Docker container**

```bash
docker-compose up --build
```

This command will:
- Build the Docker image with all necessary dependencies
- Start the container with the Echomorph services
- Mount your local code directories to allow for code modifications without rebuilding

4. **For development and debugging**

If you need to debug interactively, you can start the container in interactive mode:

```bash
# Uncomment the interactive mode lines in docker-compose.yml first
docker-compose up --build

# In a separate terminal
docker exec -it echomorph_echomorph_1 bash
```

## Architecture in Docker

The Docker setup runs all components of Echomorph:

1. **Spaces Listener**: Connects to Twitter Spaces API
2. **Agent Processor**: Runs the AI logic (TypeScript)
3. **RVC (Real-time Voice Conversion)**: Handles voice conversion
4. **Voice Node**: Coordinates audio processing

All these services are started by the `run.sh` script automatically when the container starts.

## Troubleshooting

- **Container exits immediately**: Check the logs with `docker-compose logs` to see what's failing
- **Can't connect to Twitter**: Verify your credentials in the `.env` file
- **Service failures**: You can start individual services manually by entering the container in interactive mode

## Stopping the Services

To stop all running services:

```bash
docker-compose down
``` 