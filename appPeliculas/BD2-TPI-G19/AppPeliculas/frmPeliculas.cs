using System;
using System.Windows.Forms;
using Dominio;
using Negocio;

namespace AppPeliculas
{
    public partial class frmPeliculas : Form
    {
        private readonly PeliculaNegocio negocio = new PeliculaNegocio();

        public frmPeliculas()
        {
            InitializeComponent();
            Load += frmPeliculas_Load;
        }

        private void frmPeliculas_Load(object sender, EventArgs e)
        {
            CargarCombos();
            RefrescarGrilla();
        }

        private void CargarCombos()
        {
            try
            {
                cboClasificacion.DataSource = negocio.ListarClasificaciones();
                cboClasificacion.DisplayMember = "Descripcion";
                cboClasificacion.ValueMember = "Id";

                cboGenero.DataSource = negocio.ListarGeneros();
                cboGenero.DisplayMember = "Descripcion";
                cboGenero.ValueMember = "Id";
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al cargar catálogos: " + ex.Message, "Películas",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void RefrescarGrilla()
        {
            try
            {
                dgvCartelera.DataSource = null;
                dgvCartelera.DataSource = negocio.ListarCartelera();
                ConfigurarGrilla();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al cargar cartelera: " + ex.Message, "Películas",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void ConfigurarGrilla()
        {
            if (dgvCartelera.Columns.Count == 0)
                return;

            dgvCartelera.ReadOnly = true;
            dgvCartelera.AllowUserToAddRows = false;
            dgvCartelera.AllowUserToDeleteRows = false;
            dgvCartelera.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgvCartelera.MultiSelect = false;
            dgvCartelera.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;

            dgvCartelera.Columns[nameof(CarteleraPelicula.IdFuncion)].HeaderText = "Id función";
            dgvCartelera.Columns[nameof(CarteleraPelicula.Pelicula)].HeaderText = "Película";
            dgvCartelera.Columns[nameof(CarteleraPelicula.Complejo)].HeaderText = "Complejo";
            dgvCartelera.Columns[nameof(CarteleraPelicula.NombreSala)].HeaderText = "Sala";
            dgvCartelera.Columns[nameof(CarteleraPelicula.TipoSala)].HeaderText = "Tipo";
            dgvCartelera.Columns[nameof(CarteleraPelicula.FechaHora)].HeaderText = "Fecha/hora";
            dgvCartelera.Columns[nameof(CarteleraPelicula.FechaHora)].DefaultCellStyle.Format = "g";
            dgvCartelera.Columns[nameof(CarteleraPelicula.PrecioBase)].HeaderText = "Precio";
            dgvCartelera.Columns[nameof(CarteleraPelicula.PrecioBase)].DefaultCellStyle.Format = "C2";
        }

        private void btnActualizar_Click(object sender, EventArgs e)
        {
            RefrescarGrilla();
        }

        private void btnInsertar_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtTitulo.Text))
            {
                MessageBox.Show("Ingrese el título.", "Insertar película",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                txtTitulo.Focus();
                return;
            }

            if (!(cboClasificacion.SelectedValue is long idClasificacion) || idClasificacion <= 0)
            {
                MessageBox.Show("Seleccione una clasificación.", "Insertar película",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                cboClasificacion.Focus();
                return;
            }

            if (!(cboGenero.SelectedValue is long idGenero) || idGenero <= 0)
            {
                MessageBox.Show("Seleccione un género.", "Insertar película",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                cboGenero.Focus();
                return;
            }

            if (!short.TryParse(txtDuracion.Text.Trim(), out short duracion) || duracion <= 0)
            {
                MessageBox.Show("Ingrese una duración válida en minutos.", "Insertar película",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                txtDuracion.Focus();
                return;
            }

            try
            {
                negocio.InsertarPelicula(idClasificacion, idGenero, txtTitulo.Text, txtSinopsis.Text, duracion);
                MessageBox.Show(
                    "Película insertada en PELICULAS.\n\n" +
                    "La grilla muestra la cartelera (funciones programadas). " +
                    "Para verla acá, creá una función en el módulo Funciones.",
                    "Insertar película",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Information);
                txtTitulo.Clear();
                txtSinopsis.Clear();
                txtDuracion.Clear();
                RefrescarGrilla();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Insertar película",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
    }
}
