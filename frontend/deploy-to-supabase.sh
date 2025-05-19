#!/bin/bash

# Deployment script for Supabase hosting

# Step 1: Make sure we have the Supabase CLI installed
if ! command -v supabase &> /dev/null; then
    echo "Supabase CLI is not installed. Installing..."
    # For MacOS
    brew install supabase/tap/supabase
    # For other systems, check the Supabase docs
fi

# Step 2: Login to Supabase (if not already logged in)
echo "Logging in to Supabase..."
supabase login

# Step 3: Build the web application
echo "Building the web application..."
NODE_ENV=production npx expo export:web

# Step 4: Deploy to Supabase hosting
echo "Deploying to Supabase hosting..."
# Replace 'your-project-ref' with your actual Supabase project reference
supabase hosting deploy ./web-build --project-ref=your-project-ref

echo "Deployment completed! Your app should be available at your Supabase hosting URL." 