# --- Stage 1: Build ---
FROM node:20-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package.json + lock file
COPY package*.json tsconfig.json ./

# Install dependencies (including dev)
RUN npm install

# Copy source
COPY src ./src

# Build TypeScript → dist
RUN npm run build


# --- Stage 2: Production Image ---
FROM node:20-alpine

WORKDIR /app

# Only copy package.json & lock for prod install
COPY package*.json ./

# Install only production dependencies
RUN npm install --omit=dev

# Copy compiled JS from builder
COPY --from=builder /app/dist ./dist

# Expose app port (Express default 3000)
EXPOSE 3000

# Start the app
CMD ["node", "dist/index.js"]
