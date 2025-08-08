#!/bin/sh

# ci_pre_xcodebuild.sh
# FieldFinder-App
# Created by Kevin Heredia on 26/7/25.

echo "🔧 Change Beta App Icon"

# Rutas absolutas basadas en la raíz del repositorio
REPO_PATH="$CI_PRIMARY_REPOSITORY_PATH"
APP_ICON_PATH="$REPO_PATH/FieldFinder-App/Assets.xcassets/AppIcon.appiconset"
BETA_ICON_PATH="$REPO_PATH/ci_scripts/AppIcon-Beta.appiconset"

echo "📁 App icon path: $APP_ICON_PATH"
echo "📁 Beta icon path: $BETA_ICON_PATH"

# Verificar si el archivo AppIcon-Beta.appiconset existe antes de moverlo
if [ -d "$BETA_ICON_PATH" ]; then
    rm -rf "$APP_ICON_PATH"
    mv "$BETA_ICON_PATH" "$APP_ICON_PATH"
    echo "✅ App icon replaced successfully."
else
    echo "❌ Beta icon not found at: $BETA_ICON_PATH"
    exit 1
fi
