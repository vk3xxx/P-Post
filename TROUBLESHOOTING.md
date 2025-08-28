# Troubleshooting Guide for P-Post n8n Workflow

## Common Video Posting Issues

### 1. Video Download Failures

**Problem**: Videos fail to download from Reddit
**Solution**: 
- Check if Reddit is blocking requests (try different User-Agent)
- Verify the video URL is accessible
- Increase timeout values in DLVideo and DLAudio nodes

### 2. FFmpeg Muxing Errors

**Problem**: FFmpeg fails to combine video and audio
**Solution**:
- Ensure FFmpeg is installed: `ffmpeg -version`
- Check if audio file exists and has content
- Verify video file format compatibility

### 3. Memory Issues

**Problem**: Workflow runs out of memory during video processing
**Solution**:
- Clean up temporary files more aggressively
- Process videos one at a time
- Monitor disk space in /tmp directory

### 4. Telegram API Limits

**Problem**: Videos fail to send to Telegram
**Solution**:
- Check file size limits (50MB for regular bots, 2GB for premium)
- Verify bot permissions
- Ensure video format is supported (MP4 recommended)

## Common Image Posting Issues

### 1. Missing Telegram Credentials

**Problem**: "Node does not have any credentials set" error
**Solution**:
1. In the SendPhoto node, click on "Credential to connect with"
2. Select "Create New" → "Telegram Account"
3. Enter your bot token (get from @BotFather)
4. Test the connection
5. Save the credential

### 2. Empty Photo Field

**Problem**: Photo field is empty in SendPhoto node
**Solution**:
1. Verify the Photo field contains: `={{$json.media_url}}`
2. Check that the field is not accidentally cleared
3. Ensure the expression syntax is correct (no extra spaces)
4. Re-import the workflow if the field got corrupted

### 3. Photo Field Shows "undefined"

**Problem**: Photo field resolves to "undefined"
**Solution**:
1. Check that ExtractMedia node is properly extracting media_url
2. Verify the data flow through all nodes
3. Test with a single image post first
4. Check n8n execution logs for data transformation issues

## Critical Fix Applied

The original workflow had a connection error in the CombineMedia node. The connections were:

```json
"CombineMedia": { "main": [[{ "node": "WriteVideo", "type": "main", "index": 0 }, { "node": "WriteVideo", "type": "main", "index": 0 }]] }
```

This was corrected to properly connect both WriteVideo and WriteAudio nodes:

```json
"CombineMedia": { "main": [[{ "node": "WriteVideo", "type": "main", "index": 0 }, { "node": "WriteAudio", "type": "main", "index": 0 }]] }
```

## Testing Video Flow

1. **Manual Test**: Run workflow with a single video post
2. **Check Logs**: Monitor n8n execution logs for errors
3. **Verify Files**: Check if temporary files are created in /tmp
4. **FFmpeg Test**: Test FFmpeg command manually with sample files

## Environment Requirements

- **n8n**: Latest version (0.200+ recommended)
- **FFmpeg**: 4.0+ with codec support
- **Disk Space**: At least 1GB free in /tmp
- **Memory**: 2GB+ RAM for video processing
- **Network**: Stable connection for downloading large files

## Debug Mode

Enable debug logging in n8n:
1. Set environment variable: `N8N_LOG_LEVEL=debug`
2. Check execution details in n8n interface
3. Monitor system resources during execution

## Quick Fix Checklist

If images aren't posting:

1. ✅ **Telegram Credentials**: Set up bot token in SendPhoto node
2. ✅ **Photo Field**: Ensure it contains `={{$json.media_url}}`
3. ✅ **Data Flow**: Verify media_url is present in input data
4. ✅ **Node Type**: Confirm SendPhoto is a Telegram node
5. ✅ **Workflow Import**: Re-import if fields got corrupted
