package UI 
{
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.system.System;
	import RAEnums.RAScreenEnum;
	
	/**
	 * ...
	 * @author	Hejiabin
	 * @date	2010-12-12 15:14
	 */
	public class WelcomeScreen extends UI.BaseUIScreen 
	{
		//-------------------------------- static member -----------------------------------
		
		//-------------------------------- private member ----------------------------------
		
		private var m_btnStart:SimpleButton = null;
		private var m_btnExit:SimpleButton = null;
		
		//-------------------------------- public function --------------------------------
		
		/**
		 * @desc	constructor
		 */
		public function WelcomeScreen() 
		{
			super( "../assets/Background/WelcomeBG.png" );
			
			//set the ui bgm
			this.UI_BGM = "../assets/Sound/BGM/InitialBGM.mp3";
			
			//load the ui
			this.loadUI( "../assets/WelcomeScreen.swf" );
		}
		
		//-------------------------------- private function --------------------------------
		
		//initial the ui
		override protected function initialUI():void
		{
			addChild( UI_ROOT );
			
			m_btnStart = UI_ROOT.getChildByName( "btnStart" ) as SimpleButton;
			m_btnExit = UI_ROOT.getChildByName( "btnExit" ) as SimpleButton;
			
			//add event listener
			m_btnStart.addEventListener( MouseEvent.CLICK, _onStart );
			m_btnExit.addEventListener( MouseEvent.CLICK, _onExit );
			
			//set the button se
			this.SetMouseOverSnd( m_btnStart );
			this.SetMouseOverSnd( m_btnExit );
		}
		
		//-------------------------------- callback function --------------------------------
		
		//click start game
		private function _onStart( evt:MouseEvent ):void
		{
			FadeOutToScreen( RAScreenEnum.RA_FIENDCITY_SCREEN );
		}
		
		//click exit game
		private function _onExit( evt:MouseEvent ):void
		{
			System.exit( 0 );
		}
		
	}

}