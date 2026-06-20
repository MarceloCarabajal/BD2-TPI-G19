namespace Dominio
{
    public class CatalogoItem
    {
        public long Id { get; set; }
        public string Descripcion { get; set; } = string.Empty;

        public override string ToString()
        {
            return Descripcion;
        }
    }
}
