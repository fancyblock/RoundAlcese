package GameLogic.Component 
{
	import com.pblabs.engine.entity.EntityComponent;
	import com.pblabs.engine.entity.IEntity;
	import com.pblabs.engine.entity.PropertyReference;
	import flash.geom.Point;
	import IsoMap.IsoGridComponent;
	import RAEvents.RAEvent;
	import com.pblabs.engine.PBE;
	import GameLogic.MonsterManager;
	
	/**
	 * ...
	 * @author	Hejiabin
	 * @date	2010-12-26 1:31
	 */
	public class DeployMonsterComponent extends EntityComponent 
	{
		//-------------------------------- static member ------------------------------------
		
		private var STATE_Place:String = "Place statue";
		private var STATE_Freeze:String = "Freeze statue";
				
		//-------------------------------- private member -----------------------------------
		
		private var m_state:String = null;
		private var m_curMonster:String = null;
		
		private var m_gridMap:IsoGridComponent = null;
		
		//-------------------------------- public function ----------------------------------
		
		/**
		 * @desc	constructor of DeployMonsterComponent
		 */
		public function DeployMonsterComponent() 
		{
			super();
		}
		
		/**
		 * @desc	set the grid map
		 * @param	grid
		 */
		public function SetGrid( grid:IsoGridComponent ):void
		{
			m_gridMap = grid;
			
			grid.owner.eventDispatcher.addEventListener( RAEvent.RA_EVENT_ClickGrid, _onClickGrid );
		}
		
		/**
		 * @desc	set the current monster
		 * @param	monster
		 */
		public function SetCurMonster( monster:String ):void
		{
			m_curMonster = monster;
		}
		
		/**
		 * @desc	set the state
		 * @param	value
		 */
		public function Active( value:Boolean ):void
		{
			if ( value == true )
			{
				m_state = this.STATE_Place;
			}
			else
			{
				m_state = this.STATE_Freeze;
			}
		}
		
		//-------------------------------- private function ---------------------------------
		
		//callback when grid add to the scene
		override protected function onAdd () : void
		{
			super.onAdd();
			
			this.owner.eventDispatcher.addEventListener( RAEvent.RA_EVENT_ActiveDMC, _onActive );
			this.owner.eventDispatcher.addEventListener( RAEvent.RA_EVENT_FreezeDMC, _onFreeze );
			this.owner.eventDispatcher.addEventListener( RAEvent.RA_EVENT_CurMonster, _onCurMonster );
		}
		
		//callback when grid remove from the scene
		override protected function onRemove () : void
		{
			super.onRemove();
			
			this.owner.eventDispatcher.removeEventListener( RAEvent.RA_EVENT_ActiveDMC, _onActive );
			this.owner.eventDispatcher.removeEventListener( RAEvent.RA_EVENT_FreezeDMC, _onFreeze );
			this.owner.eventDispatcher.removeEventListener( RAEvent.RA_EVENT_CurMonster, _onCurMonster );
		}
		
		//-------------------------------- callback function --------------------------------
		
		//place the monster
		private function _onClickGrid( evt:RAEvent ):void
		{
			if ( m_state == STATE_Place )
			{
				var newPos:Point = evt.RA_EVT_Info as Point;
				
				if ( m_gridMap.IsPlaceable( newPos ) == true )
				{
					var mo:IEntity = MonsterManager.Singleton.CreateMonster( m_curMonster );
					mo.setProperty( new PropertyReference( "@Ghost.POSITION" ), newPos );
					mo.setProperty( new PropertyReference( "@Ghost.GRID_MAP" ), m_gridMap );
				
					//render the map
					PBE.lookupEntity( "IsoMap" ).eventDispatcher.dispatchEvent( new RAEvent( RAEvent.RA_EVENT_RenderMap ) );
				}
			}
		}
		
		//callback when set the monster component active
		private function _onActive( evt:RAEvent ):void
		{
			m_state = this.STATE_Place;
		}
		
		//callback when set the monster component freeze
		private function _onFreeze( evt:RAEvent ):void
		{
			m_state = this.STATE_Freeze;
		}
		
		//callback when set the current monster
		private function _onCurMonster( evt:RAEvent ):void
		{
			m_curMonster = evt.RA_EVT_Info as String;
		}
		
	}

}