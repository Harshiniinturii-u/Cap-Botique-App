FROM node:lts AS build
WORKDIR /app

COPY package.json package-lock.json ./
RUN --mount=type=cache,target=/root/.npm \
    npm ci --no-audit --no-fund
COPY . .
RUN npm run build
FROM node:lts AS runtime
RUN groupadd -g 1001 appgroup && \
    useradd -u 1001 -g appgroup -m -d /app -s /bin/false appuser
WORKDIR /app

COPY --from=build --chown=appuser:appgroup /app .
ENV NODE_ENV=production \
    NODE_OPTIONS="--enable-source-maps"

# Use non-root user
USER appuser

# Expose application port
EXPOSE 3000

# Start the application
ENTRYPOINT ["node", "server.js"]