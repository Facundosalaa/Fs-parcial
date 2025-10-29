<?php
/**
 * ============================================
 * QUIZMASTER - API DE PREGUNTAS
 * ============================================
 * Autor: [Tu Nombre] (FS)
 * Fecha: 29/10/2025
 * Descripción: API REST para obtener preguntas aleatorias con sus opciones
 * Endpoint: GET /fs_php/fs_api_preguntas.php?cantidad=10&categoria=1
 */

require_once '../fs_config.php';

// Solo permitir método GET
if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    fs_json_response(['error' => 'Método no permitido'], 405);
}

// Obtener parámetros
$cantidad = isset($_GET['cantidad']) ? (int)$_GET['cantidad'] : PREGUNTAS_POR_PARTIDA;
$categoria_id = isset($_GET['categoria']) ? (int)$_GET['categoria'] : null;

// Validar cantidad
if ($cantidad < 1 || $cantidad > 50) {
    fs_json_response(['error' => 'La cantidad debe estar entre 1 y 50'], 400);
}

// Conectar a BD
$pdo = fs_conectar_db();
if (!$pdo) {
    fs_json_response(['error' => 'Error de conexión a la base de datos'], 500);
}

try {
    // Construir query
    $sql = "SELECT p.id, p.pregunta, p.dificultad, p.puntos, p.tiempo_segundos,
                   c.nombre as categoria, c.color as categoria_color
            FROM fs_preguntas p
            INNER JOIN fs_categorias c ON p.categoria_id = c.id
            WHERE p.activa = 1";
    
    // Filtrar por categoría si se especifica
    if ($categoria_id) {
        $sql .= " AND p.categoria_id = :categoria_id";
    }
    
    $sql .= " ORDER BY RAND() LIMIT :cantidad";
    
    $stmt = $pdo->prepare($sql);
    
    if ($categoria_id) {
        $stmt->bindParam(':categoria_id', $categoria_id, PDO::PARAM_INT);
    }
    $stmt->bindParam(':cantidad', $cantidad, PDO::PARAM_INT);
    
    $stmt->execute();
    $preguntas = $stmt->fetchAll();
    
    // Si no hay preguntas suficientes
    if (count($preguntas) < $cantidad) {
        fs_json_response([
            'error' => 'No hay suficientes preguntas disponibles',
            'disponibles' => count($preguntas)
        ], 404);
    }
    
    // Obtener opciones para cada pregunta
    $preguntas_con_opciones = [];
    
    foreach ($preguntas as $pregunta) {
        $stmt_opciones = $pdo->prepare(
            "SELECT id, opcion_texto, orden 
             FROM fs_opciones 
             WHERE pregunta_id = :pregunta_id 
             ORDER BY orden"
        );
        $stmt_opciones->execute(['pregunta_id' => $pregunta['id']]);
        $opciones = $stmt_opciones->fetchAll();
        
        // Mezclar opciones aleatoriamente
        shuffle($opciones);
        
        $preguntas_con_opciones[] = [
            'id' => $pregunta['id'],
            'pregunta' => $pregunta['pregunta'],
            'dificultad' => $pregunta['dificultad'],
            'puntos' => $pregunta['puntos'],
            'tiempo_segundos' => $pregunta['tiempo_segundos'],
            'categoria' => $pregunta['categoria'],
            'categoria_color' => $pregunta['categoria_color'],
            'opciones' => $opciones
        ];
    }
    
    // Responder con éxito
    fs_json_response([
        'success' => true,
        'total_preguntas' => count($preguntas_con_opciones),
        'preguntas' => $preguntas_con_opciones
    ]);
    
} catch (PDOException $e) {
    error_log("Error en fs_api_preguntas: " . $e->getMessage());
    fs_json_response(['error' => 'Error al obtener preguntas'], 500);
}
?>