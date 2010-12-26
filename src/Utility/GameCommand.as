package Utility 
{
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	/**
	 * ...
	 * @author	Hejiabin
	 * @date	2010-12-26 14:06
	 */
	public class GameCommand 
	{
		//-------------------------------- static member ------------------------------------
				
		//-------------------------------- private member -----------------------------------
		
		private var m_host:Object = null;
		private var m_func:Function = null;
		private var m_args:* = null;
		
		private var m_delayTime:int = 0;
		
		private var m_timer:Timer = null;
		
		//-------------------------------- public function ----------------------------------
		
		/**
		 * @desc	constructor of GameCommand
		 */
		public function GameCommand( host:Object, func:Function, args:*, delay:int = 0 ):void
		{
			m_host = host;
			m_func = func;
			m_args = args;
			
			m_delayTime = delay;
			
			m_timer = new Timer( m_delayTime, 1 );
			m_timer.addEventListener( TimerEvent.TIMER_COMPLETE, _onTimeOver );
		}
		
		/**
		 * @desc	do the command
		 * @param	delay
		 */
		public function DoCommand( delay:int = -1 ):void
		{
			if ( delay != -1 )
			{
				m_delayTime = delay;
			}
			
			m_timer.delay = m_delayTime;
			
			m_timer.reset();
			m_timer.start();
		}
		
		//-------------------------------- private function ---------------------------------
		
		//-------------------------------- callback function --------------------------------
		
		//callback when time over
		private function _onTimeOver( evt:TimerEvent ):void
		{
			m_func.apply( m_host, m_args );
		}
		
	}

}