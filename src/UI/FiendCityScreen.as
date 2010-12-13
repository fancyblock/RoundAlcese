package UI 
{
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author	Hejiabin
	 * @date	2010-12-13 21:57
	 */
	public class FiendCityScreen extends BaseUIScreen 
	{
		//-------------------------------- static member ------------------------------------
		
		//-------------------------------- private member -----------------------------------
		
		private var m_btnCashbox:SimpleButton = null;
		private var m_btnItemShop:SimpleButton = null;
		private var m_btnSpriteShop:SimpleButton = null;
		private var m_btnOthers:SimpleButton = null;
		
		//-------------------------------- public function ----------------------------------
		
		/**
		 * @desc	constructor
		 */
		public function FiendCityScreen() 
		{
			super( "../assets/Background/FiendCityBG.png" );
			
			//set the ui bgm
			this.UI_BGM = "../assets/Sound/BGM/FiendCityBGM.mp3";
			
			//load the ui
			this.loadUI( "../assets/FiendCityScreen.swf" );
		}
		
		//-------------------------------- private function ---------------------------------
		
		//initial the ui
		override protected function initialUI():void
		{
			addChild( UI_ROOT );
			
			m_btnCashbox = UI_ROOT.getChildByName( "btnCashbox" ) as SimpleButton;
			m_btnItemShop = UI_ROOT.getChildByName( "btnItemShop" ) as SimpleButton;
			m_btnSpriteShop = UI_ROOT.getChildByName( "btnSpriteShop" ) as SimpleButton;
			m_btnOthers = UI_ROOT.getChildByName( "btnOthers" ) as SimpleButton;
			
			//set the button se
			SetMouseOverSnd( m_btnCashbox );
			SetMouseOverSnd( m_btnItemShop );
			SetMouseOverSnd( m_btnOthers );
			SetMouseOverSnd( m_btnSpriteShop );
			
			//add event listener
			m_btnCashbox.addEventListener( MouseEvent.CLICK, _onCashbox );
			m_btnItemShop.addEventListener( MouseEvent.CLICK, _onItemShop );
			m_btnSpriteShop.addEventListener( MouseEvent.CLICK, _onSpriteShop );
			m_btnOthers.addEventListener( MouseEvent.CLICK, _onOhters );
		}
		
		//-------------------------------- callback function --------------------------------
		
		//enter the cashbox
		private function _onCashbox( evt:MouseEvent ):void
		{
			//[unfinished]
		}
		
		//enter the item shop
		private function _onItemShop( evt:MouseEvent ):void
		{
			//[unfinished]
		}
		
		//enter the sprite shop
		private function _onSpriteShop( evt:MouseEvent ):void
		{
			//[unfinished]
		}
		
		//enter the ...
		private function _onOhters( evt:MouseEvent ):void
		{
			//[unfinished]
		}
		
	}

}