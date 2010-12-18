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
        private bool passable;  // 通行

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
        public bool Passable
        {
            set { passable = value; }
            get { return passable; }
        }

        public ObjectData()
        {
            offset = new Point(0, 0);
            picture = "";
            passable = true;
        }
    }

    public class MapData
    {
        private int mapIndex;   // 索引
        private string mapName; // 名称
        private string mapDesc; // 描述
        private Size mapSize;   // 尺寸
        private Point origin;   // 原点坐标
        private string mapBackground;               // 背景图
        private ObjectData[,] objectList = null;    // Obj列表

        private Size pixelSize; // box的实际大小

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
        public Size Size
        {
            set
            {
                Size size = value;
                if (size.Width != mapSize.Width || size.Height != mapSize.Height)
                {
                    mapSize = size;
                    resize(mapSize.Width, mapSize.Height);
                }
            }
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
        public Size PixelSize
        {
            set { pixelSize = value; }
            get { return pixelSize; }
        }

        public MapData()
        { 
            mapIndex = 0;
            mapName = "unDefine";
            mapDesc = "unDefine";
            origin = new Point(0, 0);
            mapBackground = "";
            resize(10, 10);
            pixelSize = new Size(512, 512);
        }

        public void resize(int width, int height)
        {
            Size = new Size(width, height);

            objectList = new ObjectData[mapSize.Width, mapSize.Height];
            for (int x = 0; x < Size.Width; x++)
            {
                for (int y = 0; y < Size.Height; y++)
                {
                    objectList[x, y] = new ObjectData();
                }
            }
        }

        public bool Load(string path)
        {
            if (!System.IO.File.Exists(path))
                return false;

            XmlDocument doc = new XmlDocument();
            doc.Load(path);

            XmlElement rootElem = doc.SelectSingleNode("MapData") as XmlElement;
            Index = int.Parse(rootElem.GetAttribute("index"));
            Name = rootElem.GetAttribute("name");
            Desc = rootElem.GetAttribute("describe");

            XmlElement elem = rootElem.SelectSingleNode("Origin") as XmlElement;
            Origin = new Point(int.Parse(elem.GetAttribute("x")), int.Parse(elem.GetAttribute("y")));

            elem = rootElem.SelectSingleNode("Background") as XmlElement;
            Background = elem.GetAttribute("picture");

            elem = rootElem.SelectSingleNode("Objects") as XmlElement;
            Point size = new Point(int.Parse(elem.GetAttribute("width")), int.Parse(elem.GetAttribute("height")));

            resize(size.X, size.Y);

            foreach (XmlNode node in elem.SelectNodes("Object"))
            {
                XmlElement subElem = node as XmlElement;
                int x = int.Parse(subElem.GetAttribute("x"));
                int y = int.Parse(subElem.GetAttribute("y"));
                int offx = int.Parse(subElem.GetAttribute("offsetx"));
                int offy = int.Parse(subElem.GetAttribute("offsety"));
                string picture = subElem.GetAttribute("picture");
                bool passable = bool.Parse(subElem.GetAttribute("passable"));

                objectList[x, y].Offset = new Point(offx, offy);
                objectList[x, y].Picture = picture;
                objectList[x, y].Passable = passable;
            }

            return true;
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
            elem.SetAttribute("width", Size.Width.ToString());
            elem.SetAttribute("height", Size.Height.ToString());
            baseNode.AppendChild(elem);

            baseNode = baseNode.SelectSingleNode("Objects");

            for (int x = 0; x < Size.Width; x++)
            {
                for (int y = 0; y < Size.Height; y++)
                {
                    elem = doc.CreateElement("Object");
                    elem.SetAttribute("x", x.ToString());
                    elem.SetAttribute("y", y.ToString());
                    elem.SetAttribute("offsetx", objectList[x, y].Offset.X.ToString());
                    elem.SetAttribute("offsety", objectList[x, y].Offset.Y.ToString());
                    elem.SetAttribute("picture", objectList[x, y].Picture);
                    elem.SetAttribute("passable", objectList[x, y].Passable.ToString());
                    baseNode.AppendChild(elem);
                }
            }

            doc.Save(path);

            return true;
        }
    }
}
