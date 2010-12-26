package RAEvents 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author	Hejiabin
	 * @date	2010-12-19 13:11
	 */
	public class RAEvent extends Event 
	{
		//-------------------------------- static member ------------------------------------
		
		static public var RA_EVENT_RenderMap:String = "Render Map";					// render the whole map
		static public var RA_EVENT_RenderItem:String = "Render Item";				// only render the changed item
		static public var RA_EVENT_ClickGrid:String = "Click Grid";					// click the grid map
		static public var RA_EVENT_ActiveDMC:String = "Active DMC";
		static public var RA_EVENT_FreezeDMC:String = "Freeze DMC";
		static public var RA_EVENT_CurMonster:String = "Current Monster";
		
		//-------------------------------- private member -----------------------------------
		
		private var m_info:Object = null;
		
		//-------------------------------- public function ----------------------------------
		
		/**
		 * @desc	constructor
		 * @param	type
		 * @param	bubbles
		 * @param	cancelable
		 */
		public function RAEvent(type:String, addInfo:Object = null, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			
			m_info = addInfo;
		}
		
		/**
		 * @desc	setter of set the event info
		 */
		public function set RA_EVT_Info( info:Object ):void
		{
			m_info = info;
		}
		
		/**
		 * @desc	getter of get the event info
		 */
		public function get RA_EVT_Info():Object
		{
			return m_info;
		}
		
		//-------------------------------- private function ---------------------------------
		
		//-------------------------------- callback function --------------------------------
		
	}

}
