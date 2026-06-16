using System;
using System.Windows.Forms;
using Dominio;
using Negocio;

namespace AppPeliculas
{
    public partial class frmPagos : Form
    {
        private readonly PagoNegocio negocio = new PagoNegocio();

        public frmPagos()
        {
            InitializeComponent();
            Load += frmPagos_Load;
        }

        private void frmPagos_Load(object sender, EventArgs e)
        {
            CargarMetodosPago();
            RefrescarGrilla();
        }

        private void CargarMetodosPago()
        {
            try
            {
                cboMetodoPago.DataSource = negocio.ListarMetodosPago();
                cboMetodoPago.DisplayMember = "Nombre";
                cboMetodoPago.ValueMember = "IdMetodoPago";
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al cargar métodos de pago: " + ex.Message, "Pagos",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void RefrescarGrilla()
        {
            try
            {
                dgvPagos.DataSource = null;
                dgvPagos.DataSource = negocio.ListarPagosAprobados();
                ConfigurarGrilla();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al cargar pagos: " + ex.Message, "Pagos",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void ConfigurarGrilla()
        {
            if (dgvPagos.Columns.Count == 0)
                return;

            dgvPagos.ReadOnly = true;
            dgvPagos.AllowUserToAddRows = false;
            dgvPagos.AllowUserToDeleteRows = false;
            dgvPagos.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgvPagos.MultiSelect = false;
            dgvPagos.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;

            dgvPagos.Columns[nameof(Pago.IdPago)].HeaderText = "Id pago";
            dgvPagos.Columns[nameof(Pago.IdReserva)].HeaderText = "Id reserva";
            dgvPagos.Columns[nameof(Pago.MetodoPago)].HeaderText = "Método";
            dgvPagos.Columns[nameof(Pago.TotalPagado)].HeaderText = "Total";
            dgvPagos.Columns[nameof(Pago.TotalPagado)].DefaultCellStyle.Format = "C2";
            dgvPagos.Columns[nameof(Pago.FechaPago)].HeaderText = "Fecha";
            dgvPagos.Columns[nameof(Pago.FechaPago)].DefaultCellStyle.Format = "g";
            dgvPagos.Columns[nameof(Pago.Email)].HeaderText = "Email";
            dgvPagos.Columns[nameof(Pago.EstadoReserva)].HeaderText = "Estado reserva";
        }

        private void btnActualizar_Click(object sender, EventArgs e)
        {
            RefrescarGrilla();
        }

        private void btnRegistrarPago_Click(object sender, EventArgs e)
        {
            if (!long.TryParse(txtIdReservaPago.Text.Trim(), out long idReserva) || idReserva <= 0)
            {
                MessageBox.Show("Ingrese un id de reserva válido.", "Registrar pago",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                txtIdReservaPago.Focus();
                return;
            }

            if (!(cboMetodoPago.SelectedValue is long idMetodo) || idMetodo <= 0)
            {
                MessageBox.Show("Seleccione un método de pago.", "Registrar pago",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                cboMetodoPago.Focus();
                return;
            }

            if (!decimal.TryParse(txtMonto.Text.Trim(), out decimal total) || total <= 0)
            {
                MessageBox.Show("Ingrese un monto mayor a cero.", "Registrar pago",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                txtMonto.Focus();
                return;
            }

            try
            {
                negocio.RegistrarPago(idReserva, idMetodo, total);
                MessageBox.Show("Pago registrado correctamente.", "Registrar pago",
                    MessageBoxButtons.OK, MessageBoxIcon.Information);
                txtIdReservaPago.Clear();
                txtMonto.Clear();
                RefrescarGrilla();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Registrar pago",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnCancelarReserva_Click(object sender, EventArgs e)
        {
            if (!long.TryParse(txtIdReservaCancelar.Text.Trim(), out long idReserva) || idReserva <= 0)
            {
                MessageBox.Show("Ingrese un id de reserva válido.", "Cancelar reserva",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                txtIdReservaCancelar.Focus();
                return;
            }

            var confirmar = MessageBox.Show(
                $"¿Cancelar la reserva {idReserva}?",
                "Cancelar reserva",
                MessageBoxButtons.YesNo,
                MessageBoxIcon.Question);

            if (confirmar != DialogResult.Yes)
                return;

            try
            {
                negocio.CancelarReserva(idReserva);
                MessageBox.Show("Reserva cancelada correctamente.", "Cancelar reserva",
                    MessageBoxButtons.OK, MessageBoxIcon.Information);
                txtIdReservaCancelar.Clear();
                RefrescarGrilla();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Cancelar reserva",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
    }
}
