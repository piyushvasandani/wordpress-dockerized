<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/documentation/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', getenv('MY_DB_NAME') ?: 'default_database_name' );
define( 'DB_USER', getenv('MY_DB_USER') ?: 'default_username' );
define( 'DB_PASSWORD', getenv('MY_DB_PASSWORD') ?: 'default_password' );
define( 'DB_HOST', getenv('MY_DB_HOST') ?: 'localhost' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'qP;Aa0eF=RlK<-DB5dJRcEDD/G`|$g<5uYe51CiUjFn+%jo$es$`t7pZC@#[bH?P' );
define( 'SECURE_AUTH_KEY',  '0c6iNc4m((TMKK/4|*(6Z.5r7y&H3*O7bo7!Ex@#Fy!yi~1~/0<2N/`Qv4[v9LQ-' );
define( 'LOGGED_IN_KEY',    'Xo4eKnHrKa U=BnuLbqz14@)Gt`8]Q!UV6?8WTSzvDqnl^IlJaCUAu3}1+Cg&p-~' );
define( 'NONCE_KEY',        'dlzoP]Q3{9W<6`29bZt&eKYS6-z,uvt6)4A`lle3-+Hi#3*(,y!)35a+ND%`MK!k' );
define( 'AUTH_SALT',        'y4~&VsVo1e_z[5<DBm/}Ic3Y@q!t|^v3y` 5kDD@==`k)Cs(N5-+n0b;?r5znR]p' );
define( 'SECURE_AUTH_SALT', '[Q1)jX9;i2/DUS,_bzuC>-dRW.la|wwC.@@4JQ+w;`]oaUC+,qC&yop]Y.J,Nc1f' );
define( 'LOGGED_IN_SALT',   'zfT.h|?XKIL$4<J]HsRg)iw*w?N`ADQcQR*Yeec{ByOC;*yLJi[Y1+Sj]HxpNJX7' );
define( 'NONCE_SALT',       'ck+%Sl$k[H?/(..,bP1u<FQXGz~yrp*27; ;L**G81Xims*;IWUU<T~Ez=Q&4)cG' );

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/documentation/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';

