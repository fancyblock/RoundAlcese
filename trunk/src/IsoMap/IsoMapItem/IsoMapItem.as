package IsoMap.IsoMapItem 
{
	import as3isolib.core.IIsoDisplayObject;
	import as3isolib.display.IsoSprite;
	import com.pblabs.engine.entity.EntityComponent;
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.resource.ImageResource;
	import com.pblabs.engine.resource.Resource;
	import com.pblabs.engine.resource.SWFResource;
	import flash.display.Sprite;
	import flash.geom.Point;
	import IsoMap.IsoGridComponent;
	
	/**
	 * ...
	 * @author	Hejiabin
	 * @date	2010-12-17 14:36
	 */
	public class IsoMapItem extends EntityComponent implements IIsoMapItem 
	{
		//------------------------------ static member -------------------------------------
		
		//------------------------------ private member ------------------------------------
		
		private var m_position:Point = null;
		private var m_size:Point = null;
		
		private var m_isoItem:IsoSprite = null;
		
		private var m_map:IsoGridComponent = null;
		private var m_assetsPath:String = null;
		private var m_isSwfAsset:Boolean = false;
		private var m_assetsOffset:Point = null;
		
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
		 * @desc	set the gridmap
		 */
		public function set GRID_MAP( gridMap:IsoGridComponent ):void
		{
			m_map = gridMap;
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
		
		//------------------------------ private function ----------------------------------
		
		//callback when the item added
		override protected function onAdd () : void
		{
			super.onAdd();
			
			//load the item assets
			if ( m_isSwfAsset == true )
			{
				PBE.resourceManager.load( m_assetsPath, SWFResource, _onSwfLoadded, _onLoadFail );
			}
			else
			{
				PBE.resourceManager.load( m_assetsPath, ImageResource, _onImgLoadded, _onLoadFail );
			}
			
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
		
		//callback when swf assets load finished
		private function _onSwfLoadded( resource:SWFResource ):void
		{
			var itemAssets:Sprite = resource.clip;
			itemAssets.x = m_assetsOffset.x;
			itemAssets.y = m_assetsOffset.y;
			
			m_isoItem.sprites = [itemAssets];
			m_isoItem.render();
		}
		
		//callback when image assets load finished
		private function _onImgLoadded( resource:ImageResource ):void
		{
			var itemAssets:Sprite = new Sprite();
			itemAssets.addChild( resource.image );
			itemAssets.x = m_assetsOffset.x;
			itemAssets.y = m_assetsOffset.y;
			
			m_isoItem.sprites = [itemAssets];
			m_isoItem.render();
		}
		
		//callback when assets load fail
		private function _onLoadFail( resource:Resource ):void
		{
			throw new Error( "[IsoMapItem]: grid load fail" );
		}
		
	}

}