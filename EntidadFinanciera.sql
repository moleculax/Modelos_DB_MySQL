-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS EntidadFinanciera;
USE EntidadFinanciera;

-- Tabla: Clientes
CREATE TABLE Clientes (
    ClienteID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    DNI VARCHAR(20) UNIQUE NOT NULL,
    FechaNacimiento DATE,
    Direccion VARCHAR(200),
    Email VARCHAR(100),
    Telefono VARCHAR(20),
    FechaRegistro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla: Cuentas
CREATE TABLE Cuentas (
    CuentaID INT AUTO_INCREMENT PRIMARY KEY,
    ClienteID INT NOT NULL,
    TipoCuenta ENUM('Ahorro', 'Corriente', 'Inversión') NOT NULL,
    Saldo DECIMAL(15,2) DEFAULT 0.00,
    FechaApertura DATE,
    Estado ENUM('Activa', 'Inactiva', 'Cerrada') DEFAULT 'Activa',
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

-- Tabla: Transacciones
CREATE TABLE Transacciones (
    TransaccionID INT AUTO_INCREMENT PRIMARY KEY,
    CuentaID INT NOT NULL,
    Fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Tipo ENUM('Débito', 'Crédito', 'Transferencia') NOT NULL,
    Monto DECIMAL(15,2) NOT NULL,
    Descripcion TEXT,
    FOREIGN KEY (CuentaID) REFERENCES Cuentas(CuentaID)
);

-- Tabla: Préstamos
CREATE TABLE Prestamos (
    PrestamoID INT AUTO_INCREMENT PRIMARY KEY,
    ClienteID INT NOT NULL,
    Monto DECIMAL(15,2) NOT NULL,
    TasaInteres DECIMAL(5,2) NOT NULL,
    FechaInicio DATE,
    FechaFin DATE,
    Estado ENUM('Activo', 'Cancelado', 'Moroso') DEFAULT 'Activo',
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

-- Tabla: Pagos de Préstamos
CREATE TABLE PagosPrestamo (
    PagoID INT AUTO_INCREMENT PRIMARY KEY,
    PrestamoID INT NOT NULL,
    FechaPago DATE NOT NULL,
    MontoPagado DECIMAL(15,2) NOT NULL,
    FOREIGN KEY (PrestamoID) REFERENCES Prestamos(PrestamoID)
);

-- Tabla: Tarjetas
CREATE TABLE Tarjetas (
    TarjetaID INT AUTO_INCREMENT PRIMARY KEY,
    ClienteID INT NOT NULL,
    TipoTarjeta ENUM('Débito', 'Crédito') NOT NULL,
    NumeroTarjeta VARCHAR(20) UNIQUE NOT NULL,
    FechaVencimiento DATE NOT NULL,
    LimiteCredito DECIMAL(15,2),
    Estado ENUM('Activa', 'Bloqueada', 'Vencida') DEFAULT 'Activa',
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

-- Tabla: Productos Financieros
CREATE TABLE ProductosFinancieros (
    ProductoID INT AUTO_INCREMENT PRIMARY KEY,
    NombreProducto VARCHAR(100),
    TipoProducto ENUM('Fondo', 'Acción', 'Bonos', 'Plazo Fijo'),
    Riesgo ENUM('Bajo', 'Medio', 'Alto'),
    RentabilidadEsperada DECIMAL(5,2)
);

-- Tabla: Inversiones del Cliente
CREATE TABLE InversionesCliente (
    InversionID INT AUTO_INCREMENT PRIMARY KEY,
    ClienteID INT,
    ProductoID INT,
    MontoInvertido DECIMAL(15,2),
    FechaInversion DATE,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID),
    FOREIGN KEY (ProductoID) REFERENCES ProductosFinancieros(ProductoID)
);

-- Tabla: Documentos KYC
CREATE TABLE DocumentosCliente (
    DocumentoID INT AUTO_INCREMENT PRIMARY KEY,
    ClienteID INT,
    TipoDocumento ENUM('DNI', 'Pasaporte', 'Comprobante de domicilio'),
    NumeroDocumento VARCHAR(50),
    FechaCarga DATE,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

-- Tabla: Alertas de Riesgo
CREATE TABLE AlertasRiesgo (
    AlertaID INT AUTO_INCREMENT PRIMARY KEY,
    ClienteID INT,
    FechaAlerta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    TipoAlerta ENUM('Transacción sospechosa', 'Mora', 'Actividad inusual'),
    Descripcion TEXT,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

-- Tabla: Usuarios del Sistema
CREATE TABLE UsuariosSistema (
    UsuarioID INT AUTO_INCREMENT PRIMARY KEY,
    NombreUsuario VARCHAR(50) UNIQUE,
    ContraseñaHash VARCHAR(255),
    Rol ENUM('Cajero', 'Gerente', 'Auditor', 'Admin'),
    FechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla: Tickets de Soporte
CREATE TABLE TicketsSoporte (
    TicketID INT AUTO_INCREMENT PRIMARY KEY,
    ClienteID INT,
    FechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Asunto VARCHAR(100),
    Estado ENUM('Abierto', 'En Proceso', 'Cerrado'),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

-- Tabla: Historial de Contacto
CREATE TABLE HistorialContacto (
    ContactoID INT AUTO_INCREMENT PRIMARY KEY,
    ClienteID INT,
    FechaContacto TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    MedioContacto ENUM('Teléfono', 'Email', 'Presencial'),
    Comentario TEXT,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);