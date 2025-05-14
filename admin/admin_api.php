<?php
header('Content-Type: application/json; charset=utf-8');

// Configuración de la base de datos
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
    echo json_encode(['error' => 'Error de conexión a la base de datos']);
    exit;
}

$tables = [
    'productos' => 'id',
    'usuarios' => 'id',
    'carrito' => 'id_carrito',
    'historial' => 'id_compra',
];

action_router($pdo, $tables);

function action_router($pdo, $tables) {
    $action = $_REQUEST['action'] ?? 'list';
    $table = $_REQUEST['table'] ?? '';
    if ($action !== 'sql' && !isset($tables[$table])) {
        echo json_encode(['error' => 'Tabla no permitida']);
        exit;
    }
    switch ($action) {
        case 'list':
            list_table($pdo, $table, $tables[$table]);
            break;
        case 'insert':
            insert_row($pdo, $table);
            break;
        case 'delete':
            delete_row($pdo, $table, $tables[$table]);
            break;
        case 'get':
            get_row($pdo, $table, $tables[$table]);
            break;
        case 'update':
            update_row($pdo, $table, $tables[$table]);
            break;
        case 'sql':
            run_sql($pdo);
            break;
        default:
            echo json_encode(['error' => 'Acción no válida']);
    }
}

function list_table($pdo, $table, $pk) {
    $stmt = $pdo->query("SELECT * FROM $table LIMIT 100");
    $rows = $stmt->fetchAll();
    $columns = array();
    if (count($rows)) {
        $columns = array_keys($rows[0]);
    } else {
        // Obtener columnas aunque no haya datos
        $stmt2 = $pdo->query("DESCRIBE $table");
        foreach ($stmt2 as $col) $columns[] = $col['Field'];
    }
    echo json_encode([
        'columns' => $columns,
        'rows' => $rows,
        'pk' => $pk
    ]);
}

function insert_row($pdo, $table) {
    $fields = array();
    $values = array();
    foreach ($_POST as $k => $v) {
        if (in_array($k, ['action', 'table'])) continue;
        $fields[] = $k;
        $values[] = $v;
    }
    $placeholders = implode(',', array_fill(0, count($fields), '?'));
    $sql = "INSERT INTO $table (".implode(',', $fields).") VALUES ($placeholders)";
    $stmt = $pdo->prepare($sql);
    try {
        $stmt->execute($values);
        echo json_encode(['success' => true]);
    } catch (PDOException $e) {
        echo json_encode(['error' => 'Error al insertar: ' . $e->getMessage()]);
    }
}

function delete_row($pdo, $table, $pk) {
    $id = $_POST['id'] ?? null;
    if (!$id) {
        echo json_encode(['error' => 'ID requerido']);
        return;
    }
    $stmt = $pdo->prepare("DELETE FROM $table WHERE $pk = ?");
    try {
        $stmt->execute([$id]);
        echo json_encode(['success' => true]);
    } catch (PDOException $e) {
        echo json_encode(['error' => 'Error al eliminar: ' . $e->getMessage()]);
    }
}

function get_row($pdo, $table, $pk) {
    $id = $_GET['id'] ?? null;
    if (!$id) {
        echo json_encode(['error' => 'ID requerido']);
        return;
    }
    $stmt = $pdo->prepare("SELECT * FROM $table WHERE $pk = ?");
    $stmt->execute([$id]);
    $row = $stmt->fetch();
    if (!$row) {
        echo json_encode(['error' => 'Registro no encontrado']);
        return;
    }
    $columns = array_keys($row);
    echo json_encode(['row' => $row, 'columns' => $columns]);
}

function update_row($pdo, $table, $pk) {
    $id = $_POST['id'] ?? null;
    if (!$id) {
        echo json_encode(['error' => 'ID requerido']);
        return;
    }
    $fields = array();
    $values = array();
    foreach ($_POST as $k => $v) {
        if (in_array($k, ['action', 'table', 'id'])) continue;
        $fields[] = "$k = ?";
        $values[] = $v;
    }
    $values[] = $id;
    $sql = "UPDATE $table SET ".implode(',', $fields)." WHERE $pk = ?";
    $stmt = $pdo->prepare($sql);
    try {
        $stmt->execute($values);
        echo json_encode(['success' => true]);
    } catch (PDOException $e) {
        echo json_encode(['error' => 'Error al actualizar: ' . $e->getMessage()]);
    }
}

function run_sql($pdo) {
    $sql = $_POST['sql'] ?? '';
    if (!$sql) {
        echo json_encode(['error' => 'Consulta vacía']);
        return;
    }
    // Seguridad básica: solo permitir SELECT, INSERT, UPDATE, DELETE
    if (!preg_match('/^(SELECT|INSERT|UPDATE|DELETE) /i', trim($sql))) {
        echo json_encode(['error' => 'Solo se permiten consultas SELECT, INSERT, UPDATE o DELETE.']);
        return;
    }
    try {
        $stmt = $pdo->query($sql);
        if (stripos($sql, 'SELECT') === 0) {
            $rows = $stmt->fetchAll();
            $columns = count($rows) ? array_keys($rows[0]) : [];
            echo json_encode(['result' => true, 'rows' => $rows, 'columns' => $columns]);
        } else {
            echo json_encode(['result' => true]);
        }
    } catch (PDOException $e) {
        echo json_encode(['error' => 'Error en la consulta: ' . $e->getMessage()]);
    }
} 