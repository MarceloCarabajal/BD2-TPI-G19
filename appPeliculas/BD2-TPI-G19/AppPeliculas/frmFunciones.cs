using System;
using System.Windows.Forms;
using Dominio;
using Negocio;

namespace AppPeliculas
{
    public partial class frmFunciones : Form
    {
        private readonly FuncionNegocio negocio = new FuncionNegocio();

        public frmFunciones()
        {
            InitializeComponent();
            Load += frmFunciones_Load;
        }

        private void frmFunciones_Load(object sender, EventArgs e)
        {
            dtpFechaHora.MinDate = DateTime.Now.AddHours(1);
            dtpFechaHora.Value = DateTime.Now.AddDays(1);
            CargarCombos();
            RefrescarGrilla();
        }

        private void CargarCombos()
        {
            try
            {
                cboPelicula.DataSource = negocio.ListarPeliculas();
                cboPelicula.DisplayMember = "Descripcion";
                cboPelicula.ValueMember = "Id";

                cboSala.DataSource = negocio.ListarSalas();
                cboSala.DisplayMember = "Descripcion";
                cboSala.ValueMember = "Id";
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al cargar catálogos: " + ex.Message, "Funciones",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void RefrescarGrilla()
        {
            try
            {
                dgvFunciones.DataSource = null;
                dgvFunciones.DataSource = negocio.ListarFunciones();
                ConfigurarGrilla();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al cargar funciones: " + ex.Message, "Funciones",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void ConfigurarGrilla()
        {
            if (dgvFunciones.Columns.Count == 0)
                return;

            dgvFunciones.ReadOnly = true;
            dgvFunciones.AllowUserToAddRows = false;
            dgvFunciones.AllowUserToDeleteRows = false;
            dgvFunciones.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgvFunciones.MultiSelect = false;
            dgvFunciones.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;

            dgvFunciones.Columns[nameof(FuncionCompleta.IdFuncion)].HeaderText = "Id función";
            dgvFunciones.Columns[nameof(FuncionCompleta.FechaHora)].HeaderText = "Fecha/hora";
            dgvFunciones.Columns[nameof(FuncionCompleta.FechaHora)].DefaultCellStyle.Format = "g";
            dgvFunciones.Columns[nameof(FuncionCompleta.PeliculaTitulo)].HeaderText = "Película";
            dgvFunciones.Columns[nameof(FuncionCompleta.NombreSala)].HeaderText = "Sala";
            dgvFunciones.Columns[nameof(FuncionCompleta.ComplejoNombre)].HeaderText = "Complejo";
            dgvFunciones.Columns[nameof(FuncionCompleta.PrecioBase)].HeaderText = "Precio";
            dgvFunciones.Columns[nameof(FuncionCompleta.PrecioBase)].DefaultCellStyle.Format = "C2";
            dgvFunciones.Columns[nameof(FuncionCompleta.Genero)].HeaderText = "Género";
            dgvFunciones.Columns[nameof(FuncionCompleta.Clasificacion)].HeaderText = "Clasificación";
            dgvFunciones.Columns[nameof(FuncionCompleta.TipoSala)].HeaderText = "Tipo sala";
            dgvFunciones.Columns[nameof(FuncionCompleta.DuracionMinutos)].HeaderText = "Duración (min)";
            dgvFunciones.Columns[nameof(FuncionCompleta.ComplejoDireccion)].HeaderText = "Dirección";
        }

        private void btnActualizar_Click(object sender, EventArgs e)
        {
            RefrescarGrilla();
        }

        private void btnCrearFuncion_Click(object sender, EventArgs e)
        {
            if (!(cboPelicula.SelectedValue is long idPelicula) || idPelicula <= 0)
            {
                MessageBox.Show("Seleccione una película.", "Crear función",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                cboPelicula.Focus();
                return;
            }

            if (!(cboSala.SelectedValue is long idSala) || idSala <= 0)
            {
                MessageBox.Show("Seleccione una sala.", "Crear función",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                cboSala.Focus();
                return;
            }

            if (!decimal.TryParse(txtPrecioBase.Text.Trim(), out decimal precio) || precio <= 0)
            {
                MessageBox.Show("Ingrese un precio base válido.", "Crear función",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                txtPrecioBase.Focus();
                return;
            }

            try
            {
                negocio.CrearFuncion(idPelicula, idSala, dtpFechaHora.Value, precio);
                MessageBox.Show("Función creada correctamente.", "Crear función",
                    MessageBoxButtons.OK, MessageBoxIcon.Information);
                txtPrecioBase.Clear();
                RefrescarGrilla();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Crear función",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
    }
}
