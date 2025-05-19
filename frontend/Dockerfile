FROM node:18-alpine

WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install --force

# Copy the rest of the app
COPY . .

# Generate web build
RUN npm run build:web

# Install serve to run the static files
RUN npm install -g serve

# Set the command to serve the web build
# The PORT environment variable will be automatically used by serve
CMD ["serve", "-s", "web-build"] 