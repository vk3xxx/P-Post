# P-Post

A content automation system for posting media content to various social media platforms with intelligent deduplication and memory management.

## Features

- **Multi-platform Support**: Currently supports Telegram, easily extensible to other platforms
- **Intelligent Deduplication**: Built-in memory system prevents posting duplicate content
- **Media Processing**: Handles both images and videos with proper encoding
- **Rate Limiting**: Configurable posting intervals to respect platform limits
- **Error Handling**: Robust error handling and logging
- **Configuration Management**: Easy-to-use configuration system

## Prerequisites

- **n8n** (latest version) - [Installation Guide](https://docs.n8n.io/hosting/installation/)
- **FFmpeg** (4.0+) - [Download](https://ffmpeg.org/download.html)
- **Telegram Bot Token** - [Create Bot](https://core.telegram.org/bots#how-do-i-create-a-bot)
- **Python 3.8+** (for custom functions if needed)
- **Sufficient disk space** for temporary video files

## Quick Setup

1. **Clone the repository**:
```bash
git clone https://github.com/yourusername/P-Post.git
cd P-Post
```

2. **Run the setup script**:
```bash
./setup.sh
```

3. **Configure your bot**:
```bash
cp config.example.yaml config.yaml
# Edit config.yaml with your settings
```

## Configuration

Create a `config.yaml` file with your settings:

```yaml
telegram:
  bot_token: "YOUR_BOT_TOKEN"
  chat_id: "YOUR_CHAT_ID"

reddit:
  subreddit: "GOONED"
  limit: 30
  rate_seconds: 45

memory:
  ttl_days: 60

logging:
  level: "INFO"
  file: "p-post.log"
```

## Usage

### Import Workflow

1. Open n8n in your browser (usually http://localhost:5678)
2. Click "Import from file"
3. Select `p-post-workflow.json`
4. Configure the Telegram node with your bot token and chat ID
5. Save and activate the workflow

### Run Workflow

- **Manual**: Click the "Manual Trigger" node to start
- **Scheduled**: Set up a cron trigger for automatic execution
- **Webhook**: Configure webhook triggers for external activation

## Architecture

The system consists of several key components:

- **Content Fetcher**: Retrieves content from Reddit
- **Media Processor**: Downloads and processes media files
- **Deduplication Engine**: Manages memory and prevents duplicates
- **Platform Adapters**: Handles posting to different social media platforms
- **Rate Limiter**: Ensures compliance with platform limits

## Troubleshooting

Common issues and solutions are documented in [TROUBLESHOOTING.md](TROUBLESHOOTING.md).

### Video Posting Issues

The workflow has been optimized for video processing:
- Fixed connection issues in the media processing chain
- Increased timeouts for large file downloads
- Enhanced error handling for FFmpeg operations

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

MIT License - see LICENSE file for details

## Disclaimer

This tool is for educational and personal use only. Users are responsible for complying with all applicable laws and platform terms of service.
