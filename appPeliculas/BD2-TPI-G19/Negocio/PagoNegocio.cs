using System;
using System.Collections.Generic;
using Acceso_Datos;
using Dominio;

namespace Negocio
{
    public class PagoNegocio
    {
        public List<Pago> ListarPagosAprobados()
        {
            var lista = new List<Pago>();
            var db = new AccesoDatos();

            try
            {
                db.setearConsulta(
                    "SELECT id_pago, id_reserva, metodo_pago, total_pagado, " +
                    "fecha_pago, email, estado_reserva FROM vw_PagosAprobados");
                db.ejecutarLectura();

                while (db.Lector.Read())
                {
                    lista.Add(new Pago
                    {
                        IdPago = Convert.ToInt64(db.Lector["id_pago"]),
                        IdReserva = Convert.ToInt64(db.Lector["id_reserva"]),
                        MetodoPago = db.Lector["metodo_pago"]?.ToString() ?? string.Empty,
                        TotalPagado = Convert.ToDecimal(db.Lector["total_pagado"]),
                        FechaPago = Convert.ToDateTime(db.Lector["fecha_pago"]),
                        Email = db.Lector["email"]?.ToString() ?? string.Empty,
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

        public List<MetodoPago> ListarMetodosPago()
        {
            var lista = new List<MetodoPago>();
            var db = new AccesoDatos();

            try
            {
                db.setearConsulta(
                    "SELECT id_metodo_pago, nombre FROM METODOS_PAGOS ORDER BY nombre");
                db.ejecutarLectura();

                while (db.Lector.Read())
                {
                    lista.Add(new MetodoPago
                    {
                        IdMetodoPago = Convert.ToInt64(db.Lector["id_metodo_pago"]),
                        Nombre = db.Lector["nombre"]?.ToString() ?? string.Empty
                    });
                }

                return lista;
            }
            finally
            {
                db.cerrarConexion();
            }
        }

        public void RegistrarPago(long idReserva, long idMetodoPago, decimal total)
        {
            if (idReserva <= 0 || idMetodoPago <= 0)
                throw new ArgumentException("Id de reserva y método de pago deben ser mayores a cero.");
            if (total <= 0)
                throw new ArgumentException("El total debe ser mayor a cero.");

            var db = new AccesoDatos();

            try
            {
                db.setearProcedimiento("sp_RegistrarPago");
                db.setearParametro("@id_reserva", idReserva);
                db.setearParametro("@id_metodo_pago", idMetodoPago);
                db.setearParametro("@total_pagado", total);
                db.ejecutarAccion();
            }
            finally
            {
                db.cerrarConexion();
            }
        }

        public void CancelarReserva(long idReserva)
        {
            if (idReserva <= 0)
                throw new ArgumentException("Id de reserva inválido.");

            var db = new AccesoDatos();

            try
            {
                db.setearProcedimiento("sp_CancelarReserva");
                db.setearParametro("@id_reserva", idReserva);
                db.ejecutarAccion();
            }
            finally
            {
                db.cerrarConexion();
            }
        }
    }
}