package IsoMap 
{
	import as3isolib.display.IsoView;
	import as3isolib.display.scene.IIsoScene;
	import com.pblabs.engine.entity.EntityComponent;
	import com.pblabs.engine.PBE;
	
	/**
	 * ...
	 * @author	Hejiabin
	 * @date	2010-12-15 16:43
	 */
	public class IsoViewComponent extends EntityComponent 
	{
		//------------------------------ static member -------------------------------------
		
		//------------------------------ private member ------------------------------------
		
		private var m_isoView:IsoView = null;
		
		//------------------------------ public function -----------------------------------
		
		/**
		 * @desc	constructor
		 */
		public function IsoViewComponent() 
		{
			super();
			
			//create a iso view
			m_isoView = new IsoView();
			
			//add the view to the mainClass
			PBE.mainClass.addChild( m_isoView );
			
		}
		
		/**
		 * @desc	add a scene to the view
		 * @param	scene
		 */
		public function AddScene( scene:IIsoScene ):void
		{
			m_isoView.addScene( scene );
		}
		
		//------------------------------ private function ----------------------------------
		
		//------------------------------- event callback -----------------------------------
		
	}

}