# Cursor OpenAI API

A standalone CLI that serves Cursor's API as an OpenAI-compatible endpoint.

## Sponsor

[ChatWise](https://chatwise.app?ref=cursor-openai-api) - All-in-one agentic chat app.

## Features

- OAuth authentication with Cursor
- OpenAI-compatible `/v1/chat/completions` endpoint
- Automatic model discovery from your Cursor account
- Tool calling support
- Streaming responses

## NPM

```bash
npm i -g cursor-openai-api

cursor-openai-api login
cursor-openai-api serve
```

## Docker

```bash
# Pull the image
docker pull ghcr.io/egoist/cursor-openai-api:latest

# Run
docker run -p 3000:3000 \
  -v ~/.config/cursor-openai-api:/home/appuser/.config/cursor-openai-api \
  ghcr.io/egoist/cursor-openai-api:latest login
docker run -p 3000:3000 \
  -v ~/.config/cursor-openai-api:/home/appuser/.config/cursor-openai-api \
  ghcr.io/egoist/cursor-openai-api:latest serve
```

Credentials are stored in `~/.config/cursor-openai-api/credentials.json`.

## Commands

### `cursor-openai-api login`

Authenticate with Cursor via OAuth browser flow.

```bash
cursor-openai-api login
```

### `cursor-openai-api logout`

Clear stored credentials.

```bash
cursor-openai-api logout
```

### `cursor-openai-api whoami`

Check authentication status.

```bash
cursor-openai-api whoami
```

### `cursor-openai-api models`

List available Cursor models.

```bash
cursor-openai-api models
```

### `cursor-openai-api serve`

Start the OpenAI-compatible proxy server. Uses `PORT` environment variable (default: 3000).

```bash
PORT=3000 cursor-openai-api serve
```

The server exposes:

- `POST /v1/chat/completions` - Chat completions endpoint
- `GET /v1/models` - List available models

### `cursor-openai-api status`

Check if the proxy server is running.

```bash
cursor-openai-api status
```

## Usage with OpenAI SDK

```javascript
import OpenAI from "openai"

const client = new OpenAI({
  apiKey: "cursor", // any non-empty string
  baseURL: "http://localhost:3000/v1",
})

const chat = await client.chat.completions.create({
  model: "claude-4-sonnet",
  messages: [{ role: "user", content: "Hello!" }],
})
```

## Requirements

- Bun or Node.js 18+
- macOS, Linux, or WSL
- A Cursor account with API access

## Development

```bash
# Install dependencies
bun install

# Run without building
bun run src/cli.ts serve

# Build for production
bun run build
```

## Publishing

Push a tag to trigger the Docker build:

```bash
git tag v0.0.1
git push origin v0.0.1
```

## Prior art

This project is modified from https://github.com/ephraimduncan/opencode-cursor
