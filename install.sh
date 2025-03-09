#!/bin/zsh

# Define o repositório e a branch correta
REPO_URL="https://raw.githubusercontent.com/Taleshs/lando_install/refs/heads/main"
FILES=(".env" ".lando.yml" "composer.json" "wp-config.php")

# Baixa os arquivos necessários
for file in "${FILES[@]}"; do
    if [ ! -f "$file" ]; then
        echo "Baixando $file..."
        wget -q "$REPO_URL/$file" -O "$file"
        
        # Verifica se o arquivo foi baixado corretamente
        if [ ! -s "$file" ]; then
            echo "Erro: O arquivo $file não foi baixado corretamente!"
            rm -f "$file"  # Remove o arquivo vazio
            exit 1
        fi
    fi
done

# Define DB_PREFIX, assumindo "wp_" como padrão caso não seja passado um argumento
DB_PREFIX="${1:-wp_}"

# Define o diretório de instalação
INSTALL_DIR="$(dirname "$0")"

# Define o diretório de destino como o diretório atual
DEST_DIR="$(pwd)"

# Obtém o nome da pasta do projeto (última parte do caminho)
PROJECT_NAME="$(basename "$DEST_DIR")"

# Define URLs
WP_HOME="https://${PROJECT_NAME}.lndo.site"
WP_SITEURL="https://${PROJECT_NAME}.lndo.site"

# Copia os arquivos apenas se não existirem no destino
for file in ".env" ".lando.yml" "composer.json" "wp-config.php"; do
    if [ ! -f "$DEST_DIR/$file" ]; then
        echo "Copiando $file..."
        cp "$INSTALL_DIR/$file" "$DEST_DIR"
    else
        echo "Ignorando $file, já existe no destino."
    fi
done

# Atualiza o arquivo .env com os novos valores
sed -i "s|DB_PREFIX =.*|DB_PREFIX = \"$DB_PREFIX\"|" "$DEST_DIR/.env"
sed -i "s|WP_HOME =.*|WP_HOME = \"$WP_HOME\"|" "$DEST_DIR/.env"
sed -i "s|WP_SITEURL =.*|WP_SITEURL = \"$WP_SITEURL\"|" "$DEST_DIR/.env"

# Atualiza o campo "name" no .lando.yml
sed -i "1s|^name:.*|name: $PROJECT_NAME|" "$DEST_DIR/.lando.yml"

echo "Arquivos copiados e atualizados:"
echo "- .env atualizado com DB_PREFIX, WP_HOME e WP_SITEURL"
echo "- .lando.yml atualizado com name: $PROJECT_NAME"
echo "- DB_PREFIX = $DB_PREFIX"
echo "- WP_HOME = $WP_HOME"
echo "- WP_SITEURL = $WP_SITEURL"

# Inicia o ambiente Lando
echo "Iniciando o ambiente Lando..."
lando start

# Instala as dependências do Composer
echo "Instalando dependências do Composer..."
lando composer install

# Baixa o WordPress
echo "Baixando o WordPress..."
lando wp core download --allow-root

# Importa o banco de dados, se existir
DB_FILE="db/db.sql"

if [ -f "$DB_FILE" ]; then
    echo "Importando banco de dados..."
    lando db-import "$DB_FILE"
    echo "Banco de dados importado com sucesso!"
else
    echo "Nenhum arquivo db.sql encontrado em $DB_FILE, ignorando importação do banco."
fi

echo "Configuração concluída!"
