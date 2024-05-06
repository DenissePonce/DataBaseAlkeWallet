-- Crear la base de datos 
CREATE DATABASE IF NOT EXISTS alke_wallet;

-- Usar la base de datos 
USE alke_wallet;

-- Crear tabla Usuario
CREATE TABLE user (
    user_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50),
    password VARCHAR(50),
    saldo DECIMAL(10,2)
);

-- Crear tabla Moneda
CREATE TABLE currency (
    currency_id INT PRIMARY KEY,
    currency_name VARCHAR(50),
    currency_symbol VARCHAR(10)
);

-- Crear tabla Transacción
CREATE TABLE Transaction (
    transaction_id INT PRIMARY KEY,
    sender_user_id INT,
    receiver_user_id INT,
    importe DECIMAL(10,2),
    transaction_date DATE,
    id_Moneda INT,
    FOREIGN KEY (sender_user_id) REFERENCES User(user_id),
    FOREIGN KEY (receiver_user_id) REFERENCES Usero(user_id),
    FOREIGN KEY (id_currency) REFERENCES currency(currency_id)
);

 /*insertar datos a tabla usuario*/
insert into user (user_id, name , email , password, saldo) 
values
(1, "Juanito Perez", "jperez@gmail.com","12345678", 100000), 
(2, "Carolina Tapia", "ctapia@gmail.com","12345678", 350000), 
(3, "Camila Lara", "c.lara@gmail.com","12345678", 1200000), 
(4, "Antonio Parra", "a.parra@gmail.com","12345678", 800000), 
(5, "Clarisa Vergara", "c.vergara@gmail.com","12345678", 550000);

/*insertar datos en la tabla transacción*/
insert into transaction (transaction_id, sender_user_id, receiver_user_id, importe, transaction_date)
values
("1","3", "5", "5.000", "1", "2024-10-01"),
("2","4", "1", "30.000", "3", "2024-24-02"),
("3","2", "3", "15.000", "2", "2024-11-03"),
("4","1", "4", "101.000", "2", "2024-21-01"),
("5","3", "2", "45.000", "2", "2024-20-02")
;

/*insertar moneda */
insert into currency (currency_id, currency_name, currency_symbol) 
values
("1", "peso", "CLP$"),
("2", "dolar", "US$"),
("3", "euro", "€")
;

/*Consulta para obtener el nombre de la moneda elegida por un
usuario específico*/
SELECT u.name AS nombre_usuario, c.currency_name AS nombre_moneda
FROM user u
JOIN Transaction t ON u.user_id = t.sender_user_id OR u.user_id = t.receiver_user_id
JOIN currency m ON t.id_currency = m.currency_id
WHERE u.user_id = 5;

/*Consulta para obtener todas las transacciones registradas*/
SELECT*
FROM transaction;

/*Consulta para obtener todas las transacciones realizadas por un
usuario específico*/
SELECT * 
FROM transaction
WHERE sender_user_id = 3 ;

/*Sentencia DML para modificar el campo correo electrónico de un
usuario específico*/
UPDATE user
SET password = 'nuevapassword'
WHERE user_id = 1; 

/*Sentencia para eliminar los datos de una transacción (eliminado de
la fila completa)*/
DELETE FROM Transaction
WHERE transaction_id = 3;