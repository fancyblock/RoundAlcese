package IsoMap 
{
	import as3isolib.display.scene.IIsoScene;
	import as3isolib.display.scene.IsoScene;
	import com.pblabs.engine.entity.EntityComponent;
	import RAEvents.RAEvent;
	
	/**
	 * ...
	 * @author	Hejiabin
	 * @desc	2010-12-15 16:53
	 */
	public class IsoSceneComponent extends EntityComponent 
	{
		//------------------------------ static member -------------------------------------
		
		//------------------------------ private member ------------------------------------
		
		private var m_isoScene:IIsoScene = null;
		
		//------------------------------ public function -----------------------------------
		
		/**
		 * @desc	constructor
		 */
		public function IsoSceneComponent() 
		{
			super();
			
			//instance the scene
			m_isoScene = new IsoScene();
		}
		
		/**
		 * @desc	return the scene
		 */
		public function get ISCENE():IIsoScene
		{
			return m_isoScene;
		}
		
		/**
		 * @desc	render the scene
		 * @param	recursive
		 */
		public function Render( recursive:Boolean = true ):void
		{
			m_isoScene.render( recursive );
		}
		
		//------------------------------ private function ----------------------------------
		
		//callback when scene add
		override protected function onAdd () : void
		{
			owner.eventDispatcher.addEventListener( RAEvent.RA_EVENT_RenderMap, _onRenderMap );
			
			m_isoScene.addEventListener( RAEvent.RA_EVENT_RenderItem, _onRenderItem );
		}

		//callback when scene removed
		override protected function onRemove () : void
		{
			owner.eventDispatcher.removeEventListener( RAEvent.RA_EVENT_RenderMap, _onRenderMap );
			
			m_isoScene.removeEventListener( RAEvent.RA_EVENT_RenderItem, _onRenderItem );
		}
		
		//------------------------------- event callback -----------------------------------
		
		//render callback
		private function _onRenderMap( evt:RAEvent ):void
		{
			this.Render();
		}
		
		//render callback
		private function _onRenderItem( evt:RAEvent ):void
		{
			m_isoScene.render();				//----------[temp]
			
			//[unfinished]
		}
		
	}

}