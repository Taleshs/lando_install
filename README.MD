# Setup Automatizado com Lando

Este documento contém instruções para configurar um ambiente WordPress utilizando Lando de forma automatizada. O processo inclui a configuração dos arquivos `.env` e `.lando.yml`, a instalação de dependências, o download do WordPress e a importação do banco de dados.

## Requisitos

- Lando instalado ([Guia de instalação](https://docs.lando.dev/getting-started/installation.html))
- Composer instalado ([Guia de instalação](https://getcomposer.org/download/))
- Banco de dados disponível no arquivo `db/db.sql` (ele será importado automaticamente)
- A pasta do projeto deve conter apenas a pasta `db/` e o arquivo `db.sql` antes de rodar o script

## Como usar

Clone o repositório e entre na pasta do projeto:
```sh
git clone https://github.com/seu-usuario/seu-repositorio.git
cd seu-repositorio
```

Certifique-se de que a pasta do projeto contém apenas `db/` e `db/db.sql` antes de rodar o script.

Execute o script de instalação:
```sh
./install/install.sh meu_prefixo_
```

Se nenhum `DB_PREFIX` for fornecido, o script usará `_wp` como padrão.

## O que o script faz

- Copia os arquivos `.env`, `.lando.yml`, `composer.json` e `wp-config.php`
- Configura automaticamente os valores no `.env` (`DB_PREFIX`, `WP_HOME`, `WP_SITEURL`)
- Atualiza o nome do projeto no `.lando.yml`
- Inicia o ambiente Lando (`lando start`)
- Instala as dependências do Composer (`lando composer install`)
- Baixa o WordPress (`lando wp core download`)
- Importa o banco de dados (`lando db-import db.sql`) se o arquivo existir

---

# Automated Setup with Lando

This document provides instructions to automatically set up a WordPress environment using Lando. The process includes configuring the `.env` and `.lando.yml` files, installing dependencies, downloading WordPress, and importing the database.

## Requirements

- Lando installed ([Installation Guide](https://docs.lando.dev/getting-started/installation.html))
- Database available in `db/db.sql` (it will be imported automatically)
- The project folder should contain only the `db/` folder and the `db.sql` file before running the script

## How to Use

Clone the repository and navigate into the project folder:
```sh
git clone https://github.com/your-user/your-repository.git
cd your-repository
```

Ensure that the project folder contains only `db/` and `db/db.sql` before running the script.

Run the installation script:
```sh
./install/install.sh my_prefix_
```

If no `DB_PREFIX` is provided, the script will use `_wp` as the default.

## What the Script Does

- Copies the `.env`, `.lando.yml`, `composer.json`, and `wp-config.php` files
- Automatically sets values in `.env` (`DB_PREFIX`, `WP_HOME`, `WP_SITEURL`)
- Updates the project name in `.lando.yml`
- Starts the Lando environment (`lando start`)
- Installs Composer dependencies (`lando composer install`)
- Downloads WordPress (`lando wp core download`)
- Imports the database (`lando db-import db.sql`) if the file exists
