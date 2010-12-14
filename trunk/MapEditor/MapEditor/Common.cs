using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Drawing;
using System.Collections;

namespace MapEditor
{
    public class MapData
    {
        private int mapIndex;   // 索引
        private string mapName; // 名称
        private string mapDesc; // 描述
        private Point mapSize;  // 尺寸
        private Point origin;   // 原点坐标
        private string mapBackground; // 背景图
        private ArrayList objectList; // Obj列表

        public int Index
        {
            set { mapIndex = value; }
            get { return mapIndex; }
        }
        public string Name
        {
            set { mapName = value; }
            get { return mapName; }
        }
        public string Desc
        {
            set { mapDesc = value; }
            get { return mapDesc; }
        }
        public Point Size
        {
            set { mapSize = value; }
            get { return mapSize; }
        }
        public Point Origin
        {
            set { origin = value; }
            get { return origin; }
        }
        public string Background
        {
            set { mapBackground = value; }
            get { return mapBackground; }
        }
    }
}
