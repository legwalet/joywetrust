<?php
/** WordPress base configuration file */
define('DB_NAME', 'wordpress');
define('DB_USER', 'root');
define('DB_PASSWORD', 'root_password');
define('DB_HOST', 'localhost');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys and Salts.
 */
define('AUTH_KEY',         '1K|ef}X^|~!D:&6`{xC5 [-n)MDRC!QjgNbp.O7$H0!k*sTtJ052+6|$C?,^Ru7l');
define('SECURE_AUTH_KEY',  '6c^LEF7vS,1fyy=H-L%U40CzxDK<QJ9~T+<AHI|Gz[d!-zjT9~5Ro*=X87rzz(Ca');
define('LOGGED_IN_KEY',    '@fJmA^FhBt%+x>wjy6h?];Y<tib6kMG~E^!FA?8M=+fzf9-Va(ON|~Sxp/l)9J6`');
define('NONCE_KEY',        ' c<;YE*dty<5r/n]-Fdt9lP.(aat?hOe{z+[3zP|$jk`F` j=~u~kB~/kZmK-T[q');
define('AUTH_SALT',        '9b7fuf+I^h1U+^>mLdl}!25W/Z)6|81-wdch}ccG-|P&y!M!-UnQa/d:[q0/F(Eh');
define('SECURE_AUTH_SALT', 'woP s),,m..>t.8_q=K<^LgvR@A1a_X9=k0l#9dJ;l9!`.|+pW]1hQ8H1UiaBF>2');
define('LOGGED_IN_SALT',   ']P|AM|kv5XWz#|dxM5<]2L0+Kq5;Lt(dHf@!:A-:CFw6|l~Z_p`SoPeVX2wT|b@/');
define('NONCE_SALT',       '1$)L|/G>93UCgrd:gZ`vY(YY}SMT:4|V)<=H(~4SsyHoElc(PjK-&!nmWCgWCS2v');

/** Database table prefix */
$table_prefix  = 'wp_';

/** WordPress debugging mode */
define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
define('WP_DEBUG_DISPLAY', false);

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
    define('ABSPATH', __DIR__ . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
