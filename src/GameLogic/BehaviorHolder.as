package GameLogic 
{
	import Animation.IAnimation;
	import flash.geom.Point;
	import GameLogic.Behavior.IBehavior;
	/**
	 * ...
	 * @author	Hejiabin
	 * @date	2010-12-26 17:25
	 */
	public class BehaviorHolder 
	{
		//-------------------------------- static member ------------------------------------
			
		//-------------------------------- private member -----------------------------------
		
		private var m_positionRef:Point = null;
		private var m_aniHolder:IAnimation = null;
		
		//-------------------------------- public function ----------------------------------
		
		/**
		 * @desc	constructor of BehaviorHolder
		 */
		public function BehaviorHolder() 
		{
		}
		
		/**
		 * @desc	apply a behavior
		 * @param	behvior
		 */
		public function ApplyBehavior( behvior:IBehavior ):void
		{
			//[unfinished]
		}
		
		/**
		 * @desc	return the position of mover
		 */
		public function get Position():Point
		{
			return m_positionRef;
		}
		
		/**
		 * @desc	set the position reference
		 */
		public function set Position( ref:Point ):void
		{
			m_positionRef = ref;
		}
		
		/**
		 * @desc	set the animation holder
		 */
		public function set AniHolder( holder:IAnimation ):void
		{
			m_aniHolder = holder;
		}
		
		//-------------------------------- private function ---------------------------------
		
		//-------------------------------- callback function --------------------------------
		
	}

}