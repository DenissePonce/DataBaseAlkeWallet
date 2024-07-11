---Creamos la base de datos de alkewallet--
CREATE DATABASE AlkeWallet;

--usamos la base de datos
USE AlkeWallet;

--creamos la tabla usuario
CREATE TABLE Usuario (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL UNIQUE,
    contraseña VARCHAR(100) NOT NULL,
    saldo DECIMAL(10, 2) NOT NULL DEFAULT 0.00
);
--creamos la tabla moneda
CREATE TABLE Moneda (
    currency_id INT AUTO_INCREMENT PRIMARY KEY,
    currency_name VARCHAR(50) NOT NULL,
    currency_symbol VARCHAR(10) NOT NULL
);
--Creamos la tabla transacción
CREATE TABLE Transaccion (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    sender_user_id INT NOT NULL,
    receiver_user_id INT NOT NULL,
    importe DECIMAL(10, 2) NOT NULL,
    transaction_date DATETIME NOT NULL,
    currency_id INT NOT NULL,
    FOREIGN KEY (sender_user_id) REFERENCES Usuario(user_id),
    FOREIGN KEY (receiver_user_id) REFERENCES Usuario(user_id),
    FOREIGN KEY (currency_id) REFERENCES Moneda(currency_id)
);
--INSERTAMOS DATOS:
--Tabla usuario
INSERT INTO Usuario (nombre, correo_electronico, contraseña, saldo) VALUES
('Juan Pérez', 'juan.perez@gmail.com', 'password123', 100.00),
('María García', 'maria.garcia@gmail.com', 'securepass', 250.50),
('Carlos López', 'carlos.lopez@gmail.com', 'mypassword', 500.75);

--tabla moneda
INSERT INTO Moneda (currency_name, currency_symbol) VALUES
('Dólar Estadounidense', 'USD'),
('Euro', 'EUR'),
('Peso Chileno', 'CLP');

--Tabla transaccion
INSERT INTO Transaccion (sender_user_id, receiver_user_id, importe, transaction_date, currency_id) VALUES
(1, 2, 50.00, '2024-07-11 10:30:00', 1),  -- Juan Pérez envía a María García 50 USD
(2, 3, 75.25, '2024-07-11 11:00:00', 2),  -- María García envía a Carlos López 75.25 EUR
(3, 1, 100.000, '2024-07-11 12:15:00', 3);  -- Carlos López envía a Juan Pérez 100.000 CLP


--CONSULTAS PARA OBTENER:
--moneda elegida
SELECT Moneda.currency_name 
FROM Transaccion
JOIN Moneda ON Transaccion.currency_id = Moneda.currency_id
WHERE Transaccion.sender_user_id = [usuario_id] OR Transaccion.receiver_user_id = [usuario_id];

--transacciones registradas
SELECT * FROM Transaccion;

--transacciones realizadas por usuario en especifico
SELECT * 
FROM Transaccion 
WHERE sender_user_id = [usuario_id] OR receiver_user_id = [usuario_id];

--modificar el campo correo electrónico de un usuario específico
UPDATE Usuario 
SET correo_electronico = '[nuevo_correo_electronico]' 
WHERE user_id = [usuario_id];

--Eliminar datos de una transaccion
DELETE FROM Transaccion 
WHERE transaction_id = [transaction_id];
