package GameLogic 
{
	import com.pblabs.engine.entity.IEntity;
	import com.pblabs.engine.PBE;
	
	/**
	 * ...
	 * @author	Hejiabin
	 * @date	2010-12-25 22:41
	 */
	public class MonsterManager 
	{
		//-------------------------------- static member ------------------------------------
		
		static private var m_instance:MonsterManager = null;
		static private var m_saftFlag:Boolean = false;
				
		//-------------------------------- private member -----------------------------------
		
		private var m_activeMonsterList:Array = null;
		
		//-------------------------------- public function ----------------------------------
		
		/**
		 * @desc	constructor of MonsterManager
		 */
		public function MonsterManager() 
		{
			if ( m_saftFlag == false )
			{
				throw new Error( "[MonsterManager] it's a singleton , can't be new" );
			}
		}
		
		/**
		 * @desc	return the singleton of this class
		 */
		static public function get Singleton():MonsterManager
		{
			if ( m_instance == null )
			{
				m_saftFlag = true
				m_instance = new MonsterManager();
				m_saftFlag = false;
			}
			
			return m_instance;
		}
		
		/**
		 * @desc	initial the monster info
		 */
		public function InitialMonsters():void
		{
			PBE.templateManager.loadFile( "../Monsters/Monsters.xml" );
			
			m_activeMonsterList = new Array();
		}
		
		/**
		 * @desc	create a monster
		 * @param	monster
		 * @return
		 */
		public function CreateMonster( monsterType:String ):IEntity
		{
			var entity:IEntity = PBE.templateManager.instantiateEntity( monsterType );
			
			m_activeMonsterList.push( entity );
			
			return entity;
		}
		
		/**
		 * @desc	destroy all the avtive monsters
		 */
		public function DestroyActiveMonsters():void
		{
			var monster:IEntity;
			
			while ( m_activeMonsterList.length > 0 )
			{
				monster = m_activeMonsterList.pop();
				
				monster.destroy();
			}
		}
		
		//-------------------------------- private function ---------------------------------
		
		//-------------------------------- callback function --------------------------------
		
	}

}