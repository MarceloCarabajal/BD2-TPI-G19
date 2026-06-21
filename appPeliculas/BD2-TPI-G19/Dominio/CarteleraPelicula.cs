using System;

namespace Dominio
{
    public class CarteleraPelicula
    {
        public long IdFuncion { get; set; }
        public string Pelicula { get; set; } = string.Empty;
        public string Complejo { get; set; } = string.Empty;
        public string NombreSala { get; set; } = string.Empty;
        public string TipoSala { get; set; } = string.Empty;
        public DateTime FechaHora { get; set; }
        public decimal PrecioBase { get; set; }
    }
}
