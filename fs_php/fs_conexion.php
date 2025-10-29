<?php
// api/fs_conexion.php — conexión MySQL (mysqli) con prefijo fs_
require_once __DIR__ . '/../fs_config.php';

$fs_mysqli = @new mysqli(FS_DB_HOST, FS_DB_USER, FS_DB_PASS, FS_DB_NAME);
if ($fs_mysqli->connect_errno) {
  http_response_code(500);
  header('Content-Type: application/json; charset=utf-8');
  echo json_encode([
    'error'  => 'Error de conexión a la BD',
    'detail' => $fs_mysqli->connect_error
  ], JSON_UNESCAPED_UNICODE);
  exit;
}
$fs_mysqli->set_charset('utf8mb4');
