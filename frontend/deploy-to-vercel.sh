#!/bin/bash

# Deployment script for Vercel with Railway backend

# Step 1: Make sure we have the Vercel CLI installed
if ! command -v vercel &> /dev/null; then
    echo "Vercel CLI is not installed. Installing..."
    npm install -g vercel
fi

# Step 2: Build the web application for production
echo "Building the web application..."
NODE_ENV=production npx expo export:web

# Step 3: Deploy to Vercel
echo "Deploying to Vercel..."
cd web-build
vercel --prod

echo "Deployment process initiated! Follow the prompts from Vercel CLI to complete deployment."
echo "After deployment, set these environment variables in the Vercel dashboard:"
echo "NEXT_PUBLIC_API_URL=YOUR_BACKEND_API_URL"
echo ""
echo "Important: Make sure your Railway backend is properly configured with these environment variables:"
echo "PORT=5001"
echo "SUPABASE_URL=your-supabase-url"
echo "SUPABASE_KEY=your-supabase-service-key"
echo "Any other API keys your backend requires" 