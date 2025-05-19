#!/bin/bash

# Direct deployment script for Railway frontend
# This script uploads the code to Railway without trying to build locally

set -e
echo "Starting direct deployment to Railway..."

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

# Step 3: Set timeout environment variables if not already set
export RAILWAY_TIMEOUT=${RAILWAY_TIMEOUT:-600}
echo "Using timeout of ${RAILWAY_TIMEOUT} seconds for Railway operations"

# Step 4: Deploy directly to Railway with retry logic
echo "Deploying directly to Railway..."
MAX_RETRIES=3
RETRY_COUNT=0

deploy_to_railway() {
    echo "Deployment attempt $((RETRY_COUNT+1)) of ${MAX_RETRIES}..."
    
    if railway up; then
        return 0
    else
        return 1
    fi
}

while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
    if deploy_to_railway; then
        echo "Deployment successful!"
        break
    else
        RETRY_COUNT=$((RETRY_COUNT+1))
        if [ $RETRY_COUNT -lt $MAX_RETRIES ]; then
            echo "Deployment failed. Retrying in 10 seconds... (Attempt $RETRY_COUNT of $MAX_RETRIES)"
            sleep 10
        else
            echo "All deployment attempts failed."
            echo "You may want to try again later or check Railway status."
            exit 1
        fi
    fi
done

echo ""
echo "Deployment process initiated! Your app should now be building on Railway."
echo ""
echo "Important: Make sure these environment variables are set in the Railway dashboard:"
echo "NODE_ENV=production"
echo "NEXT_PUBLIC_API_URL=YOUR_BACKEND_API_URL"
echo ""
echo "After deployment, you can link the frontend to the backend service in the Railway dashboard to share environment variables."
echo ""
echo "To check your deployment status, visit: https://railway.app/dashboard" 