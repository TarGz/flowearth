package fr.digitas.flowearth.text.styles {

	/**
	 * public entry point of textLayoutFramework dependancy injection.
	 * 
	 * Do not compile this class to avoid compiling whole Tfl.
	 * 
	 * usage :
	 * 		TlfSupport.init();
	 * 
	 * 
	 * @author Pierre Lepers
	 */
	public final class TlfSupport {

		public static function init() : void {
			tlfFactory = new TlfFactoryImplementation();
		}
	}
}
