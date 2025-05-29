<?php

require 'db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Método no permitido']);
    return;
}

function limpiarTexto($valor)
{
    return htmlspecialchars(trim($valor));
}

$codigo = limpiarTexto($_POST['codigo'] ?? '');
$nombre = limpiarTexto($_POST['nombre'] ?? '');
$precio = limpiarTexto($_POST['precio'] ?? '');
$bodega_id = limpiarTexto($_POST['bodega'] ?? '');
$sucursal_id = limpiarTexto($_POST['sucursal'] ?? '');
$moneda_id = limpiarTexto($_POST['moneda'] ?? '');
$descripcion = limpiarTexto($_POST['descripcion'] ?? '');
$materiales = $_POST['materiales'] ?? [];

if (empty($codigo) || empty($nombre) || empty($precio) || empty($bodega_id) || empty($sucursal_id) || empty($moneda_id)) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Todos los campos son obligatorios']);
    return;
}

if (!is_array($materiales) || count($materiales) < 2) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Debe seleccionar al menos dos materiales']);
    return;
}

$stmt = $pdo->prepare("SELECT COUNT(*) FROM productos WHERE codigo = :codigo");
$stmt->bindParam(':codigo', $codigo);
$stmt->execute();
$productoExistente = $stmt->fetchColumn();
if ($productoExistente > 0) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'El código del producto ya existe']);
    return;
}

try {

    $pdo->beginTransaction();

    $stmt = $pdo->prepare("INSERT INTO productos (codigo, nombre, bodega_id, sucursal_id, moneda_id, precio, descripcion) VALUES (:codigo, :nombre, :bodega_id, :sucursal_id, :moneda_id, :precio , :descripcion)");

    $stmt->execute([
        ':codigo' => $codigo,
        ':nombre' => $nombre,
        ':bodega_id' => $bodega_id,
        ':sucursal_id' => $sucursal_id,
        ':moneda_id' => $moneda_id,
        ':precio' => $precio,
        ':descripcion' => $descripcion
    ]);

    $producto_id = $pdo->lastInsertId();


    $stmt = $pdo->prepare("INSERT INTO producto_material (producto_id, material_id) VALUES (:producto_id, :material_id)");

    foreach ($materiales as $material_id) {
        $material_id = limpiarTexto($material_id);

        if (is_numeric($material_id) && $material_id > 0) {
            $stmt->execute([
                ':producto_id' => $producto_id,
                ':material_id' => $material_id
            ]);
        }
    }

    $pdo->commit();
    echo json_encode(['success' => true]);
    
} catch (PDOException $e) {
    $pdo->rollBack();
    echo json_encode(['success' => false, 'message' => 'Error al guardar el producto: ' . $e->getMessage()]);
}
