namespace AppPeliculas
{
    partial class frmPeliculas
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
            this.dgvCartelera = new System.Windows.Forms.DataGridView();
            this.panelListadoFooter = new System.Windows.Forms.Panel();
            this.btnActualizar = new System.Windows.Forms.Button();
            this.panelAcciones = new System.Windows.Forms.Panel();
            this.grpInsertar = new System.Windows.Forms.GroupBox();
            this.btnInsertar = new System.Windows.Forms.Button();
            this.txtSinopsis = new System.Windows.Forms.TextBox();
            this.lblSinopsis = new System.Windows.Forms.Label();
            this.txtDuracion = new System.Windows.Forms.TextBox();
            this.lblDuracion = new System.Windows.Forms.Label();
            this.cboGenero = new System.Windows.Forms.ComboBox();
            this.lblGenero = new System.Windows.Forms.Label();
            this.cboClasificacion = new System.Windows.Forms.ComboBox();
            this.lblClasificacion = new System.Windows.Forms.Label();
            this.txtTitulo = new System.Windows.Forms.TextBox();
            this.lblTitulo = new System.Windows.Forms.Label();
            this.grpListado.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvCartelera)).BeginInit();
            this.panelListadoFooter.SuspendLayout();
            this.panelAcciones.SuspendLayout();
            this.grpInsertar.SuspendLayout();
            this.SuspendLayout();
            // 
            // grpListado
            // 
            this.grpListado.Controls.Add(this.dgvCartelera);
            this.grpListado.Controls.Add(this.panelListadoFooter);
            this.grpListado.Dock = System.Windows.Forms.DockStyle.Fill;
            this.grpListado.Location = new System.Drawing.Point(12, 12);
            this.grpListado.Name = "grpListado";
            this.grpListado.Padding = new System.Windows.Forms.Padding(10);
            this.grpListado.Size = new System.Drawing.Size(960, 320);
            this.grpListado.TabIndex = 0;
            this.grpListado.TabStop = false;
            this.grpListado.Text = "Cartelera — funciones en cartelera (vw_CarteleraPeliculas)";
            // 
            // dgvCartelera
            // 
            this.dgvCartelera.BackgroundColor = System.Drawing.SystemColors.Window;
            this.dgvCartelera.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.dgvCartelera.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvCartelera.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgvCartelera.Location = new System.Drawing.Point(10, 23);
            this.dgvCartelera.Name = "dgvCartelera";
            this.dgvCartelera.RowHeadersVisible = false;
            this.dgvCartelera.Size = new System.Drawing.Size(940, 252);
            this.dgvCartelera.TabIndex = 0;
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
            this.panelAcciones.Controls.Add(this.grpInsertar);
            this.panelAcciones.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.panelAcciones.Location = new System.Drawing.Point(12, 332);
            this.panelAcciones.Name = "panelAcciones";
            this.panelAcciones.Size = new System.Drawing.Size(960, 200);
            this.panelAcciones.TabIndex = 1;
            // 
            // grpInsertar
            // 
            this.grpInsertar.Controls.Add(this.btnInsertar);
            this.grpInsertar.Controls.Add(this.txtSinopsis);
            this.grpInsertar.Controls.Add(this.lblSinopsis);
            this.grpInsertar.Controls.Add(this.txtDuracion);
            this.grpInsertar.Controls.Add(this.lblDuracion);
            this.grpInsertar.Controls.Add(this.cboGenero);
            this.grpInsertar.Controls.Add(this.lblGenero);
            this.grpInsertar.Controls.Add(this.cboClasificacion);
            this.grpInsertar.Controls.Add(this.lblClasificacion);
            this.grpInsertar.Controls.Add(this.txtTitulo);
            this.grpInsertar.Controls.Add(this.lblTitulo);
            this.grpInsertar.Dock = System.Windows.Forms.DockStyle.Fill;
            this.grpInsertar.Location = new System.Drawing.Point(0, 0);
            this.grpInsertar.Name = "grpInsertar";
            this.grpInsertar.Padding = new System.Windows.Forms.Padding(12);
            this.grpInsertar.Size = new System.Drawing.Size(960, 200);
            this.grpInsertar.TabIndex = 0;
            this.grpInsertar.TabStop = false;
            this.grpInsertar.Text = "Insertar película (sp_InsertarPelicula)";
            // 
            // btnInsertar
            // 
            this.btnInsertar.Location = new System.Drawing.Point(15, 156);
            this.btnInsertar.Name = "btnInsertar";
            this.btnInsertar.Size = new System.Drawing.Size(140, 30);
            this.btnInsertar.TabIndex = 10;
            this.btnInsertar.Text = "Insertar película";
            this.btnInsertar.UseVisualStyleBackColor = true;
            this.btnInsertar.Click += new System.EventHandler(this.btnInsertar_Click);
            // 
            // txtSinopsis
            // 
            this.txtSinopsis.Location = new System.Drawing.Point(430, 52);
            this.txtSinopsis.Multiline = true;
            this.txtSinopsis.Name = "txtSinopsis";
            this.txtSinopsis.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.txtSinopsis.Size = new System.Drawing.Size(510, 80);
            this.txtSinopsis.TabIndex = 9;
            // 
            // lblSinopsis
            // 
            this.lblSinopsis.AutoSize = true;
            this.lblSinopsis.Location = new System.Drawing.Point(427, 32);
            this.lblSinopsis.Name = "lblSinopsis";
            this.lblSinopsis.Size = new System.Drawing.Size(47, 13);
            this.lblSinopsis.TabIndex = 8;
            this.lblSinopsis.Text = "Sinopsis";
            // 
            // txtDuracion
            // 
            this.txtDuracion.Location = new System.Drawing.Point(248, 112);
            this.txtDuracion.Name = "txtDuracion";
            this.txtDuracion.Size = new System.Drawing.Size(140, 20);
            this.txtDuracion.TabIndex = 7;
            // 
            // lblDuracion
            // 
            this.lblDuracion.AutoSize = true;
            this.lblDuracion.Location = new System.Drawing.Point(245, 92);
            this.lblDuracion.Name = "lblDuracion";
            this.lblDuracion.Size = new System.Drawing.Size(103, 13);
            this.lblDuracion.TabIndex = 6;
            this.lblDuracion.Text = "Duración (minutos)";
            // 
            // cboGenero
            // 
            this.cboGenero.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cboGenero.FormattingEnabled = true;
            this.cboGenero.Location = new System.Drawing.Point(15, 112);
            this.cboGenero.Name = "cboGenero";
            this.cboGenero.Size = new System.Drawing.Size(200, 21);
            this.cboGenero.TabIndex = 5;
            // 
            // lblGenero
            // 
            this.lblGenero.AutoSize = true;
            this.lblGenero.Location = new System.Drawing.Point(12, 92);
            this.lblGenero.Name = "lblGenero";
            this.lblGenero.Size = new System.Drawing.Size(42, 13);
            this.lblGenero.TabIndex = 4;
            this.lblGenero.Text = "Género";
            // 
            // cboClasificacion
            // 
            this.cboClasificacion.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cboClasificacion.FormattingEnabled = true;
            this.cboClasificacion.Location = new System.Drawing.Point(248, 52);
            this.cboClasificacion.Name = "cboClasificacion";
            this.cboClasificacion.Size = new System.Drawing.Size(140, 21);
            this.cboClasificacion.TabIndex = 3;
            // 
            // lblClasificacion
            // 
            this.lblClasificacion.AutoSize = true;
            this.lblClasificacion.Location = new System.Drawing.Point(245, 32);
            this.lblClasificacion.Name = "lblClasificacion";
            this.lblClasificacion.Size = new System.Drawing.Size(69, 13);
            this.lblClasificacion.TabIndex = 2;
            this.lblClasificacion.Text = "Clasificación";
            // 
            // txtTitulo
            // 
            this.txtTitulo.Location = new System.Drawing.Point(15, 52);
            this.txtTitulo.Name = "txtTitulo";
            this.txtTitulo.Size = new System.Drawing.Size(200, 20);
            this.txtTitulo.TabIndex = 1;
            // 
            // lblTitulo
            // 
            this.lblTitulo.AutoSize = true;
            this.lblTitulo.Location = new System.Drawing.Point(12, 32);
            this.lblTitulo.Name = "lblTitulo";
            this.lblTitulo.Size = new System.Drawing.Size(35, 13);
            this.lblTitulo.TabIndex = 0;
            this.lblTitulo.Text = "Título";
            // 
            // frmPeliculas
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(984, 544);
            this.Controls.Add(this.grpListado);
            this.Controls.Add(this.panelAcciones);
            this.MinimumSize = new System.Drawing.Size(1000, 580);
            this.Name = "frmPeliculas";
            this.Padding = new System.Windows.Forms.Padding(12);
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Módulo Películas — BD2-TPI-G19";
            this.grpListado.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvCartelera)).EndInit();
            this.panelListadoFooter.ResumeLayout(false);
            this.panelAcciones.ResumeLayout(false);
            this.grpInsertar.ResumeLayout(false);
            this.grpInsertar.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox grpListado;
        private System.Windows.Forms.DataGridView dgvCartelera;
        private System.Windows.Forms.Panel panelListadoFooter;
        private System.Windows.Forms.Button btnActualizar;
        private System.Windows.Forms.Panel panelAcciones;
        private System.Windows.Forms.GroupBox grpInsertar;
        private System.Windows.Forms.TextBox txtTitulo;
        private System.Windows.Forms.Label lblTitulo;
        private System.Windows.Forms.ComboBox cboClasificacion;
        private System.Windows.Forms.Label lblClasificacion;
        private System.Windows.Forms.ComboBox cboGenero;
        private System.Windows.Forms.Label lblGenero;
        private System.Windows.Forms.TextBox txtDuracion;
        private System.Windows.Forms.Label lblDuracion;
        private System.Windows.Forms.TextBox txtSinopsis;
        private System.Windows.Forms.Label lblSinopsis;
        private System.Windows.Forms.Button btnInsertar;
    }
}
