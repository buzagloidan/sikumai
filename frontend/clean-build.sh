#!/bin/bash

# Exit on error
set -e

echo "🧹 Starting cleanup for production build..."

# Remove Git repository
echo "Removing .git directory..."
rm -rf .git

# Clean node_modules
echo "Cleaning node_modules unnecessary files..."
rm -rf node_modules/.cache
rm -rf node_modules/.bin
rm -rf node_modules/.vite
rm -rf node_modules/.pnpm
find node_modules -name "*.md" -type f -delete
find node_modules -name "*.txt" -type f -delete
find node_modules -name "*.map" -type f -delete
find node_modules -name "LICENSE*" -type f -delete
find node_modules -name "LICENSE.*" -type f -delete
find node_modules -name "license*" -type f -delete
find node_modules -name "CHANGELOG*" -type f -delete
find node_modules -name "README*" -type f -delete
find node_modules -name "tests" -type d -exec rm -rf {} +
find node_modules -name "test" -type d -exec rm -rf {} +
find node_modules -name "example" -type d -exec rm -rf {} +
find node_modules -name "examples" -type d -exec rm -rf {} +
find node_modules -name "docs" -type d -exec rm -rf {} +
find node_modules -name "doc" -type d -exec rm -rf {} +

# Remove cached and tmp files
echo "Removing temporary and cache files..."
find . -name ".DS_Store" -type f -delete
find . -name "*.swp" -type f -delete
find . -name "*.swo" -type f -delete
find . -name "Thumbs.db" -type f -delete
find . -name ".cache" -type d -exec rm -rf {} +
find . -name ".jest" -type d -exec rm -rf {} +

# iOS cleanup
echo "Cleaning iOS build files..."
rm -rf ios/build
rm -rf ios/Pods/Documentation
rm -rf ios/Pods/*/Documentation
find ios/Pods -name "*.md" -type f -delete
find ios/Pods -name "*.txt" -type f -delete

echo "✅ Cleanup complete! Build size should be significantly reduced." 