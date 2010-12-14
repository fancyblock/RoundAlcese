package UI 
{
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
			this.UI_BGM = "../assets/Sound/BGM/FiendCityBGM.mp3";		//----------- temp
			
			//load the ui
			this.loadUI( "../assets/FiendCityScreen.swf" );				//----------- temp
			
		}
		
		//------------------------------ private function ----------------------------------
		
		//initial the ui
		override protected function initialUI():void
		{
			//[unfinished]
		}
		
		//------------------------------- event callback -----------------------------------
		
	}

}