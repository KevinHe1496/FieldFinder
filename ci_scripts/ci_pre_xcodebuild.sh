#!/bin/sh

echo '🔧 Change Beta App Icon'

APP_ICON_PATH="$CI_PRIMARY_REPOSITORY_PATH/FieldFinder-App/Assets.xcassets/AppIcon.appiconset"
BETA_ICON_PATH="$CI_PRIMARY_REPOSITORY_PATH/ci_scripts/AppIcon-Beta.appiconset"

echo "App Icon Path: $APP_ICON_PATH"
echo "Beta Icon Path: $BETA_ICON_PATH"

# Verifica que el beta icon exista antes de intentar moverlo
if [ -d "$BETA_ICON_PATH" ]; then
    rm -rf "$APP_ICON_PATH"
    mv "$BETA_ICON_PATH" "$APP_ICON_PATH"
    echo "✅ App icon replaced successfully."
else
    echo "❌ Beta icon not found at $BETA_ICON_PATH"
    # No salimos con error para evitar romper el build si quieres tolerancia
    exit 0
fi
