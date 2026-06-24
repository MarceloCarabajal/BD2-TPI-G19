using System;
using System.Windows.Forms;
using Dominio;
using Negocio;

namespace AppPeliculas
{
    public partial class frmReservas : Form
    {
        private readonly ReservaNegocio negocio = new ReservaNegocio();

        public frmReservas()
        {
            InitializeComponent();
            Load += frmReservas_Load;
        }

        private void frmReservas_Load(object sender, EventArgs e)
        {
            CargarCombos();
            RefrescarGrilla();
        }

        private void CargarCombos()
        {
            try
            {
                cboUsuario.DataSource = negocio.ListarUsuarios();
                cboUsuario.DisplayMember = "Descripcion";
                cboUsuario.ValueMember = "Id";

                cboFuncion.DataSource = negocio.ListarFunciones();
                cboFuncion.DisplayMember = "Descripcion";
                cboFuncion.ValueMember = "Id";

                CargarButacas();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al cargar datos: " + ex.Message, "Reservas",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void CargarButacas()
        {
            if (!(cboFuncion.SelectedValue is long idFuncion) || idFuncion <= 0)
            {
                cboButaca.DataSource = null;
                btnCrearReserva.Enabled = false;
                return;
            }

            try
            {
                var butacas = negocio.ListarButacasLibres(idFuncion);
                cboButaca.DataSource = butacas;
                cboButaca.DisplayMember = "Descripcion";
                cboButaca.ValueMember = "Id";
                btnCrearReserva.Enabled = butacas.Count > 0;

                if (butacas.Count == 0)
                    lblButaca.Text = "Butaca libre (sin disponibles)";
                else
                    lblButaca.Text = "Butaca libre";
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al cargar butacas: " + ex.Message, "Reservas",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
                btnCrearReserva.Enabled = false;
            }
        }

        private void RefrescarGrilla()
        {
            try
            {
                dgvReservas.DataSource = null;
                dgvReservas.DataSource = negocio.ListarDetalle();
                ConfigurarGrilla();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al cargar reservas: " + ex.Message, "Reservas",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void ConfigurarGrilla()
        {
            if (dgvReservas.Columns.Count == 0)
                return;

            dgvReservas.ReadOnly = true;
            dgvReservas.AllowUserToAddRows = false;
            dgvReservas.AllowUserToDeleteRows = false;
            dgvReservas.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgvReservas.MultiSelect = false;
            dgvReservas.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;

            dgvReservas.Columns[nameof(DetalleReserva.IdReserva)].HeaderText = "Id reserva";
            dgvReservas.Columns[nameof(DetalleReserva.IdUsuario)].HeaderText = "Id usuario";
            dgvReservas.Columns[nameof(DetalleReserva.Nombre)].HeaderText = "Nombre";
            dgvReservas.Columns[nameof(DetalleReserva.Apellido)].HeaderText = "Apellido";
            dgvReservas.Columns[nameof(DetalleReserva.Email)].HeaderText = "Email";
            dgvReservas.Columns[nameof(DetalleReserva.FechaRegistroUsuario)].HeaderText = "Registro usuario";
            dgvReservas.Columns[nameof(DetalleReserva.FechaRegistroUsuario)].DefaultCellStyle.Format = "d";
            dgvReservas.Columns[nameof(DetalleReserva.IdFuncion)].HeaderText = "Id función";
            dgvReservas.Columns[nameof(DetalleReserva.IdButaca)].HeaderText = "Id butaca";
            dgvReservas.Columns[nameof(DetalleReserva.PrecioUnitario)].HeaderText = "Precio unit.";
            dgvReservas.Columns[nameof(DetalleReserva.PrecioUnitario)].DefaultCellStyle.Format = "C2";
            dgvReservas.Columns[nameof(DetalleReserva.TotalPagado)].HeaderText = "Total pagado";
            dgvReservas.Columns[nameof(DetalleReserva.TotalPagado)].DefaultCellStyle.Format = "C2";
            dgvReservas.Columns[nameof(DetalleReserva.FechaReserva)].HeaderText = "Fecha reserva";
            dgvReservas.Columns[nameof(DetalleReserva.FechaReserva)].DefaultCellStyle.Format = "g";
            dgvReservas.Columns[nameof(DetalleReserva.EstadoReserva)].HeaderText = "Estado";
        }

        private void btnActualizar_Click(object sender, EventArgs e)
        {
            RefrescarGrilla();
        }

        private void cboFuncion_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!IsHandleCreated || cboFuncion.SelectedIndex < 0)
                return;

            CargarButacas();
        }

        private void btnCrearReserva_Click(object sender, EventArgs e)
        {
            if (!(cboUsuario.SelectedValue is long idUsuario) || idUsuario <= 0)
            {
                MessageBox.Show("Seleccione un usuario.", "Nueva reserva",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                cboUsuario.Focus();
                return;
            }

            if (!(cboFuncion.SelectedValue is long idFuncion) || idFuncion <= 0)
            {
                MessageBox.Show("Seleccione una función.", "Nueva reserva",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                cboFuncion.Focus();
                return;
            }

            if (!(cboButaca.SelectedValue is long idButaca) || idButaca <= 0)
            {
                MessageBox.Show("Seleccione una butaca libre.", "Nueva reserva",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                cboButaca.Focus();
                return;
            }

            try
            {
                negocio.CrearReserva(idUsuario, idFuncion, idButaca);
                MessageBox.Show("Reserva registrada correctamente.", "Nueva reserva",
                    MessageBoxButtons.OK, MessageBoxIcon.Information);
                CargarButacas();
                RefrescarGrilla();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Nueva reserva",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
    }
}
