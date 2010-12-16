package IsoMap 
{
	import as3isolib.display.IsoSprite;
	import as3isolib.display.scene.IIsoScene;
	import as3isolib.display.scene.IsoGrid;
	import com.pblabs.engine.entity.EntityComponent;
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.resource.SWFResource;
	import com.pblabs.engine.resource.ImageResource;
	import flash.display.Sprite;
	import flash.geom.Point;
	
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
		private var m_isSwfBG:Boolean = true;
		
		private var m_defaultIsoGrid:IsoGrid = null;
		private var m_isoGrid:IsoSprite = null;
		private var m_gridBGpath:String = null;
		private var m_gridBGOffset:Point = null;
		
		private var m_gridSize:Point = null;
		private var m_cellSize:Number = 0;
		
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
		public function set IS_SWF_BG( value:Boolean ):void
		{
			m_isSwfBG = value;
		}
		
		/**
		 * @desc	set the grid bg offset
		 */
		public function set BG_OFFSET( offset:Point ):void
		{
			m_gridBGOffset = offset;
		}
		
		/**
		 * @desc	set the grid pic path
		 */
		public function set GRID_BG( picPath:String ):void
		{
			m_gridBGpath = picPath;
		}
		
		/**
		 * @desc	getter and setter of the grid size
		 */
		public function get GRID_SIZE():Point { return m_gridSize; }
		public function set GRID_SIZE( size:Point ):void { m_gridSize = size; }
		
		/**
		 * @desc	getter and setter of the size
		 */
		public function get CELL_SIZE():Number { return m_cellSize; }
		public function set CELL_SIZE( size:Number ):void { m_cellSize = size; }
		
		//-------------------------------- private function ---------------------------------
		
		//callback when grid add to the scene
		override protected function onAdd () : void
		{
			super.onAdd();
			
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
				if ( m_isSwfBG == true )
				{
					PBE.resourceManager.load( m_gridBGpath, SWFResource, _onSWFGridLoadded, _onGridLoadFail );
				}
				else
				{
					PBE.resourceManager.load( m_gridBGpath, ImageResource, _onIMGGridLoadded, _onGridLoadFail );
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
		
		//-------------------------------- callback function --------------------------------
		
		//callback when grid swf load finished
		private function _onSWFGridLoadded( resource:SWFResource ):void
		{
			var grid:Sprite = resource.clip;
			grid.x = 0;
			grid.y = 0;
			
			m_isoGrid.sprites = [grid];
			m_isoGrid.render();
		}
		
		//callback when grid image load finished
		private function _onIMGGridLoadded( resource:ImageResource ):void
		{
			var grid:Sprite = new Sprite();
			grid.addChild( resource.image );
			grid.x = m_gridBGOffset.x;
			grid.y = m_gridBGOffset.y;
			
			m_isoGrid.sprites = [grid];
			m_isoGrid.render();
		}
		
		//callback when load fail
		private function _onGridLoadFail( resource:SWFResource ):void
		{
			throw new Error( "[IsoGridComponent]: grid load fail" );
		}
		
	}

}