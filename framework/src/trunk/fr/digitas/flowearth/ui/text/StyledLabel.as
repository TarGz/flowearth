package fr.digitas.flowearth.ui.text {
	import fr.digitas.flowearth.text.styles.styleManager;

	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * @author Pierre Lepers
	 */
	public class StyledLabel extends Sprite {

		public var tf : TextField;
		
		
		
		public function get text() : String {
			return _htmlText;
		}
		
		public function set text(str : String) : void {
			_htmlText = str;
			_apply();
		}
		

		
		//______________________________________________________________
		//													   StyleName
		/** @private */
		public function get styleName() : String {
			return _styleName;
		}
		
		/**
		 * apply the style coorespnding to name passed in parameters.
		 * The style is search in all loaded css of the <code>Module</code>
		 */
		public function set styleName(styleName : String) : void {
			_styleName = styleName.toLowerCase();
			_apply( );
		}


		
		public function StyledLabel() {
			if( ! tf ) addChild( tf = new TextField() );
		}


		private function _apply() : void {
			if( _styleName && _htmlText )
				styleManager.apply( tf, _styleName, _htmlText );
		}


		private var _styleName : String;

		private var _htmlText : String;
		
		
	}
}
