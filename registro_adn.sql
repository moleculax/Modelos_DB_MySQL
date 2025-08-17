-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS registro_adn;
USE registro_adn;

-- Tabla: personas
CREATE TABLE personas (
    id_persona INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    documento_identidad VARCHAR(50) UNIQUE NOT NULL,
    fecha_nacimiento DATE,
    sexo ENUM('Masculino', 'Femenino', 'Otro'),
    origen_geografico VARCHAR(100),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla: muestras_adn
CREATE TABLE muestras_adn (
    id_muestra INT AUTO_INCREMENT PRIMARY KEY,
    id_persona INT NOT NULL,
    secuencia TEXT NOT NULL,
    calidad FLOAT CHECK (calidad >= 0 AND calidad <= 1),
    fecha_extraccion DATE,
    metodo_extraccion VARCHAR(100),
    observaciones TEXT,
    FOREIGN KEY (id_persona) REFERENCES personas(id_persona)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Tabla: anotaciones_geneticas
CREATE TABLE anotaciones_geneticas (
    id_anotacion INT AUTO_INCREMENT PRIMARY KEY,
    id_muestra INT NOT NULL,
    gen VARCHAR(50),
    tipo_mutacion VARCHAR(100),
    efecto_funcional TEXT,
    relevancia_clinica VARCHAR(100),
    FOREIGN KEY (id_muestra) REFERENCES muestras_adn(id_muestra)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Tabla: eventos_evolutivos (simbólica para NeuroCode)
CREATE TABLE eventos_evolutivos (
    id_evento INT AUTO_INCREMENT PRIMARY KEY,
    id_persona INT NOT NULL,
    evento VARCHAR(100),
    descripcion TEXT,
    fecha_evento DATE,
    impacto_simbolico TEXT,
    FOREIGN KEY (id_persona) REFERENCES personas(id_persona)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Inserción de ejemplo
INSERT INTO personas (nombre, apellido, documento_identidad, fecha_nacimiento, sexo, origen_geografico)
VALUES ('Emilio', 'Moleculax', 'DNI12345678', '1990-05-12', 'Masculino', 'Buenos Aires, Argentina');

INSERT INTO muestras_adn (id_persona, secuencia, calidad, fecha_extraccion, metodo_extraccion, observaciones)
VALUES (1, 'ATGCGTACCTGAGCTTAGGCTAAGCTT...', 0.98, '2025-08-16', 'Saliva', 'Secuencia completa, sin mutaciones detectadas');

INSERT INTO anotaciones_geneticas (id_muestra, gen, tipo_mutacion, efecto_funcional, relevancia_clinica)
VALUES (1, 'TP53', 'Sustitución', 'Alteración en la supresión tumoral', 'Alta');

INSERT INTO eventos_evolutivos (id_persona, evento, descripcion, fecha_evento, impacto_simbolico)
VALUES (1, 'Diseño de NeuroCode', 'Inicio de plataforma evolutiva', '2025-07-01', 'Amplificación de creatividad y propósito');



