package IsoMap 
{
	import as3isolib.display.scene.IIsoScene;
	import as3isolib.display.scene.IsoScene;
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
		}
		
		/**
		 * @desc	return the scene
		 */
		public function get ISCENE():IIsoScene
		{
			return m_isoScene;
		}
		
		//------------------------------ private function ----------------------------------
		
		//------------------------------- event callback -----------------------------------
		
		
	}

}