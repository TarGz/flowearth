package fr.digitas.flowearth.csseditor.managers {

	/**
	 * @author Pierre Lepers
	 */
	public class TabManager {

		
		public static function getIndex() : int {
			return CURRENT_INDEX++;
		}
		
		public static  function reset() : void {
			CURRENT_INDEX = 0;
		}

		
		
		private static var CURRENT_INDEX : int = 0;
	}
	
}
