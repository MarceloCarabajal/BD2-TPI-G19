using System;
using Microsoft.Data.SqlClient;




namespace AccesoDatos
{
    public class AccesoDatos
    {
        private SqlConnection conexion;
        private SqlCommand comando;
        private SqlDataReader lector;

        public SqlDataReader Lector
        {
            get
            {
                return lector;
            }

        }
        public AccesoDatos()
        {
            conexion = new SqlConnection(


                "Server=localhost,1433;Database=BD2_TPI_G19;User Id=sa;Password=BaseDatos#2;TrustServerCertificate=True;");

            comando = new SqlCommand();


        }
        public void setearConsulta(string consulta)
        {
            comando.Parameters.Clear();
            comando.CommandType = System.Data.CommandType.Text;
            comando.CommandText = consulta;
        }
        public void setearParametro(string nombre, object valor)
        {
            comando.Parameters.AddWithValue(nombre, valor);
        }
        public void ejecutarLectura()
        {
            comando.Connection = conexion;
            try
            {
                conexion.Open();
                lector = comando.ExecuteReader();
            }
            catch { throw; }
        }

        public void ejecutarAccion()
        {
            comando.Connection = conexion;
            try
            {
                conexion.Open();
                comando.ExecuteNonQuery();
            }
            catch { throw; }
            finally
            {
                conexion.Close();
            }
        }

        public void cerrarConexion()
        {
            lector?.Close();
            conexion.Close();

        }

        public void setearProcedimiento(string nombre)
        {
            comando.Parameters.Clear();
            comando.CommandType = System.Data.CommandType.StoredProcedure;
            comando.CommandText = nombre;
        }
    }
}
