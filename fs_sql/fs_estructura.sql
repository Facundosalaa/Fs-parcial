-- fs_estructura.sql — Esquema con prefijo fs_
CREATE DATABASE IF NOT EXISTS fs_quizmaster_plp3
  CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE fs_quizmaster_plp3;

DROP TABLE IF EXISTS fs_opciones;
DROP TABLE IF EXISTS fs_preguntas;
DROP TABLE IF EXISTS fs_partidas;

CREATE TABLE fs_preguntas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  fs_texto VARCHAR(255) NOT NULL,
  fs_categoria ENUM('HTML','CSS','JS','PHP') NOT NULL,
  fs_dificultad ENUM('facil','media','dificil') NOT NULL DEFAULT 'facil',
  fs_correcta_id INT DEFAULT NULL
) ENGINE=InnoDB;

CREATE TABLE fs_opciones (
  id INT AUTO_INCREMENT PRIMARY KEY,
  fs_pregunta_id INT NOT NULL,
  fs_texto VARCHAR(255) NOT NULL,
  fs_es_correcta TINYINT(1) NOT NULL DEFAULT 0,
  CONSTRAINT fk_fs_op_preg FOREIGN KEY (fs_pregunta_id)
    REFERENCES fs_preguntas(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE fs_partidas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  fs_nombre VARCHAR(30) NOT NULL,
  fs_puntaje INT NOT NULL,
  fs_duracion_seg INT NOT NULL,
  fs_categoria VARCHAR(10) NOT NULL,
  fs_dificultad VARCHAR(10) NOT NULL,
  fs_creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE INDEX idx_fs_p_catdif ON fs_preguntas(fs_categoria, fs_dificultad);
CREATE INDEX idx_fs_part_score ON fs_partidas(fs_puntaje, fs_duracion_seg);
