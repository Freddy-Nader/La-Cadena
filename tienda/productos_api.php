<?php
header('Content-Type: application/json; charset=utf-8');

$host = 'localhost';
$db   = 'la_cadena';
$user = 'root';
$pass = '';
$charset = 'utf8mb4';

$dsn = "mysql:host=$host;dbname=$db;charset=$charset";
$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES   => false,
];

try {
    $pdo = new PDO($dsn, $user, $pass, $options);
} catch (PDOException $e) {
    echo json_encode([]);
    exit;
}

$stmt = $pdo->query("SELECT nombre, precio, num_serie, imagen FROM productos ORDER BY id DESC");
$productos = $stmt->fetchAll();
echo json_encode($productos); 