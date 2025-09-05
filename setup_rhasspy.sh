#!/bin/bash

# Rhasspy Setup Script
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

echo "📋 Step 1: Get your Home Assistant token"
echo "1. Open Home Assistant in your browser: http://192.168.68.66:8123"
echo "2. Go to Profile → Long-lived access tokens"
echo "3. Create a new token and copy it"
echo "4. Press Enter when you have the token..."
read -r

echo "🔑 Please paste your Home Assistant token:"
read -r HA_TOKEN

# Replace the token in the compose file
sed -i "s/YOUR_HA_TOKEN_HERE/$HA_TOKEN/g" docker-compose-rhasspy.yml

echo "🛑 Step 2: Stopping current Wyoming services..."
docker compose -f docker-compose-full-stack.yml down

echo "🗂️ Step 3: Creating Rhasspy profiles directory..."
mkdir -p /home/vipul/rhasspy

echo "🐳 Step 4: Starting Rhasspy services..."
docker compose -f docker-compose-rhasspy.yml up -d

echo "⏳ Step 5: Waiting for services to start..."
sleep 10

echo "🔍 Step 6: Checking service status..."
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
