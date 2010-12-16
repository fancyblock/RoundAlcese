package IsoMap 
{
	import caurina.transitions.Tweener;
	import com.pblabs.engine.entity.EntityComponent;
	import flash.geom.Point;
	import Math;
	
	/**
	 * ...
	 * @author	Hejiabin
	 * @date	2010-12-16 11:04
	 */
	public class IsoCameraComponent extends EntityComponent 
	{
		//------------------------------ static member -------------------------------------
		
		//------------------------------ private member ------------------------------------
		
		private var m_isoView:IsoViewComponent = null;
		private var m_isoGrid:IsoGridComponent = null;
		
		private var m_cameraMoveVelocity:Number = 1;
		
		private var m_currentPos:Point = new Point();
		
		//------------------------------ public function -----------------------------------
		
		/**
		 * @desc	constructor
		 */
		public function IsoCameraComponent() 
		{
			super();
		}
		
		/**
		 * @desc 	set the view component
		 */
		public function set ISO_VIEW( isoView:IsoViewComponent ):void
		{
			m_isoView = isoView;
		}
		
		/**
		 * @desc	set the grid component
		 */
		public function set ISO_GRID( isoGrid:IsoGridComponent ):void
		{
			m_isoGrid = isoGrid;
		}
		
		/**
		 * @desc	set the camera moving speed
		 */
		public function set MOVE_VELOCITY( velocity:Number ):void
		{
			m_cameraMoveVelocity = velocity;
		}
		
		/**
		 * @desc	move camera to dest position in translation
		 * @param	x
		 * @param	y
		 */
		public function MoveTo( xpos:Number, ypos:Number ):void
		{
			var distance:Number = Math.sqrt( ( xpos - m_currentPos.x ) * ( xpos - m_currentPos.x ) + ( ypos - m_currentPos.y ) * ( ypos - m_currentPos.y ) );
			var durationTime:Number = distance / m_cameraMoveVelocity;
			
			//[unfinished]
			//Tweener.addTween( this, { POS_X:xpos, POS_Y:ypos, time:durationTime, transition:"linear" } );
		}
		
		/**
		 * @desc	move camera to dest position instantly
		 * @param	x
		 * @param	y
		 */
		public function SwitchTo( x:Number, y:Number ):void
		{
			m_currentPos.x = x;
			m_currentPos.y = y;
			
			m_isoView.CenterToGridPos( m_currentPos.x, m_currentPos.y );
		}
		
		//------------------------------ private function ----------------------------------
		
		//callback when this camera installed
		override protected function onAdd () : void
		{
			super.onAdd();
			
			moveToCenter();
		}

		//callback when this camera uninstalled
		override protected function onRemove () : void
		{
			super.onRemove();
			
			//[unfinished]
		}

		//callback when reset this camera
		override protected function onReset () : void
		{
			super.onReset();
			
			moveToCenter();
		}
		
		//move the camera to the center of the map
		private function moveToCenter():void
		{
			if ( m_isoView == null || m_isoGrid == null )
			{
				throw new Error( "[IsoCameraComponent]: not set the view/grid" );
			}
			
			SwitchTo( m_isoGrid.CELL_SIZE * m_isoGrid.GRID_SIZE.x / 2, m_isoGrid.CELL_SIZE * m_isoGrid.GRID_SIZE.y / 2 );
		}
		
		//------------------------------- event callback -----------------------------------
		
		
	}

}