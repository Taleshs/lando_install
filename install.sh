#!/bin/zsh

# Define o repositório e a branch correta
REPO_URL="https://raw.githubusercontent.com/Taleshs/lando_install/refs/heads/main"
FILES=(".env" ".lando.yml" "composer.json" "wp-config.php")

# Baixa os arquivos necessários
for file in "${FILES[@]}"; do
    if [ ! -f "$file" ]; then
        echo "Baixando $file..."
        wget -q "$REPO_URL/$file" -O "$file"
    fi
done

# Define DB_PREFIX, assuming "_wp" as default if no argument is provided
DB_PREFIX="${1:-_wp}"

# Define the source directory (install folder)
INSTALL_DIR="$(dirname "$0")"

# Define the destination directory as the current working directory
DEST_DIR="$(pwd)"

# Get the project folder name (last part of the path)
PROJECT_NAME="$(basename "$DEST_DIR")"

# Define URLs
WP_HOME="https://${PROJECT_NAME}.lndo.site"
WP_SITEURL="https://${PROJECT_NAME}.lndo.site"

# Copy files
cp "$INSTALL_DIR/.env" "$DEST_DIR"
cp "$INSTALL_DIR/.lando.yml" "$DEST_DIR"
cp "$INSTALL_DIR/composer.json" "$DEST_DIR"
cp "$INSTALL_DIR/wp-config.php" "$DEST_DIR"

# Update .env file with new values
sed -i "s|DB_PREFIX =.*|DB_PREFIX = \"$DB_PREFIX\"|" "$DEST_DIR/.env"
sed -i "s|WP_HOME =.*|WP_HOME = \"$WP_HOME\"|" "$DEST_DIR/.env"
sed -i "s|WP_SITEURL =.*|WP_SITEURL = \"$WP_SITEURL\"|" "$DEST_DIR/.env"

# Update the "name" field in .lando.yml
sed -i "1s|^name:.*|name: $PROJECT_NAME|" "$DEST_DIR/.lando.yml"

echo "Files copied and updated:"
echo "- .env updated with DB_PREFIX, WP_HOME, and WP_SITEURL"
echo "- .lando.yml updated with name: $PROJECT_NAME"
echo "- DB_PREFIX = $DB_PREFIX"
echo "- WP_HOME = $WP_HOME"
echo "- WP_SITEURL = $WP_SITEURL"

# Start Lando environment
echo "Starting Lando environment..."
lando start

# Install Composer dependencies
echo "Installing Composer dependencies..."
lando composer install

# Download WordPress core
echo "Downloading WordPress..."
lando wp core download --allow-root

# Import database if the file exists
DB_FILE="db/db.sql"

if [ -f "$DB_FILE" ]; then
    echo "Importing database..."
    lando db-import "$DB_FILE"
    echo "Database imported successfully!"
else
    echo "No db.sql file found in $DB_FILE, skipping database import."
fi

echo "Setup complete!"
