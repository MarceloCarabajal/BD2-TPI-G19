using System;
using System.Collections.Generic;
using Acceso_Datos;
using Dominio;

namespace Negocio
{
    public class ReservaNegocio
    {
        public List<DetalleReserva> ListarDetalle()
        {
            var lista = new List<DetalleReserva>();
            var db = new AccesoDatos();

            try
            {
                db.setearConsulta(
                    "SELECT id_reserva, id_usuario, nombre, apellido, email, fecha_registro_usuario, " +
                    "id_funcion, id_butaca, precio_unitario, total_pagado, fecha_reserva, estado_reserva " +
                    "FROM vw_DetalleReservasCompleto ORDER BY fecha_reserva DESC, id_reserva ASC");
                db.ejecutarLectura();

                while (db.Lector.Read())
                {
                    lista.Add(new DetalleReserva
                    {
                        IdReserva = Convert.ToInt64(db.Lector["id_reserva"]),
                        IdUsuario = Convert.ToInt64(db.Lector["id_usuario"]),
                        Nombre = db.Lector["nombre"]?.ToString() ?? string.Empty,
                        Apellido = db.Lector["apellido"]?.ToString() ?? string.Empty,
                        Email = db.Lector["email"]?.ToString() ?? string.Empty,
                        FechaRegistroUsuario = Convert.ToDateTime(db.Lector["fecha_registro_usuario"]),
                        IdFuncion = Convert.ToInt64(db.Lector["id_funcion"]),
                        IdButaca = Convert.ToInt64(db.Lector["id_butaca"]),
                        PrecioUnitario = Convert.ToDecimal(db.Lector["precio_unitario"]),
                        TotalPagado = db.Lector["total_pagado"] == DBNull.Value
                            ? (decimal?)null
                            : Convert.ToDecimal(db.Lector["total_pagado"]),
                        FechaReserva = Convert.ToDateTime(db.Lector["fecha_reserva"]),
                        EstadoReserva = db.Lector["estado_reserva"]?.ToString() ?? string.Empty
                    });
                }

                return lista;
            }
            finally
            {
                db.cerrarConexion();
            }
        }

        public List<CatalogoItem> ListarUsuarios()
        {
            return ListarCatalogo(
                "SELECT id_usuario, nombre + ' ' + apellido + ' (' + email + ')' " +
                "FROM USUARIOS ORDER BY apellido, nombre");
        }

        public List<CatalogoItem> ListarFunciones()
        {
            return ListarCatalogo(
                "SELECT f.id_funcion, p.titulo + ' — ' + CONVERT(varchar(16), f.fecha_hora, 120) + " +
                "' ($' + CAST(f.precio_base AS varchar(20)) + ')' " +
                "FROM FUNCIONES f INNER JOIN PELICULAS p ON f.id_pelicula = p.id_pelicula " +
                "ORDER BY f.fecha_hora");
        }

        public List<CatalogoItem> ListarButacasLibres(long idFuncion)
        {
            if (idFuncion <= 0)
                return new List<CatalogoItem>();

            var lista = new List<CatalogoItem>();
            var db = new AccesoDatos();

            try
            {
                db.setearConsulta(
                    "SELECT id_butaca, fila + ' — Nº ' + CAST(numero_butaca AS varchar(10)) " +
                    "FROM vw_ButacasLibresPorFuncion WHERE id_funcion = @id_funcion " +
                    "ORDER BY fila, numero_butaca");
                db.setearParametro("@id_funcion", idFuncion);
                db.ejecutarLectura();

                while (db.Lector.Read())
                {
                    lista.Add(new CatalogoItem
                    {
                        Id = Convert.ToInt64(db.Lector[0]),
                        Descripcion = db.Lector[1]?.ToString() ?? string.Empty
                    });
                }

                return lista;
            }
            finally
            {
                db.cerrarConexion();
            }
        }

        public void CrearReserva(long idUsuario, long idFuncion, long idButaca)
        {
            if (idUsuario <= 0 || idFuncion <= 0 || idButaca <= 0)
                throw new ArgumentException("Seleccione usuario, función y butaca.");

            var db = new AccesoDatos();

            try
            {
                db.setearProcedimiento("sp_CrearReservaConDetalle");
                db.setearParametro("@id_usuario", idUsuario);
                db.setearParametro("@id_funcion", idFuncion);
                db.setearParametro("@id_butaca", idButaca);
                db.ejecutarAccion();
            }
            finally
            {
                db.cerrarConexion();
            }
        }

        private static List<CatalogoItem> ListarCatalogo(string consulta)
        {
            var lista = new List<CatalogoItem>();
            var db = new AccesoDatos();

            try
            {
                db.setearConsulta(consulta);
                db.ejecutarLectura();

                while (db.Lector.Read())
                {
                    lista.Add(new CatalogoItem
                    {
                        Id = Convert.ToInt64(db.Lector[0]),
                        Descripcion = db.Lector[1]?.ToString() ?? string.Empty
                    });
                }

                return lista;
            }
            finally
            {
                db.cerrarConexion();
            }
        }
    }
}
