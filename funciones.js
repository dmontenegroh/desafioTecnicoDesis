document.addEventListener("DOMContentLoaded", function () {
    cargarBodegas();
    cargarMonedas();

    document.getElementById('bodega').addEventListener('change', cargarSucursales);

});

document.getElementById('btnGuardar').addEventListener('click', async (e) => {

    e.preventDefault();

    const codigo = document.getElementById('codigo').value.trim();
    const codigoExistente = await verificarCodigoExistente(codigo);

    if (codigoExistente) {
        alert('El código del producto ya está registrado.')
        return;
    }

    if (!validarFormulario()) return;

    const form = document.getElementById('formProducto');
    const formData = new FormData(form);

    try {
        const response = await fetch('guardar_producto.php', {
            method: 'POST',
            body: formData
        });

        const result = await response.json();

        if (result.success) {
            alert('Producto guardado exitosamente');
            form.reset();

            document.getElementById('sucursal').innerHTML = '<option value=""></option>';

        } else {
            alert('Error: ' + result.message);
        }


    } catch (error) {
        console.error('Error al guardar el producto:', error);
        alert('Error al guardar el producto');
    }

});

async function cargarBodegas() {
    try {
        const response = await fetch('api_datos.php?accion=bodegas');
        if (!response.ok) throw new Error('Error al cargar las bodegas');
        const bodegas = await response.json();

        const select = document.getElementById('bodega');

        bodegas.forEach(item => {
            let option = document.createElement('option');
            option.value = item.id;
            option.text = item.nombre;
            select.appendChild(option);
        });
    } catch (error) {
        console.error('Error al cargar las bodegas:', error);
        alert('Error al cargar las bodegas');
    }
}

async function cargarSucursales() {
    const bodegaId = document.getElementById('bodega').value
    const select = document.getElementById('sucursal');


    while (select.firstChild) {
        select.removeChild(select.firstChild);
    }

    const blankOption = document.createElement('option');
    blankOption.value = "";
    blankOption.text = "";
    select.appendChild(blankOption);


    if (bodegaId === "") return;

    try {
        const response = await fetch(`api_datos.php?accion=sucursales&bodegaId=${bodegaId}`);
        if (!response.ok) throw new Error('Error al cargar las sucursales');
        const sucursales = await response.json();
        sucursales.forEach(item => {
            let option = document.createElement('option');
            option.value = item.id;
            option.text = item.nombre;
            select.appendChild(option);
        });

        if (sucursales.length > 0) {
            select.value = sucursales[0].id;
        }

    } catch (error) {
        console.error('Error al cargar las sucursales:', error);
        alert('Error al cargar las sucursales');
    }
}

async function cargarMonedas() {
    try {

        const response = await fetch('api_datos.php?accion=monedas');
        if (!response.ok) throw new Error('Error al cargar las monedas');
        const monedas = await response.json();
        const select = document.getElementById('moneda');

        monedas.forEach(item => {
            let option = document.createElement('option');
            option.value = item.id;
            option.text = item.nombre;
            select.appendChild(option);
        });

    } catch (error) {
        console.error('Error al cargar las monedas:', error);
        alert('Error al cargar las monedas');

    }
}

async function verificarCodigoExistente(codigo) {

    try {

        const response = await fetch(`api_datos.php?accion=verificar_codigo&codigo=${codigo}`)
        const data = await response.json();

        return data.existe === true;


    } catch (error) {
        console.error('Error verificando código:', error);
        return false;
    }

}

function validarFormulario() {
    const codigo = document.getElementById('codigo').value.trim();
    const nombre = document.getElementById('nombre').value.trim();
    const precio = document.getElementById('precio').value.trim();
    const bodega = document.getElementById('bodega').value;
    const sucursal = document.getElementById('sucursal').value;
    const moneda = document.getElementById('moneda').value;
    const descripcion = document.getElementById('descripcion').value.trim();
    const materiales = document.querySelectorAll('input[name="materiales[]"]:checked');

    const regexCodigo = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z0-9]+$/;
    const regexPrecio = /^\d+(\.\d{1,2})?$/;

    if (codigo === '') {
        alert('El código del producto no puede estar en blanco');
        return false;
    }

    if (!regexCodigo.test(codigo)) {
        alert('El código del producto debe contener letras y números');
        return false;
    }

    if (codigo.length < 5 || codigo.length > 15) {
        alert('El código del producto debe tener entre 5 y 15 caracteres');
        return false;
    }

    if (nombre === '') {
        alert('El nombre de producto no puede estar en blanco');
    }

    if (nombre.length < 2 || nombre.length > 50) {
        alert('El nombre del producto debe tener entre 2 y 50 caracteres');
        return false;
    }

    if (precio === '') {
        alert('El precio del producto no puede estar en blanco');
        return false;
    }

    if (!regexPrecio.test(precio)) {
        alert('El precio del producto debe ser un número positivo con hasta dos decimales');
        return false;
    }

    if (materiales.length < 2) {
        alert('Debe seleccionar al menos dos materiales');
        return false;
    }

    if (!bodega) {
        alert('Debe seleccionar una bodega');
        return false;
    }

    if (!sucursal) {
        alert('Debe seleccionar una sucursal');
        return false;
    }

    if (!moneda) {
        alert('Debe seleccionar una moneda para el producto');
        return false;
    }

    if (descripcion === '') {
        alert('La descripción del producto no puede estar en blanco');
        return false;
    }

    if (descripcion.length < 10 || descripcion.length > 200) {
        alert('La descripción del producto debe tener entre 10 y 200 caracteres');
        return false;
    }

    return true;



}
