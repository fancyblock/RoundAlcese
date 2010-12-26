package UI 
{
	import com.pblabs.engine.core.LevelEvent;
	import com.pblabs.engine.entity.IEntity;
	import com.pblabs.engine.PBE;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import GameLogic.Component.DeployMonsterComponent;
	import GameLogic.Component.EnemyActionComponent;
	import GameLogic.MonsterManager;
	import IsoMap.IsoGridComponent;
	import RAEnums.RAScreenEnum;
	import RAEvents.RAEvent;
	
	/**
	 * ...
	 * @author	Hejiabin
	 * @date	2010-12-14 16:23
	 */
	public class GameStageScreen extends BaseUIScreen 
	{
		//------------------------------ static member -------------------------------------
		
		static private var State_PlayerTurn:int = 1;
		static private var State_EnemyTurn:int = 2;
		static private var State_PlayerTurnHint:int = 3;
		static private var State_EnemyTurnHint:int = 4;
		
		//------------------------------ private member ------------------------------------
		
		//ui component
		private var m_btnReturn:SimpleButton = null;
		private var m_aniFiendTurn:MovieClip = null;
		private var m_aniEnemyTurn:MovieClip = null;
		
		//state
		private var m_state:int = 0;
		
		//component
		private var m_deployMonster:DeployMonsterComponent = null;
		private var m_enemyAction:EnemyActionComponent = null;
		
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
			
			//add event listener
			PBE.levelManager.addEventListener( LevelEvent.LEVEL_LOADED_EVENT, _onLevelLoaded );
			
		}
		
		/**
		 * @desc	frame callback
		 * @param	delta
		 */
		override public function onFrame (delta:Number) : void
		{
			super.onFrame( delta );
			
			switch( m_state )
			{
			case State_PlayerTurnHint:
				break;
			case State_PlayerTurn:
				break;
			case State_EnemyTurnHint:
				break;
			case State_EnemyTurn:
				break;
			default:
				m_state = State_PlayerTurnHint;
				break;
			}
		}
		
		//------------------------------ private function ----------------------------------
		
		//initial the ui
		override protected function initialUI():void
		{
			addChild( UI_ROOT );
			
			//get the ui
			m_btnReturn = UI_ROOT.getChildByName( "mcReturn" ) as SimpleButton;
			m_aniFiendTurn = UI_ROOT.getChildByName( "mcFiendTurn" ) as MovieClip;
			m_aniEnemyTurn = UI_ROOT.getChildByName( "mcEnemyTurn" ) as MovieClip;
			
			//set mouseOver snd
			SetMouseOverSnd( m_btnReturn );
			
			//set event listener
			m_btnReturn.addEventListener( MouseEvent.CLICK, _onReturn );
		}
		
		//enter this stage
		override protected function onEnter():void
		{
			PBE.levelManager.loadLevel( 1 );				//----[Load test level]
		}
		
		//leave this stage
		override protected function onLeave():void
		{
			PBE.levelManager.unloadCurrentLevel();
			
			//[unfinished]
			MonsterManager.Singleton.DestroyActiveMonsters();
		}
		
		//------------------------------- event callback -----------------------------------
		
		//callback when return
		private function _onReturn( evt:MouseEvent ):void
		{
			FadeOutToScreen( RAScreenEnum.RA_FIENDCITY_SCREEN );
		}
		
		//callback when level load finished
		private function _onLevelLoaded( evt:LevelEvent ):void
		{
			//render the map
			PBE.lookupEntity( "IsoMap" ).eventDispatcher.dispatchEvent( new RAEvent( RAEvent.RA_EVENT_RenderMap ) );
			
			//initial the deploy monster component
			var coreLogic:IEntity = PBE.allocateEntity();
			
			m_deployMonster = new DeployMonsterComponent();
			m_deployMonster.SetGrid( PBE.lookupEntity( "MapGrid" ).lookupComponentByName( "Grid" ) as IsoGridComponent );
			m_deployMonster.SetCurMonster( "TestMonster" );
			m_deployMonster.Active( false );
			coreLogic.addComponent( m_deployMonster, "DMC" );
			
			
			
			coreLogic.initialize( "CoreLogic" );
		}
	}

}