<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de Produtos</title>
    <link rel="stylesheet" href="styles.css">
</head>

<body>
    <div class="form-wrapper">
        <h1 class="form-title">Formulario de Productos</h1>

        <form id="formProducto" class="formProducto">
            <div class="form-group">
                <label for="codigo">Codigo</label>
                <input type="text" id="codigo" name="codigo" class="form-input">
            </div>

            <div class="form-group">
                <label for="nombre">Nombre</label>
                <input type="text" id="nombre" name="nombre" class="form-input">
            </div>

            <div class="form-group">

                <label for="bodega">Bodega</label>
                <select id="bodega" name="bodega" class="form-select">
                    <option value="">-- Seleccione una Bodega --</option>
                </select>
            </div>

            <div class="form-group">
                <label for="sucursal">Sucursal</label>
                <select id="sucursal" name="sucursal" class="form-select">
                    <option value="">-- Seleccione una Sucursal --</option>
                </select>
            </div>


            <div class="form-group">
                <label for="moneda">Moneda</label>
                <select id="moneda" name="moneda" class="form-select">
                    <option value="">-- Seleccione una Moneda --</option>
                </select>
            </div>


            <div class="form-group">
                <label for="precio">Precio</label>
                <input type="number" id="precio" name="precio" class="form-input">
            </div>

            <div class="form-group full-width">
                <label>Materiales:</label>
                <div class="checkbox-group">
                    <label><input type="checkbox" name="materiales[]" value="1"> Plástico</label>
                    <label><input type="checkbox" name="materiales[]" value="2"> Metal</label>
                    <label><input type="checkbox" name="materiales[]" value="3"> Madera</label>
                    <label><input type="checkbox" name="materiales[]" value="4"> Vidrio</label>
                    <label><input type="checkbox" name="materiales[]" value="5"> Textil</label>
                </div>
            </div>

            <div class="form-group full-width">
                <label>Descripción</label>
                <textarea id="descripcion" name="descripcion" class="form-textarea"></textarea>
            </div>

            <button type="submit" id="btnGuardar" class="form-button">Guardar Producto</button>

        </form>
    </div>

    <script src="funciones.js"></script>

</body>

</html>