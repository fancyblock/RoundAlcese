package GameLogic 
{
	import com.pblabs.engine.entity.PropertyReference;
	import IsoMap.IsoGridComponent;
	
	/**
	 * ...
	 * @author	Hejiabin
	 * @date	2010-12-26 14:36
	 */
	public interface IMapMoverAI 
	{
		function Think():void;
		
		function set GridMap( map:IsoGridComponent ):void;
		
		function set Behavior_Holder( holder:PropertyReference ):void 
	}
	
}
