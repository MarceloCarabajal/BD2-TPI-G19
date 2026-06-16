namespace AppPeliculas
{
    partial class frmPagos
    {
        private System.ComponentModel.IContainer components = null;

        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        private void InitializeComponent()
        {
            this.grpListado = new System.Windows.Forms.GroupBox();
            this.dgvPagos = new System.Windows.Forms.DataGridView();
            this.panelListadoFooter = new System.Windows.Forms.Panel();
            this.btnActualizar = new System.Windows.Forms.Button();
            this.panelAcciones = new System.Windows.Forms.Panel();
            this.grpCancelar = new System.Windows.Forms.GroupBox();
            this.btnCancelarReserva = new System.Windows.Forms.Button();
            this.txtIdReservaCancelar = new System.Windows.Forms.TextBox();
            this.lblIdReservaCancelar = new System.Windows.Forms.Label();
            this.grpRegistrar = new System.Windows.Forms.GroupBox();
            this.btnRegistrarPago = new System.Windows.Forms.Button();
            this.txtMonto = new System.Windows.Forms.TextBox();
            this.lblMonto = new System.Windows.Forms.Label();
            this.cboMetodoPago = new System.Windows.Forms.ComboBox();
            this.lblMetodoPago = new System.Windows.Forms.Label();
            this.txtIdReservaPago = new System.Windows.Forms.TextBox();
            this.lblIdReservaPago = new System.Windows.Forms.Label();
            this.grpListado.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvPagos)).BeginInit();
            this.panelListadoFooter.SuspendLayout();
            this.panelAcciones.SuspendLayout();
            this.grpCancelar.SuspendLayout();
            this.grpRegistrar.SuspendLayout();
            this.SuspendLayout();
            // 
            // grpListado
            // 
            this.grpListado.Controls.Add(this.dgvPagos);
            this.grpListado.Controls.Add(this.panelListadoFooter);
            this.grpListado.Dock = System.Windows.Forms.DockStyle.Fill;
            this.grpListado.Location = new System.Drawing.Point(12, 12);
            this.grpListado.Name = "grpListado";
            this.grpListado.Padding = new System.Windows.Forms.Padding(10);
            this.grpListado.Size = new System.Drawing.Size(860, 320);
            this.grpListado.TabIndex = 0;
            this.grpListado.TabStop = false;
            this.grpListado.Text = "Pagos aprobados (vw_PagosAprobados)";
            // 
            // dgvPagos
            // 
            this.dgvPagos.BackgroundColor = System.Drawing.SystemColors.Window;
            this.dgvPagos.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.dgvPagos.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvPagos.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgvPagos.Location = new System.Drawing.Point(10, 23);
            this.dgvPagos.Name = "dgvPagos";
            this.dgvPagos.RowHeadersVisible = false;
            this.dgvPagos.Size = new System.Drawing.Size(840, 252);
            this.dgvPagos.TabIndex = 0;
            // 
            // panelListadoFooter
            // 
            this.panelListadoFooter.Controls.Add(this.btnActualizar);
            this.panelListadoFooter.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.panelListadoFooter.Location = new System.Drawing.Point(10, 275);
            this.panelListadoFooter.Name = "panelListadoFooter";
            this.panelListadoFooter.Padding = new System.Windows.Forms.Padding(0, 8, 0, 0);
            this.panelListadoFooter.Size = new System.Drawing.Size(840, 35);
            this.panelListadoFooter.TabIndex = 1;
            // 
            // btnActualizar
            // 
            this.btnActualizar.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnActualizar.Location = new System.Drawing.Point(714, 8);
            this.btnActualizar.Name = "btnActualizar";
            this.btnActualizar.Size = new System.Drawing.Size(126, 27);
            this.btnActualizar.TabIndex = 0;
            this.btnActualizar.Text = "Actualizar listado";
            this.btnActualizar.UseVisualStyleBackColor = true;
            this.btnActualizar.Click += new System.EventHandler(this.btnActualizar_Click);
            // 
            // panelAcciones
            // 
            this.panelAcciones.Controls.Add(this.grpCancelar);
            this.panelAcciones.Controls.Add(this.grpRegistrar);
            this.panelAcciones.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.panelAcciones.Location = new System.Drawing.Point(12, 332);
            this.panelAcciones.Name = "panelAcciones";
            this.panelAcciones.Size = new System.Drawing.Size(860, 168);
            this.panelAcciones.TabIndex = 1;
            // 
            // grpCancelar
            // 
            this.grpCancelar.Controls.Add(this.btnCancelarReserva);
            this.grpCancelar.Controls.Add(this.txtIdReservaCancelar);
            this.grpCancelar.Controls.Add(this.lblIdReservaCancelar);
            this.grpCancelar.Dock = System.Windows.Forms.DockStyle.Right;
            this.grpCancelar.Location = new System.Drawing.Point(436, 0);
            this.grpCancelar.Name = "grpCancelar";
            this.grpCancelar.Padding = new System.Windows.Forms.Padding(12);
            this.grpCancelar.Size = new System.Drawing.Size(424, 168);
            this.grpCancelar.TabIndex = 1;
            this.grpCancelar.TabStop = false;
            this.grpCancelar.Text = "Cancelar reserva";
            // 
            // btnCancelarReserva
            // 
            this.btnCancelarReserva.Location = new System.Drawing.Point(15, 88);
            this.btnCancelarReserva.Name = "btnCancelarReserva";
            this.btnCancelarReserva.Size = new System.Drawing.Size(140, 30);
            this.btnCancelarReserva.TabIndex = 2;
            this.btnCancelarReserva.Text = "Cancelar reserva";
            this.btnCancelarReserva.UseVisualStyleBackColor = true;
            this.btnCancelarReserva.Click += new System.EventHandler(this.btnCancelarReserva_Click);
            // 
            // txtIdReservaCancelar
            // 
            this.txtIdReservaCancelar.Location = new System.Drawing.Point(15, 52);
            this.txtIdReservaCancelar.Name = "txtIdReservaCancelar";
            this.txtIdReservaCancelar.Size = new System.Drawing.Size(140, 20);
            this.txtIdReservaCancelar.TabIndex = 1;
            // 
            // lblIdReservaCancelar
            // 
            this.lblIdReservaCancelar.AutoSize = true;
            this.lblIdReservaCancelar.Location = new System.Drawing.Point(12, 32);
            this.lblIdReservaCancelar.Name = "lblIdReservaCancelar";
            this.lblIdReservaCancelar.Size = new System.Drawing.Size(68, 13);
            this.lblIdReservaCancelar.TabIndex = 0;
            this.lblIdReservaCancelar.Text = "Id de reserva";
            // 
            // grpRegistrar
            // 
            this.grpRegistrar.Controls.Add(this.btnRegistrarPago);
            this.grpRegistrar.Controls.Add(this.txtMonto);
            this.grpRegistrar.Controls.Add(this.lblMonto);
            this.grpRegistrar.Controls.Add(this.cboMetodoPago);
            this.grpRegistrar.Controls.Add(this.lblMetodoPago);
            this.grpRegistrar.Controls.Add(this.txtIdReservaPago);
            this.grpRegistrar.Controls.Add(this.lblIdReservaPago);
            this.grpRegistrar.Dock = System.Windows.Forms.DockStyle.Left;
            this.grpRegistrar.Location = new System.Drawing.Point(0, 0);
            this.grpRegistrar.Name = "grpRegistrar";
            this.grpRegistrar.Padding = new System.Windows.Forms.Padding(12);
            this.grpRegistrar.Size = new System.Drawing.Size(424, 168);
            this.grpRegistrar.TabIndex = 0;
            this.grpRegistrar.TabStop = false;
            this.grpRegistrar.Text = "Registrar pago";
            // 
            // btnRegistrarPago
            // 
            this.btnRegistrarPago.Location = new System.Drawing.Point(15, 124);
            this.btnRegistrarPago.Name = "btnRegistrarPago";
            this.btnRegistrarPago.Size = new System.Drawing.Size(140, 30);
            this.btnRegistrarPago.TabIndex = 6;
            this.btnRegistrarPago.Text = "Registrar pago";
            this.btnRegistrarPago.UseVisualStyleBackColor = true;
            this.btnRegistrarPago.Click += new System.EventHandler(this.btnRegistrarPago_Click);
            // 
            // txtMonto
            // 
            this.txtMonto.Location = new System.Drawing.Point(248, 52);
            this.txtMonto.Name = "txtMonto";
            this.txtMonto.Size = new System.Drawing.Size(140, 20);
            this.txtMonto.TabIndex = 5;
            // 
            // lblMonto
            // 
            this.lblMonto.AutoSize = true;
            this.lblMonto.Location = new System.Drawing.Point(245, 32);
            this.lblMonto.Name = "lblMonto";
            this.lblMonto.Size = new System.Drawing.Size(37, 13);
            this.lblMonto.TabIndex = 4;
            this.lblMonto.Text = "Monto";
            // 
            // cboMetodoPago
            // 
            this.cboMetodoPago.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cboMetodoPago.FormattingEnabled = true;
            this.cboMetodoPago.Location = new System.Drawing.Point(15, 88);
            this.cboMetodoPago.Name = "cboMetodoPago";
            this.cboMetodoPago.Size = new System.Drawing.Size(373, 21);
            this.cboMetodoPago.TabIndex = 3;
            // 
            // lblMetodoPago
            // 
            this.lblMetodoPago.AutoSize = true;
            this.lblMetodoPago.Location = new System.Drawing.Point(12, 72);
            this.lblMetodoPago.Name = "lblMetodoPago";
            this.lblMetodoPago.Size = new System.Drawing.Size(86, 13);
            this.lblMetodoPago.TabIndex = 2;
            this.lblMetodoPago.Text = "Método de pago";
            // 
            // txtIdReservaPago
            // 
            this.txtIdReservaPago.Location = new System.Drawing.Point(15, 52);
            this.txtIdReservaPago.Name = "txtIdReservaPago";
            this.txtIdReservaPago.Size = new System.Drawing.Size(140, 20);
            this.txtIdReservaPago.TabIndex = 1;
            // 
            // lblIdReservaPago
            // 
            this.lblIdReservaPago.AutoSize = true;
            this.lblIdReservaPago.Location = new System.Drawing.Point(12, 32);
            this.lblIdReservaPago.Name = "lblIdReservaPago";
            this.lblIdReservaPago.Size = new System.Drawing.Size(68, 13);
            this.lblIdReservaPago.TabIndex = 0;
            this.lblIdReservaPago.Text = "Id de reserva";
            // 
            // frmPagos
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(884, 512);
            this.Controls.Add(this.grpListado);
            this.Controls.Add(this.panelAcciones);
            this.MinimumSize = new System.Drawing.Size(900, 550);
            this.Name = "frmPagos";
            this.Padding = new System.Windows.Forms.Padding(12);
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Módulo Pagos — BD2-TPI-G19";
            this.grpListado.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvPagos)).EndInit();
            this.panelListadoFooter.ResumeLayout(false);
            this.panelAcciones.ResumeLayout(false);
            this.grpCancelar.ResumeLayout(false);
            this.grpCancelar.PerformLayout();
            this.grpRegistrar.ResumeLayout(false);
            this.grpRegistrar.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox grpListado;
        private System.Windows.Forms.DataGridView dgvPagos;
        private System.Windows.Forms.Panel panelListadoFooter;
        private System.Windows.Forms.Button btnActualizar;
        private System.Windows.Forms.Panel panelAcciones;
        private System.Windows.Forms.GroupBox grpRegistrar;
        private System.Windows.Forms.TextBox txtIdReservaPago;
        private System.Windows.Forms.Label lblIdReservaPago;
        private System.Windows.Forms.ComboBox cboMetodoPago;
        private System.Windows.Forms.Label lblMetodoPago;
        private System.Windows.Forms.TextBox txtMonto;
        private System.Windows.Forms.Label lblMonto;
        private System.Windows.Forms.Button btnRegistrarPago;
        private System.Windows.Forms.GroupBox grpCancelar;
        private System.Windows.Forms.TextBox txtIdReservaCancelar;
        private System.Windows.Forms.Label lblIdReservaCancelar;
        private System.Windows.Forms.Button btnCancelarReserva;
    }
}
