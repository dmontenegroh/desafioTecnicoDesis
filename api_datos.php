<?php

require 'db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Método no permitido']);
    return;
}

$accion = $_GET['accion'] ?? '';

switch ($accion) {
    case 'bodegas':
        obtenerBodegas($pdo);
        break;
    case 'monedas':
        obtenerMonedas($pdo);
        break;
    case 'sucursales':
        $bodegaId = $_GET['bodegaId'] ?? null;
        if ($bodegaId) {
            obtenerSucursales($pdo, $bodegaId);
        } else {
            echo json_encode([]);
        }
        break;

    case 'verificar_codigo':
        $codigo = $_GET['codigo'] ?? '';
        verificarCodigo($pdo, $codigo);
        break;

    default:
        echo json_encode(['error' => 'Acción no válida']);
        break;
}

function obtenerBodegas($pdo)
{
    $stmt = $pdo->prepare("SELECT id, nombre FROM bodegas ORDER BY nombre");
    $stmt->execute();
    $bodegas = $stmt->fetchAll();
    echo json_encode($bodegas);
}

function obtenerMonedas($pdo)
{
    $stmt = $pdo->prepare("SELECT id, nombre FROM monedas ORDER BY nombre");
    $stmt->execute();
    $monedas = $stmt->fetchAll();
    echo json_encode($monedas);
}

function obtenerSucursales($pdo, $bodegaId)
{
    $stmt = $pdo->prepare("SELECT id, nombre FROM sucursales WHERE bodega_id = :bodegaId ORDER BY nombre");
    $stmt->bindParam(':bodegaId', $bodegaId);
    $stmt->execute();
    $sucursales = $stmt->fetchAll();
    echo json_encode($sucursales);
}

function verificarCodigo($pdo, $codigo){
    $stmt = $pdo->prepare("SELECT COUNT(*) FROM productos WHERE codigo = :codigo");
    $stmt->bindParam(':codigo', $codigo);
    $stmt->execute();
    $existe = $stmt->fetchColumn() > 0;

    echo json_encode(['existe' => $existe]);
}
