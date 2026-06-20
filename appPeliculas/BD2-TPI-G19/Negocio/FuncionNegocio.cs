using System;
using System.Collections.Generic;
using Acceso_Datos;
using Dominio;

namespace Negocio
{
    public class FuncionNegocio
    {
        public List<FuncionCompleta> ListarFunciones()
        {
            var lista = new List<FuncionCompleta>();
            var db = new AccesoDatos();

            try
            {
                db.setearConsulta(
                    "SELECT id_funcion, fecha_hora, precio_base, pelicula_titulo, duracion_minutos, " +
                    "genero, clasificacion, nombre_sala, tipo_sala, complejo_nombre, complejo_direccion " +
                    "FROM vw_FuncionesCompleto ORDER BY fecha_hora");
                db.ejecutarLectura();

                while (db.Lector.Read())
                {
                    lista.Add(new FuncionCompleta
                    {
                        IdFuncion = Convert.ToInt64(db.Lector["id_funcion"]),
                        FechaHora = Convert.ToDateTime(db.Lector["fecha_hora"]),
                        PrecioBase = Convert.ToDecimal(db.Lector["precio_base"]),
                        PeliculaTitulo = db.Lector["pelicula_titulo"]?.ToString() ?? string.Empty,
                        DuracionMinutos = Convert.ToInt16(db.Lector["duracion_minutos"]),
                        Genero = db.Lector["genero"]?.ToString() ?? string.Empty,
                        Clasificacion = db.Lector["clasificacion"]?.ToString() ?? string.Empty,
                        NombreSala = db.Lector["nombre_sala"]?.ToString() ?? string.Empty,
                        TipoSala = db.Lector["tipo_sala"]?.ToString() ?? string.Empty,
                        ComplejoNombre = db.Lector["complejo_nombre"]?.ToString() ?? string.Empty,
                        ComplejoDireccion = db.Lector["complejo_direccion"]?.ToString() ?? string.Empty
                    });
                }

                return lista;
            }
            finally
            {
                db.cerrarConexion();
            }
        }

        public List<CatalogoItem> ListarPeliculas()
        {
            return ListarCatalogo("SELECT id_pelicula, titulo FROM PELICULAS ORDER BY titulo");
        }

        public List<CatalogoItem> ListarSalas()
        {
            return ListarCatalogo(
                "SELECT s.id_sala, c.nombre + ' - ' + s.nombre_sala + ' (' + s.tipo_sala + ')' " +
                "FROM SALAS s INNER JOIN COMPLEJOS c ON s.id_complejo = c.id_complejo " +
                "ORDER BY c.nombre, s.nombre_sala");
        }

        public void CrearFuncion(long idPelicula, long idSala, DateTime fechaHora, decimal precioBase)
        {
            if (idPelicula <= 0 || idSala <= 0)
                throw new ArgumentException("Seleccione película y sala.");
            if (precioBase <= 0)
                throw new ArgumentException("El precio base debe ser mayor a cero.");
            if (fechaHora <= DateTime.Now)
                throw new ArgumentException("La función debe programarse en una fecha y hora futuras.");

            var db = new AccesoDatos();

            try
            {
                db.setearProcedimiento("sp_CrearFuncion");
                db.setearParametro("@id_pelicula", idPelicula);
                db.setearParametro("@id_sala", idSala);
                db.setearParametro("@fecha_hora", fechaHora);
                db.setearParametro("@precio_base", precioBase);
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
