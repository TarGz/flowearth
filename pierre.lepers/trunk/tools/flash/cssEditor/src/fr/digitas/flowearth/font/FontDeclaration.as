package fr.digitas.flowearth.font {

	/**
	 * @author Pierre Lepers
	 */
	public class FontDeclaration {

		
		public function get className() : String {
			return _className;
		}
		
		public function get embedCmd() : String {
			return _embedCmd;
		}
		
		
		public function FontDeclaration( className : String, embedCmd : String ) {
			_embedCmd = embedCmd;
			_className = className; 
		}

		private var _className : String;
		
		private var _embedCmd : String;
		
	}
}
