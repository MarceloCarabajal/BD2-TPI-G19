namespace AppPeliculas
{
    partial class frmFunciones
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
            this.dgvFunciones = new System.Windows.Forms.DataGridView();
            this.panelListadoFooter = new System.Windows.Forms.Panel();
            this.btnActualizar = new System.Windows.Forms.Button();
            this.panelAcciones = new System.Windows.Forms.Panel();
            this.grpCrear = new System.Windows.Forms.GroupBox();
            this.btnCrearFuncion = new System.Windows.Forms.Button();
            this.txtPrecioBase = new System.Windows.Forms.TextBox();
            this.lblPrecioBase = new System.Windows.Forms.Label();
            this.dtpFechaHora = new System.Windows.Forms.DateTimePicker();
            this.lblFechaHora = new System.Windows.Forms.Label();
            this.cboSala = new System.Windows.Forms.ComboBox();
            this.lblSala = new System.Windows.Forms.Label();
            this.cboPelicula = new System.Windows.Forms.ComboBox();
            this.lblPelicula = new System.Windows.Forms.Label();
            this.grpListado.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvFunciones)).BeginInit();
            this.panelListadoFooter.SuspendLayout();
            this.panelAcciones.SuspendLayout();
            this.grpCrear.SuspendLayout();
            this.SuspendLayout();
            // 
            // grpListado
            // 
            this.grpListado.Controls.Add(this.dgvFunciones);
            this.grpListado.Controls.Add(this.panelListadoFooter);
            this.grpListado.Dock = System.Windows.Forms.DockStyle.Fill;
            this.grpListado.Location = new System.Drawing.Point(12, 12);
            this.grpListado.Name = "grpListado";
            this.grpListado.Padding = new System.Windows.Forms.Padding(10);
            this.grpListado.Size = new System.Drawing.Size(960, 320);
            this.grpListado.TabIndex = 0;
            this.grpListado.TabStop = false;
            this.grpListado.Text = "Funciones (vw_FuncionesCompleto)";
            // 
            // dgvFunciones
            // 
            this.dgvFunciones.BackgroundColor = System.Drawing.SystemColors.Window;
            this.dgvFunciones.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.dgvFunciones.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvFunciones.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgvFunciones.Location = new System.Drawing.Point(10, 23);
            this.dgvFunciones.Name = "dgvFunciones";
            this.dgvFunciones.RowHeadersVisible = false;
            this.dgvFunciones.Size = new System.Drawing.Size(940, 252);
            this.dgvFunciones.TabIndex = 0;
            // 
            // panelListadoFooter
            // 
            this.panelListadoFooter.Controls.Add(this.btnActualizar);
            this.panelListadoFooter.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.panelListadoFooter.Location = new System.Drawing.Point(10, 275);
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
            this.panelAcciones.Controls.Add(this.grpCrear);
            this.panelAcciones.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.panelAcciones.Location = new System.Drawing.Point(12, 332);
            this.panelAcciones.Name = "panelAcciones";
            this.panelAcciones.Size = new System.Drawing.Size(960, 140);
            this.panelAcciones.TabIndex = 1;
            // 
            // grpCrear
            // 
            this.grpCrear.Controls.Add(this.btnCrearFuncion);
            this.grpCrear.Controls.Add(this.txtPrecioBase);
            this.grpCrear.Controls.Add(this.lblPrecioBase);
            this.grpCrear.Controls.Add(this.dtpFechaHora);
            this.grpCrear.Controls.Add(this.lblFechaHora);
            this.grpCrear.Controls.Add(this.cboSala);
            this.grpCrear.Controls.Add(this.lblSala);
            this.grpCrear.Controls.Add(this.cboPelicula);
            this.grpCrear.Controls.Add(this.lblPelicula);
            this.grpCrear.Dock = System.Windows.Forms.DockStyle.Fill;
            this.grpCrear.Location = new System.Drawing.Point(0, 0);
            this.grpCrear.Name = "grpCrear";
            this.grpCrear.Padding = new System.Windows.Forms.Padding(12);
            this.grpCrear.Size = new System.Drawing.Size(960, 140);
            this.grpCrear.TabIndex = 0;
            this.grpCrear.TabStop = false;
            this.grpCrear.Text = "Crear función (sp_CrearFuncion)";
            // 
            // btnCrearFuncion
            // 
            this.btnCrearFuncion.Location = new System.Drawing.Point(15, 96);
            this.btnCrearFuncion.Name = "btnCrearFuncion";
            this.btnCrearFuncion.Size = new System.Drawing.Size(140, 30);
            this.btnCrearFuncion.TabIndex = 8;
            this.btnCrearFuncion.Text = "Crear función";
            this.btnCrearFuncion.UseVisualStyleBackColor = true;
            this.btnCrearFuncion.Click += new System.EventHandler(this.btnCrearFuncion_Click);
            // 
            // txtPrecioBase
            // 
            this.txtPrecioBase.Location = new System.Drawing.Point(680, 52);
            this.txtPrecioBase.Name = "txtPrecioBase";
            this.txtPrecioBase.Size = new System.Drawing.Size(140, 20);
            this.txtPrecioBase.TabIndex = 7;
            // 
            // lblPrecioBase
            // 
            this.lblPrecioBase.AutoSize = true;
            this.lblPrecioBase.Location = new System.Drawing.Point(677, 32);
            this.lblPrecioBase.Name = "lblPrecioBase";
            this.lblPrecioBase.Size = new System.Drawing.Size(64, 13);
            this.lblPrecioBase.TabIndex = 6;
            this.lblPrecioBase.Text = "Precio base";
            // 
            // dtpFechaHora
            // 
            this.dtpFechaHora.CustomFormat = "dd/MM/yyyy HH:mm";
            this.dtpFechaHora.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.dtpFechaHora.Location = new System.Drawing.Point(430, 52);
            this.dtpFechaHora.Name = "dtpFechaHora";
            this.dtpFechaHora.Size = new System.Drawing.Size(220, 20);
            this.dtpFechaHora.TabIndex = 5;
            // 
            // lblFechaHora
            // 
            this.lblFechaHora.AutoSize = true;
            this.lblFechaHora.Location = new System.Drawing.Point(427, 32);
            this.lblFechaHora.Name = "lblFechaHora";
            this.lblFechaHora.Size = new System.Drawing.Size(63, 13);
            this.lblFechaHora.TabIndex = 4;
            this.lblFechaHora.Text = "Fecha/hora";
            // 
            // cboSala
            // 
            this.cboSala.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cboSala.DropDownWidth = 320;
            this.cboSala.FormattingEnabled = true;
            this.cboSala.Location = new System.Drawing.Point(248, 52);
            this.cboSala.Name = "cboSala";
            this.cboSala.Size = new System.Drawing.Size(170, 21);
            this.cboSala.TabIndex = 3;
            // 
            // lblSala
            // 
            this.lblSala.AutoSize = true;
            this.lblSala.Location = new System.Drawing.Point(245, 32);
            this.lblSala.Name = "lblSala";
            this.lblSala.Size = new System.Drawing.Size(28, 13);
            this.lblSala.TabIndex = 2;
            this.lblSala.Text = "Sala";
            // 
            // cboPelicula
            // 
            this.cboPelicula.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cboPelicula.FormattingEnabled = true;
            this.cboPelicula.Location = new System.Drawing.Point(15, 52);
            this.cboPelicula.Name = "cboPelicula";
            this.cboPelicula.Size = new System.Drawing.Size(210, 21);
            this.cboPelicula.TabIndex = 1;
            // 
            // lblPelicula
            // 
            this.lblPelicula.AutoSize = true;
            this.lblPelicula.Location = new System.Drawing.Point(12, 32);
            this.lblPelicula.Name = "lblPelicula";
            this.lblPelicula.Size = new System.Drawing.Size(46, 13);
            this.lblPelicula.TabIndex = 0;
            this.lblPelicula.Text = "Película";
            // 
            // frmFunciones
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(984, 484);
            this.Controls.Add(this.grpListado);
            this.Controls.Add(this.panelAcciones);
            this.MinimumSize = new System.Drawing.Size(1000, 520);
            this.Name = "frmFunciones";
            this.Padding = new System.Windows.Forms.Padding(12);
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Módulo Funciones — BD2-TPI-G19";
            this.grpListado.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvFunciones)).EndInit();
            this.panelListadoFooter.ResumeLayout(false);
            this.panelAcciones.ResumeLayout(false);
            this.grpCrear.ResumeLayout(false);
            this.grpCrear.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox grpListado;
        private System.Windows.Forms.DataGridView dgvFunciones;
        private System.Windows.Forms.Panel panelListadoFooter;
        private System.Windows.Forms.Button btnActualizar;
        private System.Windows.Forms.Panel panelAcciones;
        private System.Windows.Forms.GroupBox grpCrear;
        private System.Windows.Forms.ComboBox cboPelicula;
        private System.Windows.Forms.Label lblPelicula;
        private System.Windows.Forms.ComboBox cboSala;
        private System.Windows.Forms.Label lblSala;
        private System.Windows.Forms.DateTimePicker dtpFechaHora;
        private System.Windows.Forms.Label lblFechaHora;
        private System.Windows.Forms.TextBox txtPrecioBase;
        private System.Windows.Forms.Label lblPrecioBase;
        private System.Windows.Forms.Button btnCrearFuncion;
    }
}
