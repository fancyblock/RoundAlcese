package z_dev_test 
{
	import com.pblabs.engine.entity.EntityComponent;
	import com.pblabs.engine.entity.PropertyReference;
	import GameLogic.BehaviorHolder;
	import GameLogic.IMapMoverAI;
	import IsoMap.IsoGridComponent;
	
	/**
	 * ...
	 * @author	Hejiabin
	 * @date	2010-12-26 16:14
	 */
	public class TestAIComponent extends EntityComponent implements IMapMoverAI 
	{
		//-------------------------------- static member ------------------------------------
				
		//-------------------------------- private member -----------------------------------
		
		private var m_map:IsoGridComponent = null;
		private var m_controller:PropertyReference = null;
		
		private var m_behaviorHolder:BehaviorHolder = null;
		
		//-------------------------------- public function ----------------------------------
		
		/**
		 * @desc	constructor of TestAIComponent
		 */
		public function TestAIComponent() 
		{
			super();
			
		}
		
		/* INTERFACE GameLogic.IMapMoverAI */
		
		public function Think():void 
		{
			//[unfinished]
		}
		
		public function set GridMap(map:IsoGridComponent):void 
		{
			m_map = map;
		}
		
		public function set Behavior_Holder( holder:PropertyReference ):void 
		{
			m_controller = holder;
		}
		
		//-------------------------------- private function ---------------------------------
		
		//return the controller
		private function get controller():BehaviorHolder
		{
			if ( m_behaviorHolder == null )
			{
				m_behaviorHolder = owner.getProperty( m_controller ) as BehaviorHolder;
			}
			
			return m_behaviorHolder;
		}
		
		//-------------------------------- callback function --------------------------------
		
	}

}