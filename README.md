# P-Post

A content automation system for posting media content to various social media platforms with intelligent deduplication and memory management.

## Features

- **Multi-platform Support**: Currently supports Telegram, easily extensible to other platforms
- **Intelligent Deduplication**: Built-in memory system prevents posting duplicate content
- **Media Processing**: Handles both images and videos with proper encoding
- **Rate Limiting**: Configurable posting intervals to respect platform limits
- **Error Handling**: Robust error handling and logging
- **Configuration Management**: Easy-to-use configuration system

## Installation

### Prerequisites

- Python 3.8+
- FFmpeg (for video processing)
- Telegram Bot Token

### Setup

1. Clone the repository:
```bash
git clone https://github.com/yourusername/P-Post.git
cd P-Post
```

2. Install dependencies:
```bash
pip install -r requirements.txt
```

3. Install FFmpeg:
   - **macOS**: `brew install ffmpeg`
   - **Ubuntu/Debian**: `sudo apt install ffmpeg`
   - **Windows**: Download from [ffmpeg.org](https://ffmpeg.org/download.html)

4. Configure your bot:
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

### Basic Usage

```bash
python main.py
```

### Advanced Usage

```python
from p_post import ContentPoster

poster = ContentPoster()
poster.run()
```

## Architecture

The system consists of several key components:

- **Content Fetcher**: Retrieves content from Reddit
- **Media Processor**: Downloads and processes media files
- **Deduplication Engine**: Manages memory and prevents duplicates
- **Platform Adapters**: Handles posting to different social media platforms
- **Rate Limiter**: Ensures compliance with platform limits

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
