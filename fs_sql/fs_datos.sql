USE fs_quizmaster_plp3;

-- =============== HTML ===============
INSERT INTO fs_preguntas (fs_texto,fs_categoria,fs_dificultad) VALUES ('¿Qué etiqueta se usa para el título principal de una página?', 'HTML','facil');
SET @h1=LAST_INSERT_ID();
INSERT INTO fs_opciones VALUES (NULL,@h1,'<h1>',1),(NULL,@h1,'<title>',0),(NULL,@h1,'<header>',0),(NULL,@h1,'<head>',0);
UPDATE fs_preguntas SET fs_correcta_id=(SELECT id FROM fs_opciones WHERE fs_pregunta_id=@h1 AND fs_es_correcta=1) WHERE id=@h1;

INSERT INTO fs_preguntas (fs_texto,fs_categoria,fs_dificultad) VALUES ('¿Qué atributo hace que un enlace se abra en una pestaña nueva?', 'HTML','facil');
SET @h2=LAST_INSERT_ID();
INSERT INTO fs_opciones VALUES (NULL,@h2,'target="_blank"',1),(NULL,@h2,'rel="new"',0),(NULL,@h2,'window="new"',0),(NULL,@h2,'tab="1"',0);
UPDATE fs_preguntas SET fs_correcta_id=(SELECT id FROM fs_opciones WHERE fs_pregunta_id=@h2 AND fs_es_correcta=1) WHERE id=@h2;

INSERT INTO fs_preguntas (fs_texto,fs_categoria,fs_dificultad) VALUES ('¿Qué etiqueta representa contenido autónomo dentro del documento?', 'HTML','media');
SET @h3=LAST_INSERT_ID();
INSERT INTO fs_opciones VALUES (NULL,@h3,'<article>',1),(NULL,@h3,'<div>',0),(NULL,@h3,'<section>',0),(NULL,@h3,'<span>',0);
UPDATE fs_preguntas SET fs_correcta_id=(SELECT id FROM fs_opciones WHERE fs_pregunta_id=@h3 AND fs_es_correcta=1) WHERE id=@h3;

INSERT INTO fs_preguntas (fs_texto,fs_categoria,fs_dificultad) VALUES ('¿Qué atributo de <img> permite carga diferida de imágenes?', 'HTML','media');
SET @h4=LAST_INSERT_ID();
INSERT INTO fs_opciones VALUES (NULL,@h4,'loading="lazy"',1),(NULL,@h4,'defer',0),(NULL,@h4,'async',0),(NULL,@h4,'delay',0);
UPDATE fs_preguntas SET fs_correcta_id=(SELECT id FROM fs_opciones WHERE fs_pregunta_id=@h4 AND fs_es_correcta=1) WHERE id=@h4;

INSERT INTO fs_preguntas (fs_texto,fs_categoria,fs_dificultad) VALUES ('¿Qué elemento suele contener datos de contacto del autor o la organización?', 'HTML','dificil');
SET @h5=LAST_INSERT_ID();
INSERT INTO fs_opciones VALUES (NULL,@h5,'<address>',1),(NULL,@h5,'<author>',0),(NULL,@h5,'<meta name="author">',0),(NULL,@h5,'<cite>',0);
UPDATE fs_preguntas SET fs_correcta_id=(SELECT id FROM fs_opciones WHERE fs_pregunta_id=@h5 AND fs_es_correcta=1) WHERE id=@h5;

INSERT INTO fs_preguntas (fs_texto,fs_categoria,fs_dificultad) VALUES ('¿Qué etiqueta indica contenido relacionado pero no central?', 'HTML','dificil');
SET @h6=LAST_INSERT_ID();
INSERT INTO fs_opciones VALUES (NULL,@h6,'<aside>',1),(NULL,@h6,'<details>',0),(NULL,@h6,'<summary>',0),(NULL,@h6,'<figure>',0);
UPDATE fs_preguntas SET fs_correcta_id=(SELECT id FROM fs_opciones WHERE fs_pregunta_id=@h6 AND fs_es_correcta=1) WHERE id=@h6;

-- =============== CSS ===============
INSERT INTO fs_preguntas (fs_texto,fs_categoria,fs_dificultad) VALUES ('¿Qué propiedad define el tamaño de la tipografía?', 'CSS','facil');
SET @c1=LAST_INSERT_ID();
INSERT INTO fs_opciones VALUES (NULL,@c1,'font-size',1),(NULL,@c1,'text-size',0),(NULL,@c1,'size',0),(NULL,@c1,'type-size',0);
UPDATE fs_preguntas SET fs_correcta_id=(SELECT id FROM fs_opciones WHERE fs_pregunta_id=@c1 AND fs_es_correcta=1) WHERE id=@c1;

INSERT INTO fs_preguntas (fs_texto,fs_categoria,fs_dificultad) VALUES ('¿Qué propiedad agrega espacio interno dentro de un contenedor?', 'CSS','facil');
SET @c2=LAST_INSERT_ID();
INSERT INTO fs_opciones VALUES (NULL,@c2,'padding',1),(NULL,@c2,'margin',0),(NULL,@c2,'gap',0),(NULL,@c2,'space',0);
UPDATE fs_preguntas SET fs_correcta_id=(SELECT id FROM fs_opciones WHERE fs_pregunta_id=@c2 AND fs_es_correcta=1) WHERE id=@c2;

INSERT INTO fs_preguntas (fs_texto,fs_categoria,fs_dificultad) VALUES ('¿Qué valor convierte un elemento en contenedor de cuadrícula?', 'CSS','media');
SET @c3=LAST_INSERT_ID();
INSERT INTO fs_opciones VALUES (NULL,@c3,'display: grid',1),(NULL,@c3,'grid: true',0),(NULL,@c3,'position: grid',0),(NULL,@c3,'flex: grid',0);
UPDATE fs_preguntas SET fs_correcta_id=(SELECT id FROM fs_opciones WHERE fs_pregunta_id=@c3 AND fs_es_correcta=1) WHERE id=@c3;

INSERT INTO fs_preguntas (fs_texto,fs_categoria,fs_dificultad) VALUES ('¿Qué propiedad controla la separación vertical entre líneas?', 'CSS','media');
SET @c4=LAST_INSERT_ID();
INSERT INTO fs_opciones VALUES (NULL,@c4,'line-height',1),(NULL,@c4,'text-height',0),(NULL,@c4,'height-line',0),(NULL,@c4,'leading',0);
UPDATE fs_preguntas SET fs_correcta_id=(SELECT id FROM fs_opciones WHERE fs_pregunta_id=@c4 AND fs_es_correcta=1) WHERE id=@c4;

INSERT INTO fs_preguntas (fs_texto,fs_categoria,fs_dificultad) VALUES ('¿Qué shorthand establece márgenes en el orden TRBL?', 'CSS','dificil');
SET @c5=LAST_INSERT_ID();
INSERT INTO fs_opciones VALUES (NULL,@c5,'margin: t r b l',1),(NULL,@c5,'margin: l r t b',0),(NULL,@c5,'margins: trbl',0),(NULL,@c5,'margin-quad',0);
UPDATE fs_preguntas SET fs_correcta_id=(SELECT id FROM fs_opciones WHERE fs_pregunta_id=@c5 AND fs_es_correcta=1) WHERE id=@c5;

INSERT INTO fs_preguntas (fs_texto,fs_categoria,fs_dificultad) VALUES ('¿Qué propiedad determina el apilado de elementos posicionados?', 'CSS','dificil');
SET @c6=LAST_INSERT_ID();
INSERT INTO fs_opciones VALUES (NULL,@c6,'z-index',1),(NULL,@c6,'stack-index',0),(NULL,@c6,'order',0),(NULL,@c6,'layer',0);
UPDATE fs_preguntas SET fs_correcta_id=(SELECT id FROM fs_opciones WHERE fs_pregunta_id=@c6 AND fs_es_correcta=1) WHERE id=@c6;

-- =============== JS ===============
INSERT INTO fs_preguntas (fs_texto,fs_categoria,fs_dificultad) VALUES ('¿Qué método devuelve el primer elemento que coincide con un selector CSS?', 'JS','facil');
SET @j1=LAST_INSERT_ID();
INSERT INTO fs_opciones VALUES (NULL,@j1,'document.querySelector()',1),(NULL,@j1,'document.get()',0),(NULL,@j1,'document.find()',0),(NULL,@j1,'window.select()',0);
UPDATE fs_preguntas SET fs_correcta_id=(SELECT id FROM fs_opciones WHERE fs_pregunta_id=@j1 AND fs_es_correcta=1) WHERE id=@j1;

INSERT INTO fs_preguntas (fs_texto,fs_categoria,fs_dificultad) VALUES ('¿Qué operador verifica igualdad estricta de valor y tipo?', 'JS','facil');
SET @j2=LAST_INSERT_ID();
INSERT INTO fs_opciones VALUES (NULL,@j2,'===',1),(NULL,@j2,'==',0),(NULL,@j2,'=',0),(NULL,@j2,'!==',0);
UPDATE fs_preguntas SET fs_correcta_id=(SELECT id FROM fs_opciones WHERE fs_pregunta_id=@j2 AND fs_es_correcta=1) WHERE id=@j2;

INSERT INTO fs_preguntas (fs_texto,fs_categoria,fs_dificultad) VALUES ('¿Qué método genera un nuevo arreglo aplicando una función a cada ítem?', 'JS','media');
SET @j3=LAST_INSERT_ID();
INSERT INTO fs_opciones VALUES (NULL,@j3,'map()',1),(NULL,@j3,'forEach()',0),(NULL,@j3,'reduce()',0),(NULL,@j3,'filter()',0);
UPDATE fs_preguntas SET fs_correcta_id=(SELECT id FROM fs_opciones WHERE fs_pregunta_id=@j3 AND fs_es_correcta=1) WHERE id=@j3;

INSERT INTO fs_preguntas (fs_texto,fs_categoria,fs_dificultad) VALUES ('¿Qué mecanismo captura y maneja errores en código asíncrono?', 'JS','media');
SET @j4=LAST_INSERT_ID();
INSERT INTO fs_opciones VALUES (NULL,@j4,'try/catch',1),(NULL,@j4,'async',0),(NULL,@j4,'await',0),(NULL,@j4,'throw',0);
UPDATE fs_preguntas SET fs_correcta_id=(SELECT id FROM fs_opciones WHERE fs_pregunta_id=@j4 AND fs_es_correcta=1) WHERE id=@j4;

INSERT INTO fs_preguntas (fs_texto,fs_categoria,fs_dificultad) VALUES ('¿Qué técnica evita colisiones de nombres a nivel de módulo?', 'JS','dificil');
SET @j5=LAST_INSERT_ID();
INSERT INTO fs_opciones VALUES (NULL,@j5,'IIFE o ES Modules',1),(NULL,@j5,'var global',0),(NULL,@j5,'with()',0),(NULL,@j5,'eval()',0);
UPDATE fs_preguntas SET fs_correcta_id=(SELECT id FROM fs_opciones WHERE fs_pregunta_id=@j5 AND fs_es_correcta=1) WHERE id=@j5;

INSERT INTO fs_preguntas (fs_texto,fs_categoria,fs_dificultad) VALUES ('¿Qué llamada programa una función al final de la cola de tareas?', 'JS','dificil');
SET @j6=LAST_INSERT_ID();
INSERT INTO fs_opciones VALUES (NULL,@j6,'setTimeout(fn,0)',1),(NULL,@j6,'requestAnimationFrame',0),(NULL,@j6,'queueMicrotask',0),(NULL,@j6,'setImmediate',0);
UPDATE fs_preguntas SET fs_correcta_id=(SELECT id FROM fs_opciones WHERE fs_pregunta_id=@j6 AND fs_es_correcta=1) WHERE id=@j6;

-- =============== PHP ===============
INSERT INTO fs_preguntas (fs_texto,fs_categoria,fs_dificultad) VALUES ('¿Qué función imprime estructura legible de una variable?', 'PHP','facil');
SET @p1=LAST_INSERT_ID();
INSERT INTO fs_opciones VALUES (NULL,@p1,'print_r()',1),(NULL,@p1,'var()',0),(NULL,@p1,'echo_json()',0),(NULL,@p1,'printf_json()',0);
UPDATE fs_preguntas SET fs_correcta_id=(SELECT id FROM fs_opciones WHERE fs_pregunta_id=@p1 AND fs_es_correcta=1) WHERE id=@p1;

INSERT INTO fs_preguntas (fs_texto,fs_categoria,fs_dificultad) VALUES ('¿En qué superglobal se almacenan los datos de sesión?', 'PHP','facil');
SET @p2=LAST_INSERT_ID();
INSERT INTO fs_opciones VALUES (NULL,@p2,'$_SESSION',1),(NULL,@p2,'$_COOKIE',0),(NULL,@p2,'$_FILES',0),(NULL,@p2,'$_ENV',0);
UPDATE fs_preguntas SET fs_correcta_id=(SELECT id FROM fs_opciones WHERE fs_pregunta_id=@p2 AND fs_es_correcta=1) WHERE id=@p2;

INSERT INTO fs_preguntas (fs_texto,fs_categoria,fs_dificultad) VALUES ('¿Qué opción de PDO habilita excepciones en errores?', 'PHP','media');
SET @p3=LAST_INSERT_ID();
INSERT INTO fs_opciones VALUES (NULL,@p3,'PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION',1),(NULL,@p3,'PDO::ATTR_THROW',0),(NULL,@p3,'ERRMODE_EXCEPTION()',0),(NULL,@p3,'PDO::EXC',0);
UPDATE fs_preguntas SET fs_correcta_id=(SELECT id FROM fs_opciones WHERE fs_pregunta_id=@p3 AND fs_es_correcta=1) WHERE id=@p3;

INSERT INTO fs_preguntas (fs_texto,fs_categoria,fs_dificultad) VALUES ('¿Cómo validar un correo de forma segura desde POST?', 'PHP','media');
SET @p4=LAST_INSERT_ID();
INSERT INTO fs_opciones VALUES (NULL,@p4,'filter_input(INPUT_POST, "email", FILTER_VALIDATE_EMAIL)',1),(NULL,@p4,'htmlentities($_POST["email"])',0),(NULL,@p4,'strip_tags($_POST["email"])',0),(NULL,@p4,'json_encode($_POST["email"])',0);
UPDATE fs_preguntas SET fs_correcta_id=(SELECT id FROM fs_opciones WHERE fs_pregunta_id=@p4 AND fs_es_correcta=1) WHERE id=@p4;

INSERT INTO fs_preguntas (fs_texto,fs_categoria,fs_dificultad) VALUES ('¿Qué función genera un hash robusto para contraseñas?', 'PHP','dificil');
SET @p5=LAST_INSERT_ID();
INSERT INTO fs_opciones VALUES (NULL,@p5,'password_hash()',1),(NULL,@p5,'md5()',0),(NULL,@p5,'sha1()',0),(NULL,@p5,'crypt_simple()',0);
UPDATE fs_preguntas SET fs_correcta_id=(SELECT id FROM fs_opciones WHERE fs_pregunta_id=@p5 AND fs_es_correcta=1) WHERE id=@p5;

INSERT INTO fs_preguntas (fs_texto,fs_categoria,fs_dificultad) VALUES ('¿Cuál es el mecanismo recomendado para evitar inyección SQL?', 'PHP','dificil');
SET @p6=LAST_INSERT_ID();
INSERT INTO fs_opciones VALUES (NULL,@p6,'Consultas preparadas (prepare/bind/execute)',1),(NULL,@p6,'Concatenar strings',0),(NULL,@p6,'str_replace en comillas',0),(NULL,@p6,'addslashes()',0);
UPDATE fs_preguntas SET fs_correcta_id=(SELECT id FROM fs_opciones WHERE fs_pregunta_id=@p6 AND fs_es_correcta=1) WHERE id=@p6;
