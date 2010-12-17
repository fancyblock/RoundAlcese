package IsoMap 
{
	import as3isolib.display.scene.IIsoScene;
	import as3isolib.display.scene.IsoScene;
	import as3isolib.events.IsoEvent;
	import com.pblabs.engine.entity.EntityComponent;
	
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
			m_isoScene.addEventListener( IsoEvent.CHILD_ADDED, _onChildAdd );
			m_isoScene.addEventListener( IsoEvent.CHILD_REMOVED, _onChildRemove );
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
		
		//------------------------------- event callback -----------------------------------
		
		//callback when child added
		private function _onChildAdd( evt:IsoEvent ):void
		{
			//[unfinished]
		}
		
		//callback when child removed
		private function _onChildRemove( evt:IsoEvent ):void
		{
			//[unfinished]
		}
	}

}