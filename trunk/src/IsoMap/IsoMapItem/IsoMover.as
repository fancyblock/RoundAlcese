package IsoMap.IsoMapItem 
{
	import as3isolib.display.scene.IsoScene;
	import flash.geom.Point;
	/**
	 * ...
	 * @author	Hejiabin
	 * @desc	2010-12-20 22:33
	 */
	public class IsoMover extends IsoMapItem 
	{
		//-------------------------------- static member ------------------------------------
		
		static public var DIR_0:int = 1;
		static public var DIR_3:int = 2;
		static public var DIR_6:int = 3;
		static public var DIR_9:int = 4;
		
		static private var STATE_Stop:int = 0;
		static private var STATE_Move:int = 1;
		
		//-------------------------------- private member -----------------------------------
		
		private var m_state:int = 0;
		private var m_speed:Number = 0.1;
		private var m_destPos:Point = null;
		private var m_stopAni:String = null;
		
		private var m_curMapPos:Point = new Point();
		private var m_destMapPos:Point = new Point();
		private var m_moveVelocity:Point = new Point();
		
		private var m_command:int = 0;
		
		//-------------------------------- public function ----------------------------------
		
		/**
		 * @desc	constructor
		 */
		public function IsoMover() 
		{
			super();
		}
		
		/**
		 * @desc	set the mover speed
		 */
		public function set SPEED( value:Number ):void
		{
			m_speed = value;
		}
		
		/**
		 * @desc 	set the next dir
		 */
		public function set NextDir( dir:int ):void
		{
			m_command = dir;
		}
		
		/**
		 * @desc	move to next position
		 * @param	dir
		 */
		public function Move( dir:int ):void
		{
			if ( m_state == STATE_Move ) return;
			
			var curPos:Point = this.POSITION;
			var nextPos:Point = new Point( curPos.x, curPos.y );
			
			switch( dir )
			{
			case DIR_0:
				nextPos.y--;
				ANIMATION_HOLDER.PlayAni( "RUN_DIR0" );
				m_stopAni = "DIR_0";
				m_moveVelocity.x = 0;
				m_moveVelocity.y = -m_speed;
				break;
			case DIR_3:
				nextPos.x++;
				ANIMATION_HOLDER.PlayAni( "RUN_DIR3" );
				m_stopAni = "DIR_3";
				m_moveVelocity.x = m_speed;
				m_moveVelocity.y = 0;
				break;
			case DIR_6:
				nextPos.y++;
				ANIMATION_HOLDER.PlayAni( "RUN_DIR6" );
				m_stopAni = "DIR_6";
				m_moveVelocity.x = 0;
				m_moveVelocity.y = m_speed;
				break;
			case DIR_9:
				nextPos.x--;
				ANIMATION_HOLDER.PlayAni( "RUN_DIR9" );
				m_stopAni = "DIR_9";
				m_moveVelocity.x = -m_speed;
				m_moveVelocity.y = 0;
				break;
			default:
				break;
			}
			
			m_destPos = nextPos;
			
			m_curMapPos.x = this.INODE.x;
			m_curMapPos.y = this.INODE.y;
			
			m_destMapPos.x = nextPos.x * this.GRID_MAP.CELL_SIZE;
			m_destMapPos.y = nextPos.y * this.GRID_MAP.CELL_SIZE;
			
			m_state = STATE_Move;
		}
		
		/**
		 * @desc	tick function
		 * @param	deltaTime
		 */
		override public function onTick (deltaTime:Number) : void
		{
			if ( m_state == STATE_Move )
			{
				if ( Math.abs( m_destMapPos.x - m_curMapPos.x ) > Math.abs( m_moveVelocity.x ) ||
					Math.abs( m_destMapPos.y - m_curMapPos.y ) > Math.abs( m_moveVelocity.y ) )
				{
					m_curMapPos.x += m_moveVelocity.x;
					m_curMapPos.y += m_moveVelocity.y;
					
					this.INODE.moveTo( m_curMapPos.x, m_curMapPos.y, 0 );
					this.INODE.render();
				}
				else
				{
					m_state = STATE_Stop;
					
					ANIMATION_HOLDER.PlayAni( m_stopAni );
					
					this.GRID_MAP.MoveItem( this, m_destPos.x, m_destPos.y );
					this.Render();
					
					m_command = 0;
				}
				
			}
			else if ( m_state == STATE_Stop )
			{
				if ( m_command != 0 )
				{
					Move( m_command );
					
					m_command = 0;
				}
			}
		}
		
		//-------------------------------- private function ---------------------------------
		
		//-------------------------------- callback function --------------------------------
		
	}

}