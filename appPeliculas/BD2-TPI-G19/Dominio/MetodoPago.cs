using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class MetodoPago
    {
        public long IdMetodoPago { get; set; }
        public string Nombre { get; set; } = string.Empty;

        public override string ToString()
        {
            return Nombre;
        }
    }
}
