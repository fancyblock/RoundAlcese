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
        private MapData mMapData;

        public MainEditor()
        {
            InitializeComponent();

            mMapData = new MapData();
            propertyGrid1.SelectedObject = mMapData;
        }
    }
}
