#!/bin/bash

# Simple Rhasspy Setup Script
# This script helps you transition from Wyoming to Rhasspy

echo "🚀 Setting up Rhasspy Voice Assistant..."

# Check if we're on the Pi (check for common Pi hostnames or IP)
HOSTNAME=$(hostname)
if [[ "$HOSTNAME" != "raspberrypi" && "$HOSTNAME" != "vipberry" && ! "$HOSTNAME" =~ ^192\.168\. ]]; then
    echo "❌ This script should be run on your Raspberry Pi"
    echo "Please SSH into your Pi first: ssh vipul@192.168.68.66"
    exit 1
fi

echo "✅ Running on Pi (hostname: $HOSTNAME)"

echo "🛑 Step 1: Stopping current services..."
docker compose -f docker-compose-rhasspy.yml down

echo "🗂️ Step 2: Creating Rhasspy profiles directory..."
mkdir -p /home/vipul/rhasspy

echo "🐳 Step 3: Starting Rhasspy services..."
docker compose -f docker-compose-rhasspy.yml up -d

echo "⏳ Step 4: Waiting for services to start..."
sleep 10

echo "🔍 Step 5: Checking service status..."
docker ps

echo ""
echo "✅ Rhasspy setup complete!"
echo ""
echo "🌐 Access points:"
echo "   • Home Assistant: http://192.168.68.66:8123"
echo "   • Rhasspy Web UI: http://192.168.68.66:12101"
echo ""
echo "🎤 Test your voice assistant:"
echo "   Say 'Hey Jarvis' to wake it up"
echo "   Try: 'Hey Jarvis, turn on the light'"
echo "   Then: 'Turn off the light' (without saying Hey Jarvis again!)"
echo ""
echo "📚 Next steps:"
echo "   1. Open Rhasspy web interface to configure intents"
echo "   2. Test the conversational mode"
echo "   3. Customize wake word and responses"
echo ""
echo "🔧 Configuration:"
echo "   • Audio Input: plughw:CARD=Y02,DEV=0"
echo "   • Audio Output: plughw:CARD=Y02,DEV=0"
echo "   • TTS Service: http://piper:10200"
echo "   • STT Service: http://whisper:10300"
echo "   • Home Assistant: http://homeassistant:8123"
