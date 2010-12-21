package Animation 
{
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author	Hejiabin
	 * @date	2010-12-20 22:43
	 */
	public interface IAnimation 
	{
		function PlayAni( ani:String ):void;
		
		function get RenderObject():DisplayObject;
	}
	
}