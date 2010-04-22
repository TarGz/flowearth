package fr.digitas.flowearth.process {
	import flash.events.Event;	
	
	/**
	 * @author Pierre Lepers
	 */
	public class BuildInfosEvent extends Event {

		
		public static const BUILD_ADDED : String = "bie_BUILD_ADDED";
		public static const BUILD_REMOVED : String = "bie_BUILD_REMOVED";
		
		
		public function get infos() : BuildInfos {
			return _binfos;
		}
		
		
		public function BuildInfosEvent( type : String, binfos : BuildInfos ) {
			super( type );
			_binfos = binfos;
		}

		override public function clone() : Event {
			return new BuildInfosEvent( type , _binfos );
		}

		private var _binfos : BuildInfos;
	}
}
