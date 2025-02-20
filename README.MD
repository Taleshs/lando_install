# Automated Setup with Lando

This document provides instructions to automatically set up a WordPress environment using Lando. The process includes configuring the `.env` and `.lando.yml` files, installing dependencies, downloading WordPress, and importing the database.

## Requirements

- Lando installed ([Installation Guide](https://docs.lando.dev/getting-started/installation.html))
- If you have an existing database, it must be placed inside the `db/` folder as `db.sql` for automatic import. If no database is provided, the script will skip the import.
- The project folder should contain only the `db/` folder and the `db.sql` file before running the script.

## How to Use

Run the installation script directly from the repository:
```sh
 curl -s https://raw.githubusercontent.com/Taleshs/lando_install/refs/heads/main/install.sh | bash -s _wp
```

Ensure that the project folder contains only `db/` and `db/db.sql` before running the script.

Run the installation script:
```sh
./install/install.sh _wp
```

If no `DB_PREFIX` is provided, the script will use `_wp` as the default.

## What the Script Does

- Copies the `.env`, `.lando.yml`, `composer.json`, and `wp-config.php` files
- Automatically sets values in `.env` (`DB_PREFIX`, `WP_HOME`, `WP_SITEURL`)
- Updates the project name in `.lando.yml`
- Starts the Lando environment (`lando start`)
- Downloads WordPress (`lando wp core download`)
- Imports the database (`lando db-import db.sql`) if the file exists

---

# Setup Automatizado com Lando

Este documento contém instruções para configurar um ambiente WordPress utilizando Lando de forma automatizada. O processo inclui a configuração dos arquivos `.env` e `.lando.yml`, a instalação de dependências, o download do WordPress e a importação do banco de dados.

## Requisitos

- Lando instalado ([Guia de instalação](https://docs.lando.dev/getting-started/installation.html))
- Caso possua um banco de dados existente, ele deve estar na pasta `db/` com o nome `db.sql` para ser importado automaticamente. Caso contrário, o script não fará a importação.
- A pasta do projeto deve conter apenas a pasta `db/` e o arquivo `db.sql` antes de rodar o script.

## Como usar

Execute o script de instalação diretamente do repositório:
```sh
 curl -s https://raw.githubusercontent.com/Taleshs/lando_install/refs/heads/main/install.sh | bash -s _wp
```

Certifique-se de que a pasta do projeto contém apenas `db/` e `db/db.sql` antes de rodar o script.

Se nenhum `DB_PREFIX` for fornecido, o script usará `_wp` como padrão.

## O que o script faz

- Copia os arquivos `.env`, `.lando.yml`, `composer.json` e `wp-config.php`
- Configura automaticamente os valores no `.env` (`DB_PREFIX`, `WP_HOME`, `WP_SITEURL`)
- Atualiza o nome do projeto no `.lando.yml`
- Inicia o ambiente Lando (`lando start`)
- Baixa o WordPress (`lando wp core download`)
- Importa o banco de dados (`lando db-import db.sql`) se o arquivo existir
