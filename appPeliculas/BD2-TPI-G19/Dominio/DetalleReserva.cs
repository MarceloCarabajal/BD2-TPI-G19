using System;

namespace Dominio
{
    public class DetalleReserva
    {
        public long IdReserva { get; set; }
        public long IdUsuario { get; set; }
        public string Nombre { get; set; } = string.Empty;
        public string Apellido { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public DateTime FechaRegistroUsuario { get; set; }
        public long IdFuncion { get; set; }
        public long IdButaca { get; set; }
        public decimal PrecioUnitario { get; set; }
        public decimal? TotalPagado { get; set; }
        public DateTime FechaReserva { get; set; }
        public string EstadoReserva { get; set; } = string.Empty;
    }
}
