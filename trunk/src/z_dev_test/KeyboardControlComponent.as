package z_dev_test 
{
	import Animation.IAnimation;
	import com.pblabs.engine.components.TickedComponent;
	import com.pblabs.engine.entity.PropertyReference;
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.core.InputKey;
	import IsoMap.IsoMapItem.IsoMover;
	
	/**
	 * ...
	 * @author	Hejiabin
	 * @date	2010-12-20 22:12
	 */
	public class KeyboardControlComponent extends TickedComponent 
	{
		//-------------------------------- static member ------------------------------------
				
		//-------------------------------- private member -----------------------------------
		
		private var m_controller:PropertyReference = null;
		
		//-------------------------------- public function ----------------------------------
		
		/**
		 * @desc	constructor
		 */
		public function KeyboardControlComponent() 
		{
			super();
		}
		
		/**
		 * @desc	set the animation holder
		 */
		public function set POS_HOLDER( holder:PropertyReference ):void
		{
			m_controller = holder;
		}
		
		/**
		 * @desc	tick function
		 * @param	deltaTime
		 */
		override public function onTick (deltaTime:Number) : void
		{
			super.onTick( deltaTime );
			
			if ( PBE.isKeyDown( InputKey.UP ) == true )
			{
				owner.setProperty( m_controller, IsoMover.DIR_0 );
			}
			else if ( PBE.isKeyDown( InputKey.DOWN ) == true )
			{
				owner.setProperty( m_controller, IsoMover.DIR_6 );
			}
			else if ( PBE.isKeyDown( InputKey.LEFT ) == true )
			{
				owner.setProperty( m_controller, IsoMover.DIR_9 );
			}
			else if ( PBE.isKeyDown( InputKey.RIGHT ) == true )
			{
				owner.setProperty( m_controller, IsoMover.DIR_3 );
			}
			
		}
		
		//-------------------------------- private function ---------------------------------
		
		//-------------------------------- callback function --------------------------------
		
	}

}