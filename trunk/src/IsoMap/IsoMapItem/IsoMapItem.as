package IsoMap.IsoMapItem 
{
	import Animation.IAnimation;
	import Animation.StaticAnimation;
	import Animation.SwfAnimation;
	import as3isolib.core.IIsoDisplayObject;
	import as3isolib.display.IsoSprite;
	import com.pblabs.engine.components.TickedComponent;
	import flash.geom.Point;
	import IsoMap.IsoGridComponent;
	import RAEvents.RAEvent;
	
	/**
	 * ...
	 * @author	Hejiabin
	 * @date	2010-12-17 14:36
	 */
	public class IsoMapItem extends TickedComponent implements IIsoMapItem 
	{
		//------------------------------ static member -------------------------------------
		
		//------------------------------ private member ------------------------------------
		
		private var m_position:Point = null;
		private var m_size:Point = null;
		private var m_mapID:int = 0;
		
		private var m_isoItem:IsoSprite = null;
		
		private var m_map:IsoGridComponent = null;
		private var m_assetsPath:String = null;
		private var m_isSwfAsset:Boolean = false;
		private var m_assetsOffset:Point = new Point();
		
		private var m_animationHolder:IAnimation = null;
		
		//------------------------------ public function -----------------------------------
		
		/**
		 * @desc	constructor
		 */
		public function IsoMapItem() 
		{
			super();
			
			m_isoItem = new IsoSprite();
		}
		
		/**
		 * @desc	set the grid map
		 */
		public function set GRID_MAP( gridMap:IsoGridComponent ):void
		{
			m_map = gridMap;
		}
		
		/**
		 * @desc 	return the animation controller
		 */
		public function get ANIMATION_HOLDER():IAnimation
		{
			return m_animationHolder;
		}
		
		/**
		 * @desc	get the grid map
		 */
		public function get GRID_MAP():IsoGridComponent
		{
			return m_map;
		}
		
		/**
		 * @desc	set the item assets
		 */
		public function set ITEM_ASSETS( assets:String ):void
		{
			m_assetsPath = assets;
		}
		
		/**
		 * @desc	set if assets is swf or other format
		 */
		public function set IS_SWF_ASSETS( value:Boolean ):void
		{
			m_isSwfAsset = value;
		}
		
		/**
		 * @desc	set the assets offset
		 */
		public function set ASSETS_OFFSET( offset:Point ):void
		{
			m_assetsOffset = offset;
		}
		
		/* INTERFACE IsoMap.IsoMapItem.IIsoMapItem */
		
		/**
		 * @desc	return the position of this item
		 */
		public function get POSITION():Point 
		{
			return m_position;
		}
		
		/**
		 * @desc	set the position of this item
		 */
		public function set POSITION(pos:Point):void 
		{
			m_position = pos;
		}
		
		/**
		 * @desc	return the size of this item
		 */
		public function get SIZE():Point 
		{
			return m_size;
		}
		
		/**
		 * @desc	set the size of this item
		 */
		public function set SIZE(size:Point):void 
		{
			m_size = size;
		}
		
		/**
		 * @desc	return the INode of this item
		 */
		public function get INODE():IIsoDisplayObject 
		{
			return m_isoItem;
		}
		
		/**
		 * @desc	set the map id
		 */
		public function set MAP_ID( id:int ):void
		{
			m_mapID = id;
		}
		
		/**
		 * @desc	return the map id
		 */
		public function get MAP_ID():int
		{
			return m_mapID;
		}
		
		/**
		 * @desc	render this item
		 */
		public function Render():void
		{
			var evt:RAEvent = new RAEvent( RAEvent.RA_EVENT_RenderItem );
			evt.RA_EVT_Info = m_isoItem;
			
			m_isoItem.parent.dispatchEvent( evt );
		}
		
		//------------------------------ private function ----------------------------------
		
		//callback when the item added
		override protected function onAdd () : void
		{
			super.onAdd();
			
			//load the item assets
			if ( m_isSwfAsset == true )
			{
				var swfAssets:SwfAnimation = new SwfAnimation();
				swfAssets.LoadAssets( m_assetsPath );
				swfAssets.x = m_assetsOffset.x;
				swfAssets.y = m_assetsOffset.y;
				m_animationHolder = swfAssets;
				
				m_isoItem.sprites = [swfAssets];
			}
			else
			{
				var picAssets:StaticAnimation = new StaticAnimation();
				picAssets.LoadAssets( m_assetsPath );
				picAssets.x = m_assetsOffset.x;
				picAssets.y = m_assetsOffset.y;
				m_animationHolder = picAssets;
				
				m_isoItem.sprites = [picAssets];
			}
			
			m_isoItem.render();
			
			//add this item to the map
			if ( m_map.AddItem( this ) == false )
			{
				throw new Error( "[IsoMapItem] this item can't be place to the map" );
			}
		}
		
		//callback when the item removed
		override protected function onRemove () : void
		{
			super.onRemove();
			
			m_map.RemoveItem( this );
		}
		
		//------------------------------- event callback -----------------------------------
		
	}

}