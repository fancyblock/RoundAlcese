package UI 
{
	import com.pblabs.engine.PBE;
	
	/**
	 * ...
	 * @author	Hejiabin
	 * @date	2010-12-14 16:23
	 */
	public class GameStageScreen extends BaseUIScreen 
	{
		//------------------------------ static member -------------------------------------
		
		//------------------------------ private member ------------------------------------
		
		//------------------------------ public function -----------------------------------
		
		/**
		 * @desc	constructor
		 * @param	image
		 */
		public function GameStageScreen() 
		{
			super( null );
			
			//set the ui bgm
			this.UI_BGM = "../assets/Sound/BGM/BattleBGM.mp3";
			
			//load the ui
			this.loadUI( "../assets/GameStageScreen.swf" );
			
		}
		
		//------------------------------ private function ----------------------------------
		
		//initial the ui
		override protected function initialUI():void
		{
			addChild( UI_ROOT );
			
			//[unfinished]
		}
		
		//enter this stage
		override protected function onEnter():void
		{
			PBE.levelManager.load( "../Levels/RA_Levels.xml", 1 );						//--------[temp]
			
			//[unfinished]
		}
		
		//leave this stage
		override protected function onLeave():void
		{
			PBE.levelManager.unloadCurrentLevel();
			
			//[unfinished]
		}
		
		//------------------------------- event callback -----------------------------------
		
	}

}