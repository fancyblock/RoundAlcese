using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace MapEditor
{
    public partial class MainEditor : Form
    {
        private Bitmap backgroundBuff = null;
        private MapData mMapData;
        private string openFileName;

        public MainEditor()
        {
            InitializeComponent();

            mMapData = new MapData();
            propertyGrid1.SelectedObject = mMapData;

            openFileName = "";
        }

        private void updateScene()
        {
            if (backgroundBuff == null || backgroundBuff.Size.Width != mMapData.PixelSize.Width || backgroundBuff.Size.Height != mMapData.PixelSize.Height)
            {
                backgroundBuff = new Bitmap(mMapData.PixelSize.Width, mMapData.PixelSize.Height);
                pictureBox1.Size = new Size(mMapData.PixelSize.Width, mMapData.PixelSize.Height);
            }

            Graphics buff = Graphics.FromImage(backgroundBuff);

            // 刷背景
            buff.Clear(Color.FromArgb(0, 0, 0, 0));

            for (int x = 0; x < mMapData.PixelSize.Width; x += 40)
            {
                for (int y = 0; y < mMapData.PixelSize.Height; y += 40)
                {
                    SolidBrush mysbrush1 = new SolidBrush(Color.FromArgb(190, 190, 230));
                    buff.FillRectangle(mysbrush1, new Rectangle(x, y, 20, 20));
                    buff.FillRectangle(mysbrush1, new Rectangle(x + 20, y + 20, 20, 20));
                }
            }

            if (mMapData .Background != "")
            {
                string path = Application.StartupPath + "..\\assets\\Maps\\" + mMapData.Background;
                if (System.IO.File.Exists(path))
                {
                    Bitmap background = new Bitmap(path);
                    buff.DrawImage(background, mMapData.Origin.X, mMapData.Origin.Y, background.Width, background.Height);
                }
            }

            buff.Dispose();
            pictureBox1.Image = backgroundBuff;
        }

        private void MainEditor_Paint(object sender, PaintEventArgs e)
        {
            updateScene();
        }

        private void propertyGrid1_PropertyValueChanged(object s, PropertyValueChangedEventArgs e)
        {
            updateScene();
        }

        private void openToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                openFileName = openFileDialog1.FileName;
                mMapData.Load(openFileName);
                updateScene();
            }
        }

        private void saveAsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (saveFileDialog1.ShowDialog() == DialogResult.OK)
            {
                openFileName = saveFileDialog1.FileName;
                mMapData.Save(openFileName);
                updateScene();
            }
        }

        private void saveToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (openFileName == "")
            {
                if (saveFileDialog1.ShowDialog() == DialogResult.OK)
                {
                    openFileName = saveFileDialog1.FileName;
                    mMapData.Save(openFileName);
                    updateScene();
                }
            }
            else
            {
                mMapData.Save(openFileName);
                updateScene();
            }
        }

        private void newToolStripMenuItem_Click(object sender, EventArgs e)
        {
            mMapData = new MapData();
            propertyGrid1.SelectedObject = mMapData;

            openFileName = "";
        }

        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Really want to exit？", "System", MessageBoxButtons.YesNo, MessageBoxIcon.Information) == DialogResult.Yes)
                Application.Exit();
        }
    }
}
