using System;
using System.Windows.Forms;

namespace AppPeliculas
{
    public partial class frmPrincipal : Form
    {
        public frmPrincipal()
        {
            InitializeComponent();
        }

        private void salirToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void peliculasToolStripMenuItem_Click(object sender, EventArgs e)
        {
            using (var formulario = new frmPeliculas())
            {
                formulario.ShowDialog(this);
            }
        }

        private void funcionesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            using (var formulario = new frmFunciones())
            {
                formulario.ShowDialog(this);
            }
        }

        private void reservasToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MostrarProximamente("Reservas (Henry)");
        }

        private void pagosToolStripMenuItem_Click(object sender, EventArgs e)
        {
            using (var formulario = new frmPagos())
            {
                formulario.ShowDialog(this);
            }
        }

        private static void MostrarProximamente(string modulo)
        {
            MessageBox.Show(
                $"{modulo} estará disponible en una próxima versión.",
                "Próximamente",
                MessageBoxButtons.OK,
                MessageBoxIcon.Information);
        }
    }
}
