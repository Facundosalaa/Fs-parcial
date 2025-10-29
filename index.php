<?php
/**
 * ============================================
 * QUIZMASTER - PÁGINA PRINCIPAL
 * ============================================
 * Autor: [Tu Nombre] (FS)
 * Fecha: 29/10/2025
 * Descripción: Plataforma de trivia educativa interactiva
 */

require_once 'fs_config.php';
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="QuizMaster - Plataforma de trivia educativa para gamificar el aprendizaje">
    <meta name="author" content="[Tu Nombre] (FS)">
    <title>QuizMaster - Trivia Educativa</title>
    
    <!-- CSS -->
   <link rel="stylesheet" href="fs_css/fs_estilos.css">
    
    <!-- Favicon (opcional) -->
    <link rel="icon" type="image/svg+xml" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><text y='.9em' font-size='90'>🎯</text></svg>">
</head>
<body>
    <!-- ============================================
         HEADER
         ============================================ -->
    <header class="fs-header">
        <h1 class="fs-logo">🎯 QuizMaster</h1>
        <p class="fs-subtitulo">Pon a prueba tus conocimientos</p>
    </header>

    <div class="fs-container">
        <!-- ============================================
             SECCIÓN: INICIO
             ============================================ -->
        <section id="fs-seccion-inicio" class="fs-seccion fs-activa">
            <div class="fs-card fs-inicio-card">
                <h2>¡Bienvenido al Quiz!</h2>
                <p style="margin-bottom: 2rem; color: #64748b;">
                    Responde 10 preguntas de diferentes categorías y demuestra tu conocimiento.
                    Cada respuesta correcta suma puntos, ¡y puedes ganar bonus por velocidad!
                </p>

                <div class="fs-form-group">
                    <label for="fs-jugador-nombre">
                        👤 Ingresa tu nombre para comenzar:
                    </label>
                    <input 
                        type="text" 
                        id="fs-jugador-nombre" 
                        class="fs-input" 
                        placeholder="Ej: María González"
                        maxlength="100"
                        required
                    >
                </div>

                <button id="fs-btn-iniciar" class="fs-btn fs-btn-primary">
                    🚀 Iniciar Quiz
                </button>

                <div style="margin-top: 2rem; padding: 1rem; background: #f1f5f9; border-radius: 12px; text-align: left;">
                    <h3 style="margin-bottom: 0.5rem; color: #1e293b;">📚 Categorías:</h3>
                    <ul style="list-style: none; padding-left: 0; color: #64748b;">
                        <li>🏛 Historia</li>
                        <li>🔬 Ciencia</li>
                        <li>🌍 Geografía</li>
                        <li>🎨 Arte y Cultura</li>
                        <li>⚽ Deportes</li>
                    </ul>
                </div>
            </div>
        </section>

        <!-- ============================================
             SECCIÓN: LOADING
             ============================================ -->
        <section id="fs-seccion-loading" class="fs-seccion">
            <div class="fs-card fs-loading-card">
                <div class="fs-spinner"></div>
                <h2>Cargando preguntas...</h2>
                <p style="color: #64748b;">Preparando tu quiz personalizado</p>
            </div>
        </section>

        <!-- ============================================
             SECCIÓN: JUEGO
             ============================================ -->
        <section id="fs-seccion-juego" class="fs-seccion">
            <div class="fs-card">
                <!-- Header del juego -->
                <div class="fs-game-header">
                    <div class="fs-game-info">
                        <div class="fs-info-item">
                            <span class="fs-info-label">Pregunta</span>
                            <span class="fs-info-value">
                                <span id="fs-numero-pregunta">1</span>/<span id="fs-total-preguntas">10</span>
                            </span>
                        </div>
                        <div class="fs-info-item">
                            <span class="fs-info-label">Puntaje</span>
                            <span class="fs-info-value" id="fs-puntaje-actual">0</span>
                        </div>
                    </div>

                    <div class="fs-timer-container">
                        <div class="fs-timer-circle">
                            <span id="fs-timer">30</span>
                        </div>
                    </div>
                </div>

                <!-- Barra de progreso -->
                <div class="fs-progreso-container">
                    <div class="fs-barra-progreso-container">
                        <div id="fs-barra-progreso" class="fs-barra-progreso" style="width: 0%"></div>
                    </div>
                </div>

                <!-- Timer bar -->
                <div class="fs-timer-bar-container" style="margin-bottom: 2rem;">
                    <div id="fs-timer-bar" class="fs-timer-bar" style="width: 100%"></div>
                </div>

                <!-- Pregunta -->
                <div class="fs-pregunta-container">
                    <div id="fs-pregunta-texto">
                        <!-- Se llena dinámicamente con JavaScript -->
                    </div>
                </div>

                <!-- Opciones -->
                <div id="fs-opciones-container" class="fs-opciones-container">
                    <!-- Se llena dinámicamente con JavaScript -->
                </div>

                <!-- Feedback -->
                <div id="fs-feedback" class="fs-feedback"></div>
            </div>
        </section>

        <!-- ============================================
             SECCIÓN: RESULTADOS
             ============================================ -->
        <section id="fs-seccion-resultados" class="fs-seccion">
            <div class="fs-card fs-resultados-card">
                <div class="fs-resultado-header">
                    <h2>¡Quiz Completado!</h2>
                    <p class="fs-resultado-mensaje" id="fs-resultado-mensaje">¡Excelente!</p>
                    <p style="color: #64748b; margin-bottom: 1rem;">
                        <strong id="fs-resultado-nombre">Jugador</strong>
                    </p>
                </div>

                <div class="fs-resultado-puntaje-grande" id="fs-resultado-puntaje">0</div>
                <p style="color: #64748b; margin-bottom: 2rem;">puntos totales</p>

                <div class="fs-resultado-estadisticas">
                    <div class="fs-estadistica">
                        <div class="fs-estadistica-label">Correctas</div>
                        <div class="fs-estadistica-value">
                            <span id="fs-resultado-correctas">0</span>/<span id="fs-resultado-totales">10</span>
                        </div>
                    </div>

                    <div class="fs-estadistica">
                        <div class="fs-estadistica-label">Porcentaje</div>
                        <div class="fs-estadistica-value" id="fs-resultado-porcentaje">0%</div>
                    </div>
                </div>

                <!-- Ranking -->
                <div class="fs-ranking-container" id="fs-ranking-container">
                    <h3>🏆 Top 10 Mejores Puntajes</h3>
                    <!-- Se llena dinámicamente -->
                </div>

                <div style="margin-top: 2rem;">
                    <button id="fs-btn-reiniciar" class="fs-btn fs-btn-primary">
                        🔄 Jugar de Nuevo
                    </button>
                </div>
            </div>
        </section>
    </div>

    <!-- ============================================
         FOOTER
         ============================================ -->
    <footer style="text-align: center; padding: 2rem; color: white; opacity: 0.8;">
        <p>&copy; <?php echo date('Y'); ?> QuizMaster - Proyecto FS</p>
        <p style="font-size: 0.875rem;">Plataforma de Trivia Educativa</p>
    </footer>

    <!-- JavaScript -->
    <script src="fs_js/fs_app.js"></script>
</body>
</html>