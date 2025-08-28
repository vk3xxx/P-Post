#!/bin/bash

# P-Post Setup Script
# This script helps set up the environment for running the n8n workflow

echo "🚀 Setting up P-Post n8n workflow..."

# Check if FFmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
    echo "❌ FFmpeg not found. Installing..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        if command -v brew &> /dev/null; then
            brew install ffmpeg
        else
            echo "❌ Homebrew not found. Please install Homebrew first:"
            echo "   /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
            exit 1
        fi
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        if command -v apt-get &> /dev/null; then
            sudo apt update && sudo apt install -y ffmpeg
        elif command -v yum &> /dev/null; then
            sudo yum install -y ffmpeg
        else
            echo "❌ Package manager not supported. Please install FFmpeg manually."
            exit 1
        fi
    else
        echo "❌ OS not supported. Please install FFmpeg manually from https://ffmpeg.org/download.html"
        exit 1
    fi
else
    echo "✅ FFmpeg already installed: $(ffmpeg -version | head -n1)"
fi

# Check if n8n is installed
if ! command -v n8n &> /dev/null; then
    echo "📦 Installing n8n..."
    npm install -g n8n
else
    echo "✅ n8n already installed: $(n8n --version)"
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

echo ""
echo "🎉 Setup complete!"
echo ""
echo "Next steps:"
echo "1. Edit config.yaml with your Telegram credentials"
echo "2. Import p-post-workflow.json into n8n"
echo "3. Configure your Telegram bot node"
echo "4. Test the workflow with a manual trigger"
echo ""
echo "For troubleshooting, see TROUBLESHOOTING.md"
echo "Repository: https://github.com/vk3xxx/P-Post"
