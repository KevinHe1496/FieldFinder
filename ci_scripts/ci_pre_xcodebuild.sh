#!/bin/sh

echo "🔧 Change Beta App Icon"

REPO_PATH="$CI_PRIMARY_REPOSITORY_PATH"
APP_ICON_PATH="$REPO_PATH/FieldFinder-App/Assets.xcassets/AppIcon.appiconset"
BETA_ICON_PATH="$REPO_PATH/ci_scripts/AppIcon-Beta.appiconset"

echo "📁 REPO_PATH: $REPO_PATH"
echo "📁 App Icon Path: $APP_ICON_PATH"
echo "📁 Beta Icon Path: $BETA_ICON_PATH"

if [ -d "$BETA_ICON_PATH" ]; then
    echo "🧹 Removing old app icon..."
    rm -rf "$APP_ICON_PATH"

    echo "📦 Moving beta app icon..."
    mv "$BETA_ICON_PATH" "$APP_ICON_PATH"

    echo "✅ App icon replaced successfully."
else
    echo "❌ Beta icon not found. Script failed."
    exit 1
fi
