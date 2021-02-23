<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress_db' );

/** MySQL database username */
define( 'DB_USER', 'db_admin' );

/** MySQL database password */
define( 'DB_PASSWORD', '' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
// define( 'AUTH_KEY',         'put your unique phrase here' );
// define( 'SECURE_AUTH_KEY',  'put your unique phrase here' );
// define( 'LOGGED_IN_KEY',    'put your unique phrase here' );
// define( 'NONCE_KEY',        'put your unique phrase here' );
// define( 'AUTH_SALT',        'put your unique phrase here' );
// define( 'SECURE_AUTH_SALT', 'put your unique phrase here' );
// define( 'LOGGED_IN_SALT',   'put your unique phrase here' );
// define( 'NONCE_SALT',       'put your unique phrase here' );

define('AUTH_KEY',			'[WKj5ZGqWRDM!(wpP4scTR8VOb+[GfoE9|0E-eTTVOY|][?o-qHUv|OTxfqa5a>R');
define('SECURE_AUTH_KEY',	'U+m! 12`!c8w+y3/Q++B;R~?SMxwXv7Om^S;Z[a<Wc9dj[%.b2=m}%4&``9|<-;6');
define('LOGGED_IN_KEY',		'1,<q^]%Kvm2yS+-Inw+O-8edK4lQ/jT?~&9P5|ldELwhVwLIt8Duh}!?dCP,AbT$');
define('NONCE_KEY',			'zs9sBIZ[DHhi`aPH-^v|PnH*I@vf+~H/RG20UdS_H~6SM:DhfF2>I@T:[f>+VXv_');
define('AUTH_SALT',			'~i2;0`U&X43OMiQjx4kJzr}7GM#35XFmq2x7_>G2fG<eS}fYlbmhBS5;*JH0#k?e');
define('SECURE_AUTH_SALT',	'[2d^W!Q+Bc5BCV|N|p+uA!Hk6i&51rji[8y=~kFUM}ss.h}ed!71)!`K`V:0FS/>');
define('LOGGED_IN_SALT',	'!*Mz6P)]V;A3h9i!!K~*%l7?>!*G(UUul[DH^2=|eo/!wTshl&oI:+pty0lr,E2T');
define('NONCE_SALT',		's+n_iJ>1;c#-L]ONC8Vd|es7:@@b6DB&#8Cm{lDfo96y&Oq92l(t,$7&Nl-dS&51');


/**#@-*/

/**
 * WordPress Database Table prefix.
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
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';