#!/bin/bash

# P-Post Setup Script
# This script helps set up the environment for running the n8n workflow
# Assumes n8n and FFmpeg are already installed

echo "🚀 Setting up P-Post n8n workflow..."

# Verify FFmpeg is available
if command -v ffmpeg &> /dev/null; then
    echo "✅ FFmpeg found: $(ffmpeg -version | head -n1)"
else
    echo "❌ FFmpeg not found. Please install FFmpeg first:"
    echo "   macOS: brew install ffmpeg"
    echo "   Ubuntu/Debian: sudo apt install ffmpeg"
    echo "   Windows: Download from https://ffmpeg.org/download.html"
    exit 1
fi

# Verify n8n is available
if command -v n8n &> /dev/null; then
    echo "✅ n8n found: $(n8n --version)"
else
    echo "❌ n8n not found. Please install n8n first:"
    echo "   npm install -g n8n"
    echo "   or use Docker: docker run -it --rm --name n8n -p 5678:5678 n8nio/n8n"
    exit 1
fi

# Create config file if it doesn't exist
if [ ! -f "config.yaml" ]; then
    echo "📝 Creating config.yaml from template..."
    cp config.example.yaml config.yaml
    echo "⚠️  Please edit config.yaml with your Telegram bot token and chat ID"
else
    echo "✅ config.yaml already exists"
fi

# Create logs directory
mkdir -p logs

# Create tmp directory if it doesn't exist (for video processing)
if [ ! -d "/tmp" ]; then
    echo "📁 Creating /tmp directory for video processing..."
    sudo mkdir -p /tmp
    sudo chmod 1777 /tmp
else
    echo "✅ /tmp directory exists"
fi

echo ""
echo "🎉 Setup complete!"
echo ""
echo "Next steps:"
echo "1. Edit config.yaml with your Telegram credentials"
echo "2. Import p-post-workflow.json into n8n"
echo "3. Configure your Telegram bot node with bot token and chat ID"
echo "4. Test the workflow with a manual trigger"
echo ""
echo "For troubleshooting, see TROUBLESHOOTING.md"
echo "Repository: https://github.com/vk3xxx/P-Post"
