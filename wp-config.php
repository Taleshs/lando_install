<?php

define('AUTOLOAD_PATH', __DIR__ . '/vendor/autoload.php');
require_once AUTOLOAD_PATH;
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

/**
 * As configurações básicas do WordPress
 *
 * O script de criação wp-config.php usa esse arquivo durante a instalação.
 * Você não precisa usar o site, você pode copiar este arquivo
 * para "wp-config.php" e preencher os valores.
 *
 * Este arquivo contém as seguintes configurações:
 *
 * * Configurações do banco de dados
 * * Chaves secretas
 * * Prefixo do banco de dados
 * * ABSPATH
 *
 * @link https://wordpress.org/documentation/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Configurações do banco de dados - Você pode pegar estas informações com o serviço de hospedagem ** //
/** O nome do banco de dados do WordPress */
define( 'DB_NAME', $_ENV['DB_NAME'] );

/** Usuário do banco de dados MySQL */
define( 'DB_USER', $_ENV['DB_USER'] );

/** Senha do banco de dados MySQL */
define( 'DB_PASSWORD', $_ENV['DB_PASSWORD'] );

/** Nome do host do MySQL */
define( 'DB_HOST', $_ENV['DB_HOST'] );

/** Charset do banco de dados a ser usado na criação das tabelas. */
define( 'DB_CHARSET', $_ENV['DB_CHARSET'] );

/** O tipo de Collate do banco de dados. Não altere isso se tiver dúvidas. */
define( 'DB_COLLATE', '' );

/**#@+
 * Chaves únicas de autenticação e salts.
 *
 * Altere cada chave para um frase única!
 * Você pode gerá-las
 * usando o {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org
 * secret-key service}
 * Você pode alterá-las a qualquer momento para invalidar quaisquer
 * cookies existentes. Isto irá forçar todos os
 * usuários a fazerem login novamente.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'ZcPbrZ+h@n]OKk~F&o{%+a{/i%;irut,n7{-bQPiP+VQ$Bl*PIK>pjA0.q&jsO$`' );
define( 'SECURE_AUTH_KEY',  '%pMdL^Soq&5!k xV/^@I, SYQ!_&iyj6V:ffnlzN8w-=i>E#P.M?>dolS6~y-p:9' );
define( 'LOGGED_IN_KEY',    'Z$&k.@G^clNhZi sn,bDYvPPQOOYNO#b~n?:C=Rm&({%(wBcddRK-zR&;OTdw49U' );
define( 'NONCE_KEY',        'q7$4dcnW@5vw#w29W6tpDVTY)J7YaJtls:_p`b92vmTH6qINs)uqmYwIx<X9f<>2' );
define( 'AUTH_SALT',        'wd?EGf$!ygc6]3AGl:.OGPqZg;OZ6E;Z]ENLCR)QhR;TkBAhSI,HW6vWj&}}kiI!' );
define( 'SECURE_AUTH_SALT', 'vq&C,v9(,;zn3o?{0VvFWl^oB0U1PIuPp320Zd{z}/?t/uT=j3{2=`(zMY9/~-Nn' );
define( 'LOGGED_IN_SALT',   'RY]32 S!^eF.WmR.mp1J b&[818PkmfG@u-+rm?K~#sX?fgTx(t8rM-t=lhE$%^F' );
define( 'NONCE_SALT',       '3!L`.y=bQGR8:16$!W&[g|)yFF gMl.4.7J*~DR:~#;`:bgk*P]<On_;%Q7ZbncU' );

/**#@-*/

/**
 * Prefixo da tabela do banco de dados do WordPress.
 *
 * Você pode ter várias instalações em um único banco de dados se você der
 * um prefixo único para cada um. Somente números, letras e sublinhados!
 */
$table_prefix = $_ENV['DB_PREFIX'];

/**
 * Para desenvolvedores: Modo de debug do WordPress.
 *
 * Altere isto para true para ativar a exibição de avisos
 * durante o desenvolvimento. É altamente recomendável que os
 * desenvolvedores de plugins e temas usem o WP_DEBUG
 * em seus ambientes de desenvolvimento.
 *
 * Para informações sobre outras constantes que podem ser utilizadas
 * para depuração, visite o Codex.
 *
 * @link https://wordpress.org/documentation/article/debugging-in-wordpress/
 */
define('WP_DEBUG', false );
define('WP_DEBUG_LOG', true);
define('WP_DEBUG_DISPLAY', true); 

define( 'WP_HOME', $_ENV['WP_HOME'] );
define( 'WP_SITEURL', $_ENV['WP_SITEURL'] );

define('WP_ENV',  $_ENV['WP_ENV'] );

/* Adicione valores personalizados entre esta linha até "Isto é tudo". */
// Aumenta o limite de memória
define('WP_MAX_MEMORY_LIMIT', '512M');

// Aumenta o limite de tempo de execução
define('WP_TIMEOUT_LIMIT', 600);

/* Isto é tudo, pode parar de editar! :) */

/** Caminho absoluto para o diretório WordPress. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Configura as variáveis e arquivos do WordPress. */
require_once ABSPATH . 'wp-settings.php';