package IsoMap 
{
	import as3isolib.core.IIsoDisplayObject;
	import as3isolib.display.IsoView;
	import as3isolib.display.scene.IIsoScene;
	import as3isolib.geom.Pt;
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
		
		/**
		 * @desc	set the size of view
		 * @param	wid
		 * @param	hei
		 */
		public function SetViewSize( wid:Number, hei:Number ):void
		{
			m_isoView.setSize( wid, hei );
		}
		
		/**
		 * @desc	set an object as center of the view
		 * @param	target
		 */
		public function CenterToTarget( target:IIsoDisplayObject ):void
		{
			m_isoView.centerOnIso( target );
		}
		
		/**
		 * @desc	set an grid pos as center of the view
		 * @param	x
		 * @param	y
		 */
		public function CenterToGridPos( x:Number, y:Number ):void
		{
			m_isoView.centerOnPt( new Pt( x, y ) );
		}
		
		//------------------------------ private function ----------------------------------
		
		//------------------------------- event callback -----------------------------------
		
	}

}