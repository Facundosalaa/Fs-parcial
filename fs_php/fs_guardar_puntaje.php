<?php
/**
 * ============================================
 * QUIZMASTER - API VALIDAR RESPUESTA
 * ============================================
 * Autor: [Tu Nombre] (FS)
 * Fecha: 29/10/2025
 * Descripción: API para validar si una respuesta es correcta
 * Endpoint: POST /fs_api_validar.php
 */

require_once 'fs_config.php';

// Solo permitir método POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    fs_json_response(['error' => 'Método no permitido. Use POST'], 405);
}

// Obtener datos JSON
$json = file_get_contents('php://input');
$datos = json_decode($json, true);

// Validar datos
if (!$datos || !isset($datos['pregunta_id']) || !isset($datos['opcion_id'])) {
    fs_json_response(['error' => 'Datos incompletos. Se requiere pregunta_id y opcion_id'], 400);
}

$pregunta_id = (int)$datos['pregunta_id'];
$opcion_id = (int)$datos['opcion_id'];
$tiempo_respuesta = isset($datos['tiempo_respuesta']) ? (int)$datos['tiempo_respuesta'] : 0;

// Conectar a BD
$pdo = fs_conectar_db();
if (!$pdo) {
    fs_json_response(['error' => 'Error de conexión'], 500);
}

try {
    // Obtener información de la pregunta y la opción seleccionada
    $sql = "SELECT 
                o.es_correcta,
                o.opcion_texto as respuesta_seleccionada,
                p.puntos as puntos_base,
                p.tiempo_segundos,
                (SELECT opcion_texto FROM fs_opciones WHERE pregunta_id = :pregunta_id2 AND es_correcta = 1 LIMIT 1) as respuesta_correcta
            FROM fs_opciones o
            INNER JOIN fs_preguntas p ON o.pregunta_id = p.id
            WHERE o.id = :opcion_id AND o.pregunta_id = :pregunta_id";
    
    $stmt = $pdo->prepare($sql);
    $stmt->execute([
        ':opcion_id' => $opcion_id,
        ':pregunta_id' => $pregunta_id,
        ':pregunta_id2' => $pregunta_id
    ]);
    
    $resultado = $stmt->fetch();
    
    if (!$resultado) {
        fs_json_response(['error' => 'Pregunta u opción no encontrada'], 404);
    }
    
    // Calcular puntos
    $es_correcta = (bool)$resultado['es_correcta'];
    $puntos = 0;
    
    if ($es_correcta) {
        $puntos = $resultado['puntos_base'];
        
        // Bonus por velocidad (si responde en menos del 50% del tiempo)
        if ($tiempo_respuesta < ($resultado['tiempo_segundos'] / 2)) {
            $puntos += PUNTOS_BONUS_VELOCIDAD;
        }
    }
    
    // Responder
    fs_json_response([
        'success' => true,
        'es_correcta' => $es_correcta,
        'puntos_obtenidos' => $puntos,
        'respuesta_seleccionada' => $resultado['respuesta_seleccionada'],
        'respuesta_correcta' => $resultado['respuesta_correcta'],
        'tiempo_respuesta' => $tiempo_respuesta
    ]);
    
} catch (PDOException $e) {
    error_log("Error en fs_api_validar: " . $e->getMessage());
    fs_json_response(['error' => 'Error al validar respuesta'], 500);
}
?>