package Animation 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.resource.ImageResource;
	import Animation.IAnimation;
	
	/**
	 * ...
	 * @author	Hejiabin
	 * @date	2010-12-20 22:58
	 */
	public class StaticAnimation extends Sprite implements IAnimation
	{
		//-------------------------------- static member ------------------------------------
				
		//-------------------------------- private member -----------------------------------
		
		private var m_pic:Bitmap = null;
		
		//-------------------------------- public function ----------------------------------
		
		/**
		 * @desc	constructor
		 */
		public function StaticAnimation() 
		{
			super();
			
		}
		
		/**
		 * @desc	load the assets
		 * @param	path
		 */
		public function LoadAssets( path:String ):void
		{
			PBE.loadResource( path, ImageResource, _onLoaded, _onFail );
		}
		
		/**
		 * @desc	play the ani
		 * @param	ani
		 */
		public function PlayAni( ani:String ):void
		{
			//[do nothing]
		}
		
		/**
		 * @desc	return the render object
		 */
		public function get RenderObject():DisplayObject
		{
			return null;
		}
		
		//-------------------------------- private function ---------------------------------
		
		//-------------------------------- callback function --------------------------------
		
		//callback when assets loadded
		private function _onLoaded( res:ImageResource ):void
		{
			m_pic = res.image;
			
			this.addChild( m_pic );
		}
		
		//callback when assets load fail
		private function _onFail( res:ImageResource ):void
		{
			throw new Error( "[SwfAnimation] assets load fail" );
		}
		
	}

}