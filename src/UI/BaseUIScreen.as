package UI 
{
	import caurina.transitions.Tweener;
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.resource.SWFResource;
	import com.pblabs.screens.ImageScreen;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import RAEnums.RASoundEnum;
	import RAEnums.RASystemParameter;
	
	/**
	 * ...
	 * @author	Hejiabin
	 * @date	2010-12-13 22:27
	 */
	public class BaseUIScreen extends ImageScreen 
	{
		//-------------------------------- static member ------------------------------------
		
		//-------------------------------- private member -----------------------------------
		
		private var m_uiRoot:MovieClip = null;
		private var m_nextScreen:String = null;
		private var m_uiBGM:String = null;
		
		//-------------------------------- public function ----------------------------------
		
		/**
		 * @desc	constructor
		 * @param	image
		 */
		public function BaseUIScreen( image:String ) 
		{
			super(image);
		}
		
		/**
		 * @desc	invoke when screen show
		 */
		override public function onShow () : void
		{
			super.onShow();
			
			enableControl( true );
			
			//play the bgm
			if ( m_uiBGM != null ) PBE.soundManager.play( m_uiBGM, RASoundEnum.ALL_UI_BGM, 0, 100 );
			
			onEnter();
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
		
		//-------------------------------- private function ---------------------------------
		
		/**
		 * @desc	set all the controls in this ui enable or disable
		 * @param	enable
		 */
		protected function enableControl( enable:Boolean ):void
		{
			if ( m_uiRoot == null ) return;
			
			for each( var control:DisplayObject in m_uiRoot )
			{
				if ( control is Sprite )
				{
					( control as Sprite ).mouseEnabled = enable;
				}
				
				if ( control is SimpleButton )
				{
					( control as SimpleButton ).mouseEnabled = enable;
				}
			}
		}
		
		/**
		 * @desc	load the ui MovieClip
		 * @param	uiPath
		 */
		protected function loadUI( uiPath:String ):void
		{
			//load the ui
			PBE.loadResource( uiPath, SWFResource, _onUILoaded, _onLoadFail );
		}
		
		/**
		 * @desc	set se on a button
		 * @param	btn
		 * @param	add
		 */
		protected function SetMouseOverSnd( btn:SimpleButton, add:Boolean = true ):void
		{
			if ( add == true )
			{
				btn.addEventListener( MouseEvent.MOUSE_OVER, _onButtonMouseOver );
			}
			else
			{
				btn.removeEventListener( MouseEvent.MOUSE_OVER, _onButtonMouseOver );
			}
		}
		
		/**
		 * @desc	getter  ui
		 */
		protected function get UI_ROOT():MovieClip	{ return m_uiRoot; }
		
		/**
		 * @desc	setter bgm
		 */
		protected function set UI_BGM( bgm:String ):void { m_uiBGM = bgm; }
		
		/**
		 * @desc	fade out this screen and goto the next screen
		 * @param	nextScreen
		 */
		protected function FadeOutToScreen( nextScreen:String ):void
		{
			onLeave();
			
			enableControl( false );
			
			m_nextScreen = nextScreen;
			
			Tweener.addTween( this, { alpha:0, time:RASystemParameter.SCREEN_FADEOUT_TIME, transition:"linear", onComplete:_onDisappear } );
		}
		
		//initial the ui
		protected function initialUI():void {}
		
		//enter callback
		protected function onEnter():void {}
		
		//leave callback
		protected function onLeave():void {}
		
		//-------------------------------- callback function --------------------------------
		
		//play the se when mouse over
		private function _onButtonMouseOver( evt:MouseEvent ):void
		{
			PBE.soundManager.play( "../assets/Sound/SE/buttonRollOver.mp3", RASoundEnum.All_ButtonSE );
		}
		
		//callback when screen disappear
		private function _onDisappear():void
		{
			PBE.screenManager.pop();
			
			PBE.screenManager.push( m_nextScreen );
		}
		
		//finished load the ui
		private function _onUILoaded( resource:SWFResource ):void
		{
			m_uiRoot = resource.clip;
			
			initialUI();
		}
		
		//ui swf load fail
		private function _onLoadFail( resource:SWFResource ):void
		{
			throw new Error( "[WelcomeScreen]: ui load fail" );
		}
	}

}