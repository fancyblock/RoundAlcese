package 
{
	import com.pblabs.engine.entity.IEntity;
	import com.pblabs.engine.PBE;
	import com.pblabs.rendering2D.ui.SceneView;
	import flash.display.Sprite;
	import flash.system.fscommand;
	import IsoMap.IsoGridComponent;
	import IsoMap.IsoSceneComponent;
	import IsoMap.IsoViewComponent;
	import IsoMap.IsoCameraComponent;
	import RAEnums.RAScreenEnum;
	import RAEnums.RASystemParameter;
	import UI.FiendCityScreen;
	import UI.GameStageScreen;
	import UI.WelcomeScreen;
	
	/**
	 * ...
	 * @author	Hejiabin
	 * @date	2010-12-11 21:13
	 */
	[SWF(width="750", height="600", backgroundColor="0x000000")]
	public class Main extends Sprite 
	{
		//-------------------------------- static member ---------------------------------
		
		//-------------------------------- private member --------------------------------
		
		//-------------------------------- public function --------------------------------
		
		/**
		 * @desc	constructor
		 */
		public function Main():void 
		{
			//regist all the components
			PBE.registerType( IsoMap.IsoGridComponent );
			PBE.registerType( IsoMap.IsoCameraComponent );
			//[unfinished]
			
			//startup the engine
			PBE.startup( this );
			
			//embedded the resource
			new RAResources();
			
			//flash player setting
			fscommand( "allowscale", "false" );
			
			//regist all the ui
			PBE.screenManager.registerScreen( RAScreenEnum.RA_WELCOME_SCREEN, new WelcomeScreen() );
			PBE.screenManager.registerScreen( RAScreenEnum.RA_FIENDCITY_SCREEN, new FiendCityScreen() );
			PBE.screenManager.registerScreen( RAScreenEnum.RA_GAMESTAGE_SCREEN, new GameStageScreen() );
			//[unfinished]
			
			//initial the 2d scene
			var sceneView:SceneView = new SceneView();
			PBE.initializeScene( sceneView );
			
			//initial the iso scene
			var isoMapEntity:IEntity = PBE.allocateEntity();
			var isoView:IsoViewComponent = new IsoViewComponent();
			isoView.SetViewSize( RASystemParameter.SCREEN_WIDTH, RASystemParameter.SCREEN_HEIGHT );
			isoMapEntity.addComponent( isoView, "IsoView" );
			var isoScene:IsoSceneComponent = new IsoSceneComponent();
			isoView.AddScene( isoScene.ISCENE );
			isoMapEntity.addComponent( isoScene, "IsoScene" );
			isoMapEntity.initialize( "IsoMap" );
			
			//load the level info
			PBE.levelManager.load( "../Levels/RA_Levels.xml" );	
			
			//show start screen
			PBE.screenManager.push( RAScreenEnum.RA_WELCOME_SCREEN );
			
		}
		
		//-------------------------------- private function --------------------------------
		
		//-------------------------------- callback function --------------------------------
		
	}
	
}