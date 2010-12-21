package Animation 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.resource.SWFResource;
	
	/**
	 * ...
	 * @author	Hejiabin
	 * @desc	2010-12-20 22:52
	 */
	public class SwfAnimation extends Sprite implements IAnimation 
	{
		//-------------------------------- static member ------------------------------------
				
		//-------------------------------- private member -----------------------------------
		
		private var m_mc:MovieClip = null;
		
		//-------------------------------- public function ----------------------------------
		
		/**
		 * @desc	constructor
		 */
		public function SwfAnimation() 
		{
			super();
		}
		
		/**
		 * @desc	load the assets
		 * @param	path
		 */
		public function LoadAssets( path:String ):void
		{
			PBE.loadResource( path, SWFResource, _onLoaded, _onFail );
		}
		
		/* INTERFACE Animation.IAnimation */
		
		public function PlayAni(ani:String):void 
		{
			if ( m_mc != null )
			{
				m_mc.gotoAndStop( ani );
			}
		}
		
		public function get RenderObject():DisplayObject 
		{
			return m_mc;
		}
		
		//-------------------------------- private function ---------------------------------
		
		//-------------------------------- callback function --------------------------------
		
		//callback when assets loadded
		private function _onLoaded( res:SWFResource ):void
		{
			m_mc = res.clip;
			
			this.addChild( m_mc );
		}
		
		//callback when assets load fail
		private function _onFail( res:SWFResource ):void
		{
			throw new Error( "[SwfAnimation] assets load fail" );
		}
		
	}

}