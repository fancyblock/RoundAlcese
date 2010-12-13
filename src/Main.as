package 
{
	import com.pblabs.engine.PBE;
	import com.pblabs.screens.SplashScreen;
	import flash.display.Sprite;
	import RAEnums.RAScreenEnum;
	import UI.FiendCityScreen;
	import UI.WelcomeScreen;
	import flash.system.fscommand;
	
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
			PBE.startup( this );
			
			//embedded the resource
			new RAResources();
			
			//flash player setting
			fscommand( "allowscale", "false" );
			
			//regist all the ui
			PBE.screenManager.registerScreen( RAScreenEnum.RA_WELCOME_SCREEN, new WelcomeScreen() );
			PBE.screenManager.registerScreen( RAScreenEnum.RA_FIENDCITY_SCREEN, new FiendCityScreen() );
			//[unfinished]
			
			//show start screen
			PBE.screenManager.push( RAScreenEnum.RA_WELCOME_SCREEN );
		}
		
		//-------------------------------- private function --------------------------------
		
		//-------------------------------- callback function --------------------------------
		
	}
	
}