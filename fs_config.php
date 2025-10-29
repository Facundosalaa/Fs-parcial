<?php
/**
 * fs_config.php (fsconf) — Configuración global del proyecto FS
 * Ubicación recomendada: raíz del proyecto (junto a index.php)
 * Uso: require_once __DIR__ . '/fs_config.php';
 */

/* ===== Utilidad: leer variables de entorno con default ===== */
if (!function_exists('fs_env')) {
  function fs_env(string $key, $default = null) {
    $v = getenv($key);
    return ($v === false || $v === null || $v === '') ? $default : $v;
  }
}

/* ===== Config de Base de Datos =====
 * Si usás un puerto distinto (ej. 3307), ponelo en FS_DB_HOST como '127.0.0.1:3307'
 */
if (!defined('FS_DB_HOST')) define('FS_DB_HOST', fs_env('FS_DB_HOST', '127.0.0.1'));
if (!defined('FS_DB_USER')) define('FS_DB_USER', fs_env('FS_DB_USER', 'root'));
if (!defined('FS_DB_PASS')) define('FS_DB_PASS', fs_env('FS_DB_PASS', ''));
if (!defined('FS_DB_NAME')) define('FS_DB_NAME', fs_env('FS_DB_NAME', 'fs_parcial_plp3'));

/* ===== Rutas básicas (opcional) ===== */
if (!defined('FS_BASE_PATH')) define('FS_BASE_PATH', __DIR__);
if (!defined('FS_API_PATH'))  define('FS_API_PATH', FS_BASE_PATH . DIRECTORY_SEPARATOR . 'api');

/* ===== Opciones de app (opcional) ===== */
if (!defined('FS_APP_NAME')) define('FS_APP_NAME', 'FS Quiz');
if (!defined('FS_DEBUG'))    define('FS_DEBUG', fs_env('FS_DEBUG', '0') === '1');

/* ===== Manejo de errores (no mostrar en producción) ===== */
if (FS_DEBUG) {
  ini_set('display_errors', '1');
  error_reporting(E_ALL);
} else {
  ini_set('display_errors', '0');
  error_reporting(E_ALL & ~E_NOTICE & ~E_STRICT & ~E_DEPRECATED);
}
