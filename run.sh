#!/bin/bash
set -e

echo "Starting Echomorph Twitter Spaces AI Agent..."

# STEP 1: Run the Spaces listener
echo "Starting Twitter Spaces listener..."
cd /app/model_processor/client
python -m asyncio spaces.py &
SPACES_PID=$!
echo "Spaces listener started with PID: $SPACES_PID"

# STEP 2: Run Agent
echo "Starting agent processor..."
cd /app/agent-processor
node index.ts &
AGENT_PID=$!
echo "Agent started with PID: $AGENT_PID"

# STEP 3: Run RVC
echo "Starting RVC (Real-time Voice Conversion)..."
cd /app/model_processor/rvc
python rvc_processor.py &
RVC_PID=$!
echo "RVC started with PID: $RVC_PID"

# STEP 4: Run Voice Node
echo "Starting Voice Node..."
cd /app/model_processor/voice_node
python voice_node.py &
VOICE_PID=$!
echo "Voice Node started with PID: $VOICE_PID"

echo "All services started successfully."
echo "STEP 5: Have Fun!"

# Keep container running and handle graceful shutdown
function cleanup() {
    echo "Shutting down all services..."
    kill $SPACES_PID $AGENT_PID $RVC_PID $VOICE_PID
    exit 0
}

trap cleanup SIGTERM SIGINT

# Wait for any process to exit
wait -n

# Exit with status of process that exited first
exit $?