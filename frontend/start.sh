#!/bin/bash
# Start script for serving the web build

# Ensure PORT is set with a default
PORT="${PORT:-3000}"
echo "Starting serve on port $PORT"

# Run serve with proper arguments
npx serve -s web-build --single --timeout 300 --listen "$PORT" 