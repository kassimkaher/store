#!/bin/bash
# Optimized Flutter Web Build Script

echo "🚀 Building Flutter Web with optimizations..."

# Clean previous build
flutter clean

# Get dependencies
flutter pub get

# Build with optimizations
# Note: --web-renderer was removed in Flutter 3.38+, renderer is now auto-selected
flutter build web \
  --wasm \
  --release \
  --tree-shake-icons \
  --base-href="/" \
  --source-maps

echo "✅ Build complete! Output: build/web/"
echo ""
echo "📊 Build size:"
du -sh build/web/

echo ""
echo "💡 Deployment tips:"
echo "  - For Firebase: firebase deploy"
echo "  - For Apache/Nginx: Copy build/web/ contents to your web server"
echo "  - Make sure .htaccess or firebase.json caching rules are applied"
echo ""
echo "📝 Note: Flutter 3.38+ automatically selects the best renderer (CanvasKit or HTML)"
