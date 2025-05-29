# Sistema de Registro de Productos

Este proyecto es una aplicación web simple para registrar productos, utilizando tecnologías web nativas.

## Tecnologías

- **PHP:** 8.4
- **PostgreSQL:** 17
- **HTML + CSS** (sin frameworks)
- **JavaScript nativo** + `fetch` para AJAX
- **PDO** para consultas seguras a la base de datos

## Estructura
```
/
├── sql/
│ └── init_db.sql
├── api_datos.php
├── db.php
├── funciones.js
├── guardar_producto.php
├── index.php
├── LEEME.txt
├── styles.css
├── README.md
```
## Instalación

1. Clonar este repositorio en tu servidor local.
2. Crear una base de datos PostgreSQL y ejecutar `sql/init_db.sql`.
3. Configurar la conexión a la base de datos en `db.php`.
4. Abrir `index.php` en el navegador local (ej: `http://localhost/DesisTest/index.php`).

## Validaciones

- Todas las validaciones son en **JavaScript nativo**.
- El formulario no se enviará si hay errores.
- Validación de unicidad de código usando `fetch` a `api_datos.php`.
