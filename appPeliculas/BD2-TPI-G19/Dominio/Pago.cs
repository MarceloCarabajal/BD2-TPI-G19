using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Pago
    {
        public long IdPago { get; set; }
        public long IdReserva { get; set; }
        public string MetodoPago { get; set; } = string.Empty;
        public decimal TotalPagado { get; set; }
        public DateTime FechaPago { get; set; }
        public string Email { get; set; } = string.Empty;
        public string EstadoReserva { get; set; } = string.Empty;
    }

}
