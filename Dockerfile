FROM node:22-alpine AS builder

WORKDIR /app

RUN npm install -g bun

COPY package*.json ./
RUN bun install

COPY . .
RUN bun run build

FROM node:22-alpine

WORKDIR /app

RUN npm install -g bun

COPY --from=builder /app/dist ./dist
COPY --from=builder /app/src/h2-bridge.mjs ./h2-bridge.mjs
COPY --from=builder /app/node_modules ./node_modules
COPY package.json .

RUN addgroup -g 1001 -S appuser && \
    adduser -u 1001 -S appuser -G appuser

USER appuser

ENTRYPOINT ["bun", "run", "dist/cli.js"]
