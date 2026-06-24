namespace AppPeliculas
{
    partial class frmReservas
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
            this.dgvReservas = new System.Windows.Forms.DataGridView();
            this.panelListadoFooter = new System.Windows.Forms.Panel();
            this.btnActualizar = new System.Windows.Forms.Button();
            this.panelAcciones = new System.Windows.Forms.Panel();
            this.grpNuevaReserva = new System.Windows.Forms.GroupBox();
            this.btnCrearReserva = new System.Windows.Forms.Button();
            this.cboButaca = new System.Windows.Forms.ComboBox();
            this.lblButaca = new System.Windows.Forms.Label();
            this.cboFuncion = new System.Windows.Forms.ComboBox();
            this.lblFuncion = new System.Windows.Forms.Label();
            this.cboUsuario = new System.Windows.Forms.ComboBox();
            this.lblUsuario = new System.Windows.Forms.Label();
            this.grpListado.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvReservas)).BeginInit();
            this.panelListadoFooter.SuspendLayout();
            this.panelAcciones.SuspendLayout();
            this.grpNuevaReserva.SuspendLayout();
            this.SuspendLayout();
            // 
            // grpListado
            // 
            this.grpListado.Controls.Add(this.dgvReservas);
            this.grpListado.Controls.Add(this.panelListadoFooter);
            this.grpListado.Dock = System.Windows.Forms.DockStyle.Fill;
            this.grpListado.Location = new System.Drawing.Point(12, 12);
            this.grpListado.Name = "grpListado";
            this.grpListado.Padding = new System.Windows.Forms.Padding(10);
            this.grpListado.Size = new System.Drawing.Size(960, 340);
            this.grpListado.TabIndex = 0;
            this.grpListado.TabStop = false;
            this.grpListado.Text = "Detalle de reservas (vw_DetalleReservasCompleto)";
            // 
            // dgvReservas
            // 
            this.dgvReservas.BackgroundColor = System.Drawing.SystemColors.Window;
            this.dgvReservas.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.dgvReservas.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvReservas.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgvReservas.Location = new System.Drawing.Point(10, 23);
            this.dgvReservas.Name = "dgvReservas";
            this.dgvReservas.RowHeadersVisible = false;
            this.dgvReservas.Size = new System.Drawing.Size(940, 272);
            this.dgvReservas.TabIndex = 0;
            // 
            // panelListadoFooter
            // 
            this.panelListadoFooter.Controls.Add(this.btnActualizar);
            this.panelListadoFooter.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.panelListadoFooter.Location = new System.Drawing.Point(10, 295);
            this.panelListadoFooter.Name = "panelListadoFooter";
            this.panelListadoFooter.Padding = new System.Windows.Forms.Padding(0, 8, 0, 0);
            this.panelListadoFooter.Size = new System.Drawing.Size(940, 35);
            this.panelListadoFooter.TabIndex = 1;
            // 
            // btnActualizar
            // 
            this.btnActualizar.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnActualizar.Location = new System.Drawing.Point(814, 8);
            this.btnActualizar.Name = "btnActualizar";
            this.btnActualizar.Size = new System.Drawing.Size(126, 27);
            this.btnActualizar.TabIndex = 0;
            this.btnActualizar.Text = "Actualizar listado";
            this.btnActualizar.UseVisualStyleBackColor = true;
            this.btnActualizar.Click += new System.EventHandler(this.btnActualizar_Click);
            // 
            // panelAcciones
            // 
            this.panelAcciones.Controls.Add(this.grpNuevaReserva);
            this.panelAcciones.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.panelAcciones.Location = new System.Drawing.Point(12, 352);
            this.panelAcciones.Name = "panelAcciones";
            this.panelAcciones.Size = new System.Drawing.Size(960, 176);
            this.panelAcciones.TabIndex = 1;
            // 
            // grpNuevaReserva
            // 
            this.grpNuevaReserva.Controls.Add(this.btnCrearReserva);
            this.grpNuevaReserva.Controls.Add(this.cboButaca);
            this.grpNuevaReserva.Controls.Add(this.lblButaca);
            this.grpNuevaReserva.Controls.Add(this.cboFuncion);
            this.grpNuevaReserva.Controls.Add(this.lblFuncion);
            this.grpNuevaReserva.Controls.Add(this.cboUsuario);
            this.grpNuevaReserva.Controls.Add(this.lblUsuario);
            this.grpNuevaReserva.Dock = System.Windows.Forms.DockStyle.Fill;
            this.grpNuevaReserva.Location = new System.Drawing.Point(0, 0);
            this.grpNuevaReserva.Name = "grpNuevaReserva";
            this.grpNuevaReserva.Padding = new System.Windows.Forms.Padding(12);
            this.grpNuevaReserva.Size = new System.Drawing.Size(960, 176);
            this.grpNuevaReserva.TabIndex = 0;
            this.grpNuevaReserva.TabStop = false;
            this.grpNuevaReserva.Text = "Nueva reserva (sp_CrearReservaConDetalle)";
            // 
            // cboUsuario
            // 
            this.cboUsuario.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cboUsuario.FormattingEnabled = true;
            this.cboUsuario.Location = new System.Drawing.Point(15, 36);
            this.cboUsuario.Name = "cboUsuario";
            this.cboUsuario.Size = new System.Drawing.Size(920, 21);
            this.cboUsuario.TabIndex = 1;
            // 
            // lblUsuario
            // 
            this.lblUsuario.AutoSize = true;
            this.lblUsuario.Location = new System.Drawing.Point(12, 20);
            this.lblUsuario.Name = "lblUsuario";
            this.lblUsuario.Size = new System.Drawing.Size(43, 13);
            this.lblUsuario.TabIndex = 0;
            this.lblUsuario.Text = "Usuario";
            // 
            // cboFuncion
            // 
            this.cboFuncion.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cboFuncion.FormattingEnabled = true;
            this.cboFuncion.Location = new System.Drawing.Point(15, 76);
            this.cboFuncion.Name = "cboFuncion";
            this.cboFuncion.Size = new System.Drawing.Size(920, 21);
            this.cboFuncion.TabIndex = 3;
            this.cboFuncion.SelectedIndexChanged += new System.EventHandler(this.cboFuncion_SelectedIndexChanged);
            // 
            // lblFuncion
            // 
            this.lblFuncion.AutoSize = true;
            this.lblFuncion.Location = new System.Drawing.Point(12, 60);
            this.lblFuncion.Name = "lblFuncion";
            this.lblFuncion.Size = new System.Drawing.Size(48, 13);
            this.lblFuncion.TabIndex = 2;
            this.lblFuncion.Text = "Función";
            // 
            // cboButaca
            // 
            this.cboButaca.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cboButaca.FormattingEnabled = true;
            this.cboButaca.Location = new System.Drawing.Point(15, 116);
            this.cboButaca.Name = "cboButaca";
            this.cboButaca.Size = new System.Drawing.Size(920, 21);
            this.cboButaca.TabIndex = 5;
            // 
            // lblButaca
            // 
            this.lblButaca.AutoSize = true;
            this.lblButaca.Location = new System.Drawing.Point(12, 100);
            this.lblButaca.Name = "lblButaca";
            this.lblButaca.Size = new System.Drawing.Size(68, 13);
            this.lblButaca.TabIndex = 4;
            this.lblButaca.Text = "Butaca libre";
            // 
            // btnCrearReserva
            // 
            this.btnCrearReserva.Location = new System.Drawing.Point(15, 144);
            this.btnCrearReserva.Name = "btnCrearReserva";
            this.btnCrearReserva.Size = new System.Drawing.Size(140, 30);
            this.btnCrearReserva.TabIndex = 6;
            this.btnCrearReserva.Text = "Crear reserva";
            this.btnCrearReserva.UseVisualStyleBackColor = true;
            this.btnCrearReserva.Click += new System.EventHandler(this.btnCrearReserva_Click);
            // 
            // frmReservas
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(984, 540);
            this.Controls.Add(this.grpListado);
            this.Controls.Add(this.panelAcciones);
            this.MinimumSize = new System.Drawing.Size(1000, 580);
            this.Name = "frmReservas";
            this.Padding = new System.Windows.Forms.Padding(12);
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Módulo Reservas — BD2-TPI-G19";
            this.grpListado.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvReservas)).EndInit();
            this.panelListadoFooter.ResumeLayout(false);
            this.panelAcciones.ResumeLayout(false);
            this.grpNuevaReserva.ResumeLayout(false);
            this.grpNuevaReserva.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox grpListado;
        private System.Windows.Forms.DataGridView dgvReservas;
        private System.Windows.Forms.Panel panelListadoFooter;
        private System.Windows.Forms.Button btnActualizar;
        private System.Windows.Forms.Panel panelAcciones;
        private System.Windows.Forms.GroupBox grpNuevaReserva;
        private System.Windows.Forms.Label lblUsuario;
        private System.Windows.Forms.ComboBox cboUsuario;
        private System.Windows.Forms.Label lblFuncion;
        private System.Windows.Forms.ComboBox cboFuncion;
        private System.Windows.Forms.Label lblButaca;
        private System.Windows.Forms.ComboBox cboButaca;
        private System.Windows.Forms.Button btnCrearReserva;
    }
}
