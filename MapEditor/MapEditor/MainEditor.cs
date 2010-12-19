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
        List<Point> selectRect = new List<Point>();

        const int RegionWidth = 74;
        const int RegionHeight = 37;
        const int HalfRegionWidth = 37;
        const int HalfRegionHeight = 18;

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
                    SolidBrush mysbrush1 = new SolidBrush(Color.FromArgb(230, 230, 255));
                    buff.FillRectangle(mysbrush1, new Rectangle(x, y, 20, 20));
                    buff.FillRectangle(mysbrush1, new Rectangle(x + 20, y + 20, 20, 20));
                }
            }

            if (mMapData .Background != "")
            {
                string path = Application.StartupPath + "\\..\\assets\\Maps\\" + mMapData.Background;
                if (System.IO.File.Exists(path))
                {
                    Bitmap background = new Bitmap(path);
                    buff.DrawImage(background, mMapData.Origin.X, mMapData.Origin.Y, background.Width, background.Height);
                }
            }

            // 刷地面
            Point offsetPosition = mMapData.RegionOrigin;
            Bitmap resImage = new Bitmap(Application.StartupPath + "\\..\\assets\\Maps\\back01.png");
            for (int x = 0; x < mMapData.Size.Width; x++)
            {
                for (int y = mMapData.Size.Height - 1; y >= 0; y--)
                {
                    int xPos = offsetPosition.X + x * HalfRegionWidth + y * HalfRegionWidth;
                    int yPos = offsetPosition.Y + x * HalfRegionHeight - y * HalfRegionHeight;
                    buff.DrawImage(resImage, xPos, yPos, resImage.Width, resImage.Height);

                    // 附加物体
                    ObjectData obj = mMapData.getObjectData(x, y);
                    if (obj.Picture != "")
                    {
                        string path = Application.StartupPath + "\\..\\assets\\Maps\\" + obj.Picture;
                        if (System.IO.File.Exists(path))
                        {
                            Bitmap objectPic = new Bitmap(path);
                            buff.DrawImage(objectPic, xPos + obj.Offset.X, yPos + obj.Offset.Y, objectPic.Width, objectPic.Height);
                        }
                    }
                }
            }

            // 刷选择项
            resImage = new Bitmap(Application.StartupPath + "\\..\\assets\\Maps\\back02.png");
            foreach (Point point in selectRect)
            {
                int xPos = offsetPosition.X + point.X * HalfRegionWidth + point.Y * HalfRegionWidth;
                int yPos = offsetPosition.Y + point.X * HalfRegionHeight - point.Y * HalfRegionHeight;
                buff.DrawImage(resImage, xPos, yPos, resImage.Width, resImage.Height);
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

        private void propertyGrid2_PropertyValueChanged(object s, PropertyValueChangedEventArgs e)
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

        private void pictureBox1_MouseClick(object sender, MouseEventArgs e)
        {
            Point[] rect = new Point[4];
            Point offsetPosition = mMapData.RegionOrigin;
            for (int x = 0; x < mMapData.Size.Width; x++)
            {
                for (int y = mMapData.Size.Height - 1; y >= 0; y--)
                {
                    ObjectData obj = mMapData.getObjectData(x, y);

                    int xPos = offsetPosition.X + x * HalfRegionWidth + y * HalfRegionWidth;
                    int yPos = offsetPosition.Y + x * HalfRegionHeight - y * HalfRegionHeight;

                    rect[0] = new Point(xPos, yPos + HalfRegionHeight);
                    rect[1] = new Point(xPos + HalfRegionWidth, yPos);
                    rect[2] = new Point(xPos + RegionWidth, yPos + HalfRegionHeight);
                    rect[3] = new Point(xPos + HalfRegionWidth, yPos + RegionHeight);

                    if (isPointInRect(new Point(e.X, e.Y), rect))
                    {
                        if ((Control.ModifierKeys & Keys.Control) == 0)
                            selectRect.Clear();

                        selectRect.Add(new Point(x, y));
                        updateScene();

                        ObjectData[] selobjs = new ObjectData[selectRect.Count];
                        for (int i = 0; i < selectRect.Count; i++)
                        {
                            selobjs[i] = mMapData.getObjectData(selectRect[i].X, selectRect[i].Y);
                        }
                        propertyGrid2.SelectedObjects = selobjs;
                        break;
                    }
                }
            }
        }

        private bool isPointInRect(Point point, Point[] rect)
        {
            System.Drawing.Drawing2D.GraphicsPath myGraphicsPath = new System.Drawing.Drawing2D.GraphicsPath();
            myGraphicsPath.Reset();

            myGraphicsPath.AddPolygon(rect);

            Region myRegion = new Region();
            myRegion.MakeEmpty();
            myRegion.Union(myGraphicsPath);

            return myRegion.IsVisible(point);
        }
    }
}
