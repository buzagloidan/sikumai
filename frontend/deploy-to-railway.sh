#!/bin/bash

# Deployment script for Railway frontend

# Set error handling
set -e
echo "Starting deployment process to Railway..."

# Step 1: Make sure we have the Railway CLI installed
if ! command -v railway &> /dev/null; then
    echo "Railway CLI is not installed. Installing..."
    npm install -g @railway/cli
fi

# Step 2: Check if we're logged in to Railway
echo "Checking Railway login status..."
if ! railway whoami &> /dev/null; then
    echo "Not logged in to Railway. Initiating login..."
    railway login
else
    echo "Already logged in to Railway."
fi

# Step 3: Install dependencies
echo "Installing dependencies..."
npm install

# Step 4: Ensure webpack and related packages are properly installed
echo "Installing webpack and related packages properly..."
npm uninstall webpack webpack-cli webpack-dev-server @expo/webpack-config
npm install --save-dev webpack@5.98.0 webpack-cli@6.0.1 webpack-dev-server@5.2.0 @expo/webpack-config@19.0.1
npm ls webpack webpack-cli webpack-dev-server @expo/webpack-config

# Step 5: Create a minimal webpack.config.js if it doesn't exist properly
echo "Ensuring webpack config exists..."
cat > webpack.config.js << 'EOF'
const createExpoWebpackConfigAsync = require('@expo/webpack-config');

module.exports = async function(env, argv) {
  const config = await createExpoWebpackConfigAsync(env, argv);
  return config;
};
EOF

# Step 6: Set environment variables for the build
echo "Setting environment variables..."
export NODE_ENV=production
export NEXT_PUBLIC_API_URL=YOUR_BACKEND_API_URL

# Step 7: Build the web application
echo "Building the web application..."
npx expo export:web

# Step 8: Test if the build was successful
if [ ! -d "web-build" ]; then
    echo "Error: Failed to build the web application. The web-build directory was not created."
    exit 1
else
    echo "✅ Successfully built the web application."
fi

# Step 9: Deploy to Railway
echo "Deploying to Railway..."
railway up

echo ""
echo "Deployment process completed! Your app should now be deploying to Railway."
echo ""
echo "Important: Make sure these environment variables are set in the Railway dashboard:"
echo "NODE_ENV=production"
echo "NEXT_PUBLIC_API_URL=YOUR_BACKEND_API_URL"
echo ""
echo "After deployment, you can link the frontend to the backend service in the Railway dashboard to share environment variables."
echo ""
echo "To check your deployment status, visit: https://railway.app/dashboard" 