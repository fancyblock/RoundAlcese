package IsoMap 
{
	import as3isolib.display.IsoSprite;
	import as3isolib.display.scene.IIsoScene;
	import as3isolib.display.scene.IsoGrid;
	import as3isolib.geom.Pt;
	import com.pblabs.engine.entity.EntityComponent;
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.resource.ImageResource;
	import com.pblabs.engine.resource.Resource;
	import com.pblabs.engine.resource.SWFResource;
	import eDpLib.events.ProxyEvent;
	import flash.display.Sprite;
	import flash.geom.Point;
	import IsoMap.IsoMapItem.IIsoMapItem;
	import flash.events.MouseEvent;
	import as3isolib.geom.IsoMath;
	import RAEvents.RAEvent;
	
	/**
	 * ...
	 * @author	Hejiabin
	 * @date	2010-12-15 22:06
	 */
	public class IsoGridComponent extends EntityComponent 
	{
		//-------------------------------- static member ------------------------------------
		
		//-------------------------------- private member -----------------------------------
		
		private var m_isoScene:IIsoScene = null;
		
		private var m_isDefaultGrid:Boolean = true;
		private var m_isSwfAsset:Boolean = true;
		
		private var m_defaultIsoGrid:IsoGrid = null;
		private var m_isoGrid:IsoSprite = null;
		private var m_assetsPath:String = null;
		private var m_assetsOffset:Point = null;
		
		private var m_gridSize:Point = null;
		private var m_cellSize:Number = 0;
		
		private var m_mapData:Array = null;			//if the grid is blank, flag is false
		private var m_itemList:Array = null;
		
		//-------------------------------- public function ----------------------------------
		
		/**
		 * @desc	constructor
		 */
		public function IsoGridComponent() 
		{
			super();
			
			//initial the grid sprite
			m_isoGrid = new IsoSprite();
			m_isoGrid.setSize( 0, 0, 0 );
			m_isoGrid.moveTo( 0, 0, 0 );
			m_isoGrid.addEventListener( MouseEvent.CLICK, _onClickGrid );
		}
		
		/**
		 * @desc	set the scene of this grid
		 */
		public function set PARENT_SCENE( scene:IsoSceneComponent ):void
		{
			m_isoScene = scene.ISCENE;
		}
		
		/**
		 * @desc	set if use the default grid
		 */
		public function set USE_DEFAULT_GRID( value:Boolean ):void
		{
			m_isDefaultGrid = value;
		}
		
		/**
		 * @desc	set if use the swf background
		 */
		public function set IS_SWF_ASSETS( value:Boolean ):void
		{
			m_isSwfAsset = value;
		}
		
		/**
		 * @desc	set the grid bg offset
		 */
		public function set ASSETS_OFFSET( offset:Point ):void
		{
			m_assetsOffset = offset;
		}
		
		/**
		 * @desc	set the grid pic path
		 */
		public function set ITEM_ASSETS( picPath:String ):void
		{
			m_assetsPath = picPath;
		}
		
		/**
		 * @desc	getter and setter of the grid size
		 */
		public function get GRID_SIZE():Point { return m_gridSize; }
		public function set GRID_SIZE( size:Point ):void
		{ 
			m_gridSize = size;
			
			m_mapData = new Array( size.x );
			for ( var i:int = 0; i < size.x; i++ )
			{
				m_mapData[i] = new Array( size.y );
				
				for ( var j:int = 0; j < size.y; j++ )
				{
					m_mapData[i][j] = 0;
				}
			}
			
			m_itemList = new Array();
		}
		
		/**
		 * @desc	getter and setter of the size
		 */
		public function get CELL_SIZE():Number { return m_cellSize; }
		public function set CELL_SIZE( size:Number ):void { m_cellSize = size; }
		
		/**
		 * @desc	add an item to the grid map
		 * @param	item
		 */
		public function AddItem( item:IIsoMapItem ):Boolean
		{
			var mapId:int = getAvailableID();
				
			if ( isPlaceable( item.POSITION, item.SIZE, mapId ) == true )
			{
				m_isoScene.addChild( item.INODE );
				item.INODE.setSize( m_cellSize, m_cellSize, m_cellSize );
				item.INODE.moveTo( item.POSITION.x * m_cellSize, item.POSITION.y * m_cellSize, 0 );
				item.MAP_ID = mapId;
				setGrid( item.POSITION, item.SIZE, item.MAP_ID );
				m_itemList.push( item );
				
				return true;
			}
			
			return false;
		}
		
		/**
		 * @desc	remove an item form the grid map
		 * @param	item
		 */
		public function RemoveItem( item:IIsoMapItem ):Boolean
		{
			var index:int = m_itemList.indexOf( item );
			
			if ( index != -1 )
			{			
				m_isoScene.removeChild( item.INODE );
				setGrid( item.POSITION, item.SIZE, 0 );
				m_itemList.splice( index, 1 );
			}
			
			return true;
		}
		
		/**
		 * @desc	move a item form one position to other
		 * @param	item
		 * @param	destX
		 * @param	dextY
		 * @return
		 */
		public function MoveItem( item:IIsoMapItem, destX:int, destY:int ):Boolean
		{
			if ( m_itemList.indexOf( item ) == -1 )
			{
				throw new Error( "[IsoGridComponent] this item not on the map, can't be moved" );
			}
			
			var destPos:Point = new Point( destX, destY );
			
			if ( isPlaceable( destPos, item.SIZE, item.MAP_ID ) == false )
			{
				return false;
			}
			
			setGrid( item.POSITION, item.SIZE, 0 );
			item.POSITION = destPos;
			setGrid( item.POSITION, item.SIZE, item.MAP_ID );
			item.INODE.moveTo( item.POSITION.x * m_cellSize, item.POSITION.y * m_cellSize, 0 );
			
			return true;
		}
		
		/**
		 * @desc	judge if the dest can arriveable, only can be used to the item that already on the map
		 * @param	xpos
		 * @param	ypos
		 * @param	item
		 * @return
		 */
		public function IsArriveable( xpos:int, ypos:int, item:IIsoMapItem ):Boolean
		{
			if ( item.MAP_ID == 0 ) return false;
			
			if ( xpos < 0 || ypos < 0 || xpos + item.SIZE.x > m_gridSize.x || ypos + item.SIZE.y > m_gridSize.y ) return false;
			
			return isPlaceable( new Point( xpos, ypos ), item.SIZE, item.MAP_ID );
		}
		
		/**
		 * @desc	judge if the dest can place a item
		 * @param	pos
		 * @param	size
		 * @return
		 */
		public function IsPlaceable( pos:Point, size:Point = null ):Boolean
		{
			var sizeX:int = ( size == null ? 1 : size.x );
			var sizeY:int = ( size == null ? 1 : size.y );
			
			if ( pos.x < 0 || pos.y < 0 || pos.x + sizeX > m_gridSize.x || pos.y + sizeY > m_gridSize.y ) return false;
			
			return isPlaceable( pos, null, 0 );
		}
		
		/**
		 * @desc	translate screen coordinate to grid coordinate
		 * @param	xpos
		 * @param	ypos
		 * @return
		 */
		public function ScreenToGrid( xpos:Number, ypos:Number ):Point
		{
			var pos:Point = new Point( int( xpos / m_cellSize ), int( ypos / m_cellSize ) );
			
			return pos;
		}
		
		//-------------------------------- private function ---------------------------------
		
		//callback when grid add to the scene
		override protected function onAdd () : void
		{
			super.onAdd();
			
			//add the grid map background
			if ( m_isDefaultGrid == true )
			{
				m_defaultIsoGrid = new IsoGrid();
				m_defaultIsoGrid.showOrigin = false;
				m_defaultIsoGrid.setGridSize( m_gridSize.x, m_gridSize.y );
				m_defaultIsoGrid.cellSize = m_cellSize;
				
				m_isoScene.addChild( m_defaultIsoGrid );
			}
			else
			{
				if ( m_isSwfAsset == true )
				{
					PBE.resourceManager.load( m_assetsPath, SWFResource, _onSwfLoadded, _onLoadFail );
				}
				else
				{
					PBE.resourceManager.load( m_assetsPath, ImageResource, _onImgLoadded, _onLoadFail );
				}
				
				m_isoScene.addChild( m_isoGrid );
			}
		}

		//callback when grid remove from the scene
		override protected function onRemove () : void
		{
			super.onRemove();
			
			if ( m_isDefaultGrid == true )
			{
				m_isoScene.removeChild( m_defaultIsoGrid );
			}
			else
			{
				m_isoScene.removeChild( m_isoGrid );
			}
		}
		
		/**
		 * @desc	judge if this rect can place to the grid map
		 * @param	pos
		 * @param	size
		 * @return
		 */
		private function isPlaceable( pos:Point, size:Point, mapID:int ):Boolean
		{
			var realSizeX:int = ( size == null ? 1 : size.x );
			var realSizeY:int = ( size == null ? 1 : size.y );
			
			var destX:int = pos.x + realSizeX;
			var destY:int = pos.y + realSizeY;
			
			for ( var i:int = pos.x; i < destX; i++ )
			{
				for ( var j:int = pos.y; j < destY; j++ )
				{
					if ( m_mapData[i][j] > 0 && m_mapData[i][j] != mapID )
					{
						return false;
					}
				}
			}
			
			return true;
		}
		
		/**
		 * @desc	
		 * @param	pos
		 * @param	size
		 */
		private function setGrid( pos:Point, size:Point, state:int ):void
		{
			var destX:int = pos.x + size.x;
			var destY:int = pos.y + size.y;
			
			for ( var i:int = pos.x; i < destX; i++ )
			{
				for ( var j:int = pos.y; j < destY; j++ )
				{
					m_mapData[i][j] = state;
				}
			}
		}
		
		/**
		 * @desc	return a available map id
		 * @return
		 */
		private function getAvailableID():int
		{
			var len:int = m_itemList.length;
			var nextID:int = 0;
			
			for ( var i:int = 1; i <= len; i++ )
			{
				var match:Boolean = false;
				
				for ( var j:int = 0; j < len; j++ )
				{
					if ( ( m_itemList[j] as IIsoMapItem ).MAP_ID == i )
					{
						match = true;
						break;
					}
				}
				
				if ( match == false )
				{
					nextID = i;
					
					break;
				}
			}
			
			return nextID == 0 ? len + 1 : nextID;
		}
		
		//-------------------------------- callback function --------------------------------
		
		//callback when grid swf load finished
		private function _onSwfLoadded( resource:SWFResource ):void
		{
			var grid:Sprite = resource.clip;
			grid.x = m_assetsOffset.x;
			grid.y = m_assetsOffset.y;
			
			m_isoGrid.sprites = [grid];
			m_isoGrid.render();
		}
		
		//callback when grid image load finished
		private function _onImgLoadded( resource:ImageResource ):void
		{
			var grid:Sprite = new Sprite();
			grid.addChild( resource.image );
			grid.x = m_assetsOffset.x;
			grid.y = m_assetsOffset.y;
			
			m_isoGrid.sprites = [grid];
			m_isoGrid.render();
		}
		
		//callback when load fail
		private function _onLoadFail( resource:Resource ):void
		{
			throw new Error( "[IsoGridComponent]: grid load fail" );
		}
		
		//callback when click the grid
		private function _onClickGrid( evt:ProxyEvent ):void
		{
			//calculate the grid coordinate
			var mouseEvt:MouseEvent = evt.targetEvent as MouseEvent;
			var pt:Pt = new Pt( mouseEvt.localX + m_assetsOffset.x, mouseEvt.localY + m_assetsOffset.y );
			IsoMath.screenToIso( pt );
			
			//dispatch event
			var gridPos:Point = new Point( int( pt.x / m_cellSize ), int( pt.y / m_cellSize ) );
			var gridEvt:RAEvent = new RAEvent( RAEvent.RA_EVENT_ClickGrid );
			gridEvt.RA_EVT_Info = gridPos;
			
			this.owner.eventDispatcher.dispatchEvent( gridEvt );
		}
		
	}

}