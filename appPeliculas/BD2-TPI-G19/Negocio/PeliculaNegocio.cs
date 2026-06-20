using System;
using System.Collections.Generic;
using Acceso_Datos;
using Dominio;

namespace Negocio
{
    public class PeliculaNegocio
    {
        public List<CarteleraPelicula> ListarCartelera()
        {
            var lista = new List<CarteleraPelicula>();
            var db = new AccesoDatos();

            try
            {
                db.setearConsulta(
                    "SELECT id_funcion, Pelicula, Complejo, nombre_sala, tipo_sala, " +
                    "fecha_hora, precio_base FROM vw_CarteleraPeliculas ORDER BY fecha_hora");
                db.ejecutarLectura();

                while (db.Lector.Read())
                {
                    lista.Add(new CarteleraPelicula
                    {
                        IdFuncion = Convert.ToInt64(db.Lector["id_funcion"]),
                        Pelicula = db.Lector["Pelicula"]?.ToString() ?? string.Empty,
                        Complejo = db.Lector["Complejo"]?.ToString() ?? string.Empty,
                        NombreSala = db.Lector["nombre_sala"]?.ToString() ?? string.Empty,
                        TipoSala = db.Lector["tipo_sala"]?.ToString() ?? string.Empty,
                        FechaHora = Convert.ToDateTime(db.Lector["fecha_hora"]),
                        PrecioBase = Convert.ToDecimal(db.Lector["precio_base"])
                    });
                }

                return lista;
            }
            finally
            {
                db.cerrarConexion();
            }
        }

        public List<CatalogoItem> ListarClasificaciones()
        {
            return ListarCatalogo("SELECT id_clasificacion, descripcion FROM CLASIFICACIONES ORDER BY descripcion");
        }

        public List<CatalogoItem> ListarGeneros()
        {
            return ListarCatalogo("SELECT id_genero, descripcion FROM GENEROS ORDER BY descripcion");
        }

        public void InsertarPelicula(long idClasificacion, long idGenero, string titulo, string sinopsis, short duracion)
        {
            if (idClasificacion <= 0 || idGenero <= 0)
                throw new ArgumentException("Seleccione clasificación y género.");
            if (string.IsNullOrWhiteSpace(titulo))
                throw new ArgumentException("El título es obligatorio.");
            if (duracion <= 0)
                throw new ArgumentException("La duración debe ser mayor a cero.");

            var db = new AccesoDatos();

            try
            {
                db.setearProcedimiento("sp_InsertarPelicula");
                db.setearParametro("@ID_Clasificaciones", idClasificacion);
                db.setearParametro("@ID_Genero", idGenero);
                db.setearParametro("@Titulo", titulo.Trim());
                db.setearParametro("@Sinopsis", sinopsis?.Trim() ?? string.Empty);
                db.setearParametro("@Duracion", duracion);
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
