using System;

namespace Dominio
{
    public class FuncionCompleta
    {
        public long IdFuncion { get; set; }
        public DateTime FechaHora { get; set; }
        public decimal PrecioBase { get; set; }
        public string PeliculaTitulo { get; set; } = string.Empty;
        public short DuracionMinutos { get; set; }
        public string Genero { get; set; } = string.Empty;
        public string Clasificacion { get; set; } = string.Empty;
        public string NombreSala { get; set; } = string.Empty;
        public string TipoSala { get; set; } = string.Empty;
        public string ComplejoNombre { get; set; } = string.Empty;
        public string ComplejoDireccion { get; set; } = string.Empty;
    }
}
