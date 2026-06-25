# BD2-TPI-G19 — Sistema de reservas de cine

Trabajo Práctico Integrador · **Base de Datos II** · UTN TUP · **Grupo 19**

Base de datos relacional **`BD2_TPI_G19`** sobre **Microsoft SQL Server** para un sistema de gestión de complejos cinematográficos, cartelera, funciones, usuarios, reservas por butaca y pagos.

---

## Integrantes y módulos (DDL)

Los bloques están comentados en [`sql/desarrollo_db/creacion_bd.sql`](sql/desarrollo_db/creacion_bd.sql).

| Integrante | Tablas |
|------------|--------|
| **Carlos Gastón Carabajal** | `CLASIFICACIONES`, `GENEROS`, `PELICULAS` |
| **Gisela Grisel Lanzillotta** | `COMPLEJOS`, `SALAS`, `FUNCIONES` |
| **Henry José Vázquez Velásquez** | `USUARIOS`, `BUTACAS`, `DETALLES_RESERVAS` |
| **Marcelo Carabajal** | `METODOS_PAGOS`, `RESERVAS`, `PAGOS` |

---

## Herramientas (acordadas en equipo)

| Uso | Herramienta |
|-----|----------------|
| Modelado | SQL Server Management Studio (SSMS) - Draw.io |
| Control de versiones | GitHub |
| Seguimiento de tareas | Jira |
| Motor SQL en local | Docker (SQL Server) - SQL Server Express |
| Ejecución y depuración de scripts | SQL Server Management Studio (SSMS) |

---

## Entorno de desarrollo (Docker)

Ejemplo equivalente al de la materia (`teoria/bd_relacionales`):

```bash
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=BaseDatos#2" -e "MSSQL_PID=Express" \
  -e "TZ=America/Buenos_Aires" -p 1433:1433 --name SQLServer2025 \
  --hostname SQLServer2025 -d mcr.microsoft.com/mssql/server:2025-latest
```

- Servidor: `localhost`, puerto **1433**
- Usuario: **`sa`**
- Contraseña: **`BaseDatos#2`** (solo desarrollo local)

---

## Estructura del repositorio

```
BD2-TPI-G19/
├── appPeliculas/
│   └── BD2-TPI-G19/
│       ├── BD2-TPI-G19.sln              # solución WinForms (.NET Framework 4.8.1)
│       ├── AppPeliculas/                # UI (formularios, menú)
│       ├── Dominio/                     # entidades (Pago, MetodoPago, …)
│       ├── Negocio/                     # reglas y orquestación (*Negocio.cs)
│       └── AccesoDatos/                 # SqlConnection, consultas y SP
├── README.md
└── sql/
    └── desarrollo_db/
        ├── creacion_bd.sql              # DDL: CREATE DATABASE + tablas + restricciones
        ├── insercion_datos.sql          # INSERT de datos de prueba (bloques por integrante)
        ├── views.sql                    # Vistas
        ├── procedimientos_almacenados.sql
        ├── funciones.sql                # Funciones T-SQL (si aplica al TPI)
        └── triggers.sql
```

Las secciones de **inserción**, **vistas** y **SP** pueden organizarse por comentarios de cabecera por integrante, para reducir conflictos al hacer merge desde ramas `feature/*`.

---

## Orden recomendado de ejecución (SSMS)

1. **`creacion_bd.sql`** — crea la base `BD2_TPI_G19` y todas las tablas.
2. **`insercion_datos.sql`** — cargar datos respetando el orden de claves foráneas (catalogo → complejos/salas → funciones/butacas → usuarios → métodos/reservas/pagos → detalle).
3. **`views.sql`**
4. **`procedimientos_almacenados.sql`**
5. **`funciones.sql`** 
6. **`triggers.sql`**

Incluir al inicio de los scripts auxiliares (cuando aplique):

```sql
USE BD2_TPI_G19;
GO
SET DATEFORMAT ymd;
GO
```

**Importante:** si se vuelve a ejecutar `insercion_datos.sql` sobre una base ya cargada, fallará por restricciones UNIQUE. Para recargar datos de prueba, recrear la base o limpiar tablas en orden inverso a las FK.

**Acentos y texto en español:** las columnas de texto legible (`nombre`, `titulo`, `descripcion`, `sinopsis`, etc.) usan **`NVARCHAR`** en el DDL. Los scripts están en **UTF-8**. Desde consola: `sqlcmd ... -f 65001`. En SSMS, abrir/guardar el archivo con codificación UTF-8. Si los acentos se ven mal, **recrear la BD** ejecutando los 6 scripts en orden (no basta con volver a correr solo `insercion_datos.sql` sobre tablas `VARCHAR` antiguas).

---

## Aplicación cliente WinForms (`appPeliculas`)

Cliente de escritorio en **C# / .NET Framework 4.8.1** con arquitectura en capas. Referencia de implementación: módulo **Pagos** (BD2-60, Marcelo).

### Requisitos previos

1. **SQL Server** en Docker (ver sección anterior) o SQL Server Express local.
2. Ejecutar los **6 scripts** de `sql/desarrollo_db/` en el orden indicado arriba. La grilla de Pagos depende de `views.sql` (`vw_PagosAprobados`) y las acciones de `sp_RegistrarPago` / `sp_CancelarReserva` en `procedimientos_almacenados.sql`.
3. **Visual Studio 2022** con carga de trabajo *Desarrollo de escritorio de .NET*.

### Abrir y ejecutar

1. Abrir [`appPeliculas/BD2-TPI-G19/BD2-TPI-G19.sln`](appPeliculas/BD2-TPI-G19/BD2-TPI-G19.sln).
2. Restaurar paquetes NuGet (clic derecho en la solución → *Restaurar paquetes NuGet*). Se usa `Microsoft.Data.SqlClient` con el paquete **SNI** (requerido en tiempo de ejecución).
3. Establecer **AppPeliculas** como proyecto de inicio.
4. **F5** → menú principal con acceso a **Películas**, **Funciones**, **Reservas** y **Pagos**.

### Arquitectura

```
frmPrincipal  →  frmPagos / frmPeliculas / frmFunciones / frmReservas
                      ↓
                 *Negocio.cs  →  AccesoDatos  →  SQL Server (BD2_TPI_G19)
                      ↓
                   Dominio          vistas / SP / tablas
```

| Capa | Proyecto | Responsabilidad |
|------|----------|-----------------|
| UI | `AppPeliculas` | Formularios, validación de entrada, `DataGridView`, combos |
| Negocio | `Negocio` | Clases `*Negocio.cs`: listados, llamadas a SP, reglas simples |
| Datos | `AccesoDatos` | `AccesoDatos.cs`: conexión, `setearConsulta`, `setearProcedimiento` |
| Modelo | `Dominio` | Entidades POCO (`Pago`, `MetodoPago`, …) |

### Conexión a la base

Cadena de conexión en [`AccesoDatos/AccesoDatos.cs`](appPeliculas/BD2-TPI-G19/AccesoDatos/AccesoDatos.cs) (desarrollo local):

```
Server=localhost,1433;Database=BD2_TPI_G19;User Id=sa;Password=BaseDatos#2;TrustServerCertificate=True;
```

Ajustar servidor/usuario si el entorno difiere del Docker de ejemplo.

### Patrón MVP por módulo (equipo)

Cada integrante implementa **un formulario** siguiendo el mismo esquema que Pagos:

| Elemento | Qué hacer |
|----------|-----------|
| Grilla | `SELECT` sobre **vista** del módulo (`DataSource` desde `*Negocio.Listar…()`) |
| Acción principal | Un **stored procedure** vía `setearProcedimiento` + parámetros |
| Menú | Registrar el form en `frmPrincipal.cs` (`ShowDialog`) |
| Capas | Entidad en `Dominio`, lógica en `Negocio`, SQL en `AccesoDatos` |

### Estado de módulos WinForms

| Módulo | Vista (grilla) | SP (acción) | Estado |
|--------|----------------|-------------|--------|
| Pagos | `vw_PagosAprobados` | `sp_RegistrarPago`, `sp_CancelarReserva` | Implementado |
| Películas | `vw_CarteleraPeliculas` | `sp_InsertarPelicula` | Implementado |
| Funciones | `vw_FuncionesCompleto` | `sp_CrearFuncion` | Implementado |
| Reservas | `vw_DetalleReservasCompleto` | `sp_CrearReservaConDetalle` | Implementado |

**WinForms:** Marcelo Carabajal (módulos Pagos, Películas, Funciones y Reservas).  
**SQL (vistas/SP por dominio):** Gastón (películas), Gisela (funciones/salas), Henry (reservas/usuarios), Marcelo (pagos).

Ramas de referencia: `feature/BD2-60-winforms-mvp` (Pagos), `feature/BD2-60-winforms-reservas` (Reservas).

### Pruebas de integración (SQL)

Al final de [`procedimientos_almacenados.sql`](sql/desarrollo_db/procedimientos_almacenados.sql) y [`triggers.sql`](sql/desarrollo_db/triggers.sql) hay bloques comentados con casos de prueba (BD2-41 / BD2-42). Ejecutarlos **en orden** sobre una **BD limpia** (scripts 1→6). Ver también [`sql/docs/PRUEBA_ROLLBACK.sql`](sql/docs/PRUEBA_ROLLBACK.sql).

---

## Reglas de negocio destacadas en el DDL

| Regla | Dónde |
|-------|--------|
| Estado de sala | `tipo_sala` ∈ `('2D','3D','IMAX')`; `capacidad_total` > 0 |
| Precio de función | `precio_base` > 0 |
| Función futura | `FUNCIONES.fecha_hora` > momento actual (`GETDATE()` al insertar — pensar datos de prueba con fechas futuras) |
| Reserva | `estado` ∈ Pendiente \| Pagada \| Cancelada |
| Un pago por reserva | `UQ_PAGOS_RESERVA` en `PAGOS` |
| Estado de pago | `estado_pago` ∈ Pendiente \| Aprobado \| Rechazado \| Devuelto |
| No repetir butaca por reserva | `UQ_DETALLES_RESERVAS_ReservaButaca` en `DETALLES_RESERVAS` |
| No repetir butaca en misma función | Trigger `TR_DetallesReservas_EvitarButacaDuplicada` (BD2-62) |

---

## Convenciones y base de datos

- **Nombre de la BD:** `BD2_TPI_G19`
- **Collation:** `Latin1_General_CI_AI` (consistente con scripts de práctica del curso)
- **Texto legible:** `NVARCHAR` en nombres, títulos, descripciones, direcciones y apellidos
- **Códigos / enums:** `VARCHAR` en `estado`, `estado_pago`, `tipo_sala`, `email`, `password`, `telefono`, `fila`
- **Claves surrogate:** `IDENTITY(1,1)` en PK

---

## Flujo Git (referencia)

- Rama principal típica: `main`.
- Funcionalidad nueva: ramas `feature/BD2-XX-descripcion breve`.
- Ejemplo relacionado al módulo de pagos/reservas:  
  `feature/BD2-21-insercion-datos-modulo-reservas-pagos-medios-pagos`.

Antes del merge coordinar IDs de FK en **`insercion_datos.sql`** entre Gastón, Gisela, Henry y Marcelo para evitar errores 547.

---

## Seguridad

El campo **`USUARIOS.password`** existe para el modelo funcional del TPI en entorno **académico**. En un sistema real las contraseñas no se guardarían en texto plano ni en esta columna tal cual.

---

## Documentación complementaria del equipo

- Minutas en el aula virtual del curso (alcance funcional, DER, reparto).
- DER en Draw.io y luego en SQL Server Management Studio (SSMS).

---

## Licencia / uso académico

Proyecto académico UTN · Uso dentro del marco del TPI BD2 correspondiente.
