<?php
// ** MySQL settings - You can get this info from your web host ** //
define('DB_NAME', getenv('WORDPRESS_DB_NAME') ?: 'wordpress');

/** MySQL database username */
define('DB_USER', getenv('WORDPRESS_DB_USER') ?: 'wordpress');

/** MySQL database password */
define('DB_PASSWORD', getenv('WORDPRESS_DB_PASSWORD') ?: 'passwd');

/** MySQL hostname */
define('DB_HOST', getenv('WORDPRESS_DB_HOST') ?: 'db');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8mb4');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 */
define('AUTH_KEY',         '1K|ef}X^|~!D:&6`{xC5 [-n)MDRC!QjgNbp.O7$H0!k*sTtJ052+6|$C?,^Ru7l');
define('SECURE_AUTH_KEY',  '6c^LEF7vS,1fyy=H-L%U40CzxDK<QJ9~T+<AHI|Gz[d!-zjT9~5Ro*=X87rzz(Ca');
define('LOGGED_IN_KEY',    '@fJmA^FhBt%+x>wjy6h?];Y<tib6kMG~E^!FA?8M=+fzf9-Va(ON|~Sxp/l)9J6`');
define('NONCE_KEY',        ' c<;YE*dty<5r/n]-Fdt9lP.(aat?hOe{z+[3zP|$jk`F` j=~u~kB~/kZmK-T[q');
define('AUTH_SALT',        '9b7fuf+I^h1U+^>mLdl}!25W/Z)6|81-wdch}ccG-|P&y!M!-UnQa/d:[q0/F(Eh');
define('SECURE_AUTH_SALT', 'woP s),,m..>t.8_q=K<^LgvR@A1a_X9=k0l#9dJ;l9!`.|+pW]1hQ8H1UiaBF>2');
define('LOGGED_IN_SALT',   ']P|AM|kv5XWz#|dxM5<]2L0+Kq5;Lt(dHf@!:A-:CFw6|l~Z_p`SoPeVX2wT|b@/');
define('NONCE_SALT',       '1$)L|/G>93UCgrd:gZ`vY(YY}SMT:4|V)<=H(~4SsyHoElc(PjK-&!nmWCgWCS2v');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each a unique
 * prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 */
define('WP_DEBUG', false);

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
    define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
