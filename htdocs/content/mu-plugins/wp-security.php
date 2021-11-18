<?php
/*
Plugin Name: WP Security
Plugin URI: https://donpablonow.sk
Description: Security customizations.
Version: 1.0
Author: donpablonow
Author URI: https://donpablonow.sk
License: GPLv2
Domain Path: /languages/
Text Domain: wbkn-wp-security
*/

/** Remove theme editor from WP Admin */
if (!defined('DISALLOW_FILE_EDIT')) {
    define('DISALLOW_FILE_EDIT', true);
}
