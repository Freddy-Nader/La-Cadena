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

$num_serie = $_GET['num_serie'] ?? '';
if (!$num_serie) {
    echo json_encode([]);
    exit;
}

try {
    $pdo = new PDO($dsn, $user, $pass, $options);
    $stmt = $pdo->prepare("SELECT nombre, precio, descripcion, imagen FROM productos WHERE num_serie = ? LIMIT 1");
    $stmt->execute([$num_serie]);
    $producto = $stmt->fetch();
    echo json_encode($producto ?: []);
} catch (PDOException $e) {
    echo json_encode([]);
} 