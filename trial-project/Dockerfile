# Dockerfile for Mini Project 1
FROM debian:bookworm-slim

# Install bash & jq
RUN apt-get update && apt-get install -y --no-install-recommends bash jq ca-certificates && rm -rf /var/lib/apt/lists/*

# App files
WORKDIR /app
COPY shift_manager.sh /app/shift_manager.sh
RUN chmod +x /app/shift_manager.sh

# Data directory (to be mounted as a volume)
VOLUME ["/data"]
ENV DATA_FILE=/data/shifts.json

ENTRYPOINT ["/app/shift_manager.sh"]
