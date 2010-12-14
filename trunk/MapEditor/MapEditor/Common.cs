using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Drawing;
using System.Collections;
using System.Xml;

namespace MapEditor
{
    public class ObjectData
    {
        private Point offset;   // 偏移
        private string picture; // 图片

        public string Picture
        {
            set { picture = value; }
            get { return picture; }
        }
        public Point Offset
        {
            set { offset = value; }
            get { return offset; }
        }

        public ObjectData()
        {
            offset = new Point(0, 0);
            picture = "";
        }
    }

    public class MapData
    {
        private int mapIndex;   // 索引
        private string mapName; // 名称
        private string mapDesc; // 描述
        private Point mapSize;  // 尺寸
        private Point origin;   // 原点坐标
        private string mapBackground; // 背景图
        private ObjectData[,] objectList = null; // Obj列表

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

        public MapData()
        { 
            mapIndex = 0;
            mapName = "unDefine";
            mapDesc = "unDefine";
            mapSize = new Point(10, 10);
            origin = new Point(0, 0);
            mapBackground = "";
            objectList = new ObjectData[mapSize.X, mapSize.Y];
            for (int x = 0; x < Size.X; x++)
            {
                for (int y = 0; y < Size.Y; y++)
                {
                    objectList[x, y] = new ObjectData();
                }
            }
        }

        public bool Load(string path)
        {
            return false;
        }

        public bool Save(string path)
        {
            XmlDocument doc = new XmlDocument();
            XmlDeclaration decl = doc.CreateXmlDeclaration("1.0", "unicode", null);
            doc.AppendChild(decl);

            XmlElement rootElem = doc.CreateElement("MapData");
            rootElem.SetAttribute("index", Index.ToString());
            rootElem.SetAttribute("name", Name);
            rootElem.SetAttribute("describe", Desc);
            doc.AppendChild(rootElem);

            XmlNode baseNode = doc.SelectSingleNode("MapData");
            XmlElement elem = doc.CreateElement("Origin");
            elem.SetAttribute("x", Origin.X.ToString());
            elem.SetAttribute("y", Origin.Y.ToString());
            baseNode.AppendChild(elem);

            elem = doc.CreateElement("Background");
            elem.SetAttribute("picture", Background);
            baseNode.AppendChild(elem);

            elem = doc.CreateElement("Objects");
            elem.SetAttribute("width", Size.X.ToString());
            elem.SetAttribute("height", Size.Y.ToString());
            baseNode.AppendChild(elem);

            baseNode = baseNode.SelectSingleNode("Objects");

            for (int x = 0; x < Size.X; x++)
            {
                for (int y = 0; y < Size.Y; y++)
                {
                    elem = doc.CreateElement("Object");
                    elem.SetAttribute("x", x.ToString());
                    elem.SetAttribute("y", y.ToString());
                    elem.SetAttribute("offsetx", objectList[x, y].Offset.X.ToString());
                    elem.SetAttribute("offsety", objectList[x, y].Offset.Y.ToString());
                    elem.SetAttribute("picture", objectList[x, y].Picture);
                    baseNode.AppendChild(elem);
                }
            }

            doc.Save(path);

            return true;
        }
    }
}
