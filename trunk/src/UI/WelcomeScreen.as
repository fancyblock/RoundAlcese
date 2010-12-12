package UI 
{
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.resource.SWFResource;
	import com.pblabs.screens.ImageScreen;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import RAEnums.RAScreenEnum;
	import RAEnums.RASoundEnum;
	import flash.system.System;
	import caurina.transitions.Tweener;
	
	/**
	 * ...
	 * @author	Hejiabin
	 * @date	2010-12-12 15:14
	 */
	public class WelcomeScreen extends ImageScreen 
	{
		//-------------------------------- static member -----------------------------------
		
		//-------------------------------- private member ----------------------------------
		
		private var m_ui:MovieClip = null;
		
		private var m_btnStart:SimpleButton = null;
		private var m_btnExit:SimpleButton = null;
		private var m_btnAoiSola:SimpleButton = null;
		
		//-------------------------------- public function --------------------------------
		
		/**
		 * @desc	constructor
		 */
		public function WelcomeScreen() 
		{
			super( "../assets/Background/WelcomeBG.png" );
			
			//load the background
			PBE.loadResource( "../assets/WelcomeScreen.swf", SWFResource, _onUILoaded, _onLoadFail );
		}
		
		/**
		 * @desc	invoke when screen show
		 */
		override public function onShow () : void
		{
			super.onShow();
			
			enableControl( true );
			
			//play the bgm
			PBE.soundManager.play( "../assets/Sound/BGM/InitialBGM.mp3", RASoundEnum.ALL_UI_BGM, 0, 50 );
		}
		
		/**
		 * @desc	invoke when screen hide
		 */
		override public function onHide () : void
		{
			super.onHide();
			
			//stop the bgm
			PBE.soundManager.stopCategorySounds( RASoundEnum.ALL_UI_BGM );
			
			this.alpha = 1;
		}
		
		//-------------------------------- private function --------------------------------
		
		//initial the ui
		private function initialUI():void
		{
			addChild( m_ui );
			
			m_btnStart = m_ui.getChildByName( "btnStart" ) as SimpleButton;
			m_btnExit = m_ui.getChildByName( "btnExit" ) as SimpleButton;
			m_btnAoiSola = m_ui.getChildByName( "btnAoiSola" ) as SimpleButton;
			
			//add event listener
			m_btnStart.addEventListener( MouseEvent.CLICK, _onStart );
			m_btnExit.addEventListener( MouseEvent.CLICK, _onExit );
			m_btnAoiSola.addEventListener( MouseEvent.CLICK, _onAoiSola );
			
			m_btnStart.addEventListener( MouseEvent.MOUSE_OVER, _onButtonRollOver );
			m_btnExit.addEventListener( MouseEvent.MOUSE_OVER, _onButtonRollOver );
			m_btnAoiSola.addEventListener( MouseEvent.MOUSE_OVER, _onButtonRollOver );
		}
		
		//enable or disable all the control
		private function enableControl( enable:Boolean = true ):void
		{
			if ( m_ui != null )
			{
				m_btnStart.enabled = enable;
				m_btnExit.enabled = enable;
				m_btnAoiSola.enabled = enable;
			}
		}
		
		//-------------------------------- callback function --------------------------------
		
		//finished load the ui
		private function _onUILoaded( resource:SWFResource ):void
		{
			m_ui = resource.clip;
			
			initialUI();
		}
		
		//ui swf load fail
		private function _onLoadFail( resource:SWFResource ):void
		{
			throw new Error( "[WelcomeScreen]: ui load fail" );
		}
		
		//click start game
		private function _onStart( evt:MouseEvent ):void
		{
			enableControl( false );
			
			Tweener.addTween( this, { alpha:0, time:2, transition:"linear", onComplete:_onDisappear } );
		}
		
		//click exit game
		private function _onExit( evt:MouseEvent ):void
		{
			System.exit( 0 );
		}
		
		//click aoiSola
		private function _onAoiSola( evt:MouseEvent ):void
		{
			PBE.screenManager.goto( RAScreenEnum.RA_AOISOLA_SCREEN );
		}
		
		//when mouse over , play the snd
		private function _onButtonRollOver( evt:MouseEvent ):void
		{
			PBE.soundManager.play( "../assets/Sound/SE/buttonRollOver.mp3", RASoundEnum.All_ButtonSE );
		}
		
		//callback when screen disappear
		private function _onDisappear():void
		{
			PBE.screenManager.pop();
			
			//[unfinished]
			
			PBE.screenManager.goto( RAScreenEnum.RA_AOISOLA_SCREEN );
		}
		
	}

}