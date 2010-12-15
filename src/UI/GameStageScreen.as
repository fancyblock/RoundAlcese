package UI 
{
	import com.pblabs.engine.entity.IEntity;
	import com.pblabs.engine.PBE;
	import flash.display.SimpleButton;
	import IsoMap.IsoGridComponent;
	import flash.events.MouseEvent;
	import RAEnums.RAScreenEnum;
	
	/**
	 * ...
	 * @author	Hejiabin
	 * @date	2010-12-14 16:23
	 */
	public class GameStageScreen extends BaseUIScreen 
	{
		//------------------------------ static member -------------------------------------
		
		//------------------------------ private member ------------------------------------
		
		private var m_btnReturn:SimpleButton = null;
		
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
			
			m_btnReturn = UI_ROOT.getChildByName( "mcReturn" ) as SimpleButton;
			
			//set mouseOver snd
			SetMouseOverSnd( m_btnReturn );
			//[unfinished]
			
			//set event listener
			m_btnReturn.addEventListener( MouseEvent.CLICK, _onReturn );
			//[unfinished]
		}
		
		//enter this stage
		override protected function onEnter():void
		{
			PBE.levelManager.loadLevel( 1 );				//----[test]
			
			//[unfinished]
		}
		
		//leave this stage
		override protected function onLeave():void
		{
			PBE.levelManager.unloadCurrentLevel();
			
			//[unfinished]
		}
		
		//------------------------------- event callback -----------------------------------
		
		//callback when return
		private function _onReturn( evt:MouseEvent ):void
		{
			FadeOutToScreen( RAScreenEnum.RA_FIENDCITY_SCREEN );
		}
		
	}

}