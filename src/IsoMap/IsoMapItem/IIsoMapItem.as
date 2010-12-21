package IsoMap.IsoMapItem 
{
	import Animation.IAnimation;
	import as3isolib.core.IIsoDisplayObject;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author	Hejiabin
	 * @date	2010-12-17 10:20
	 */
	public interface IIsoMapItem 
	{
		function get POSITION():Point;
		
		function set POSITION( pos:Point ):void;
		
		function get SIZE():Point;
		
		function set SIZE( size:Point ):void;
		
		function get INODE():IIsoDisplayObject;
		
		function set MAP_ID( id:int ):void;
		
		function get MAP_ID():int;
		
		function Render():void;
		
		function get ANIMATION_HOLDER():IAnimation;
	}
	
}