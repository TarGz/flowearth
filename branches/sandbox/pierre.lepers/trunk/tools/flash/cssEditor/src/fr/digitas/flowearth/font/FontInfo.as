package fr.digitas.flowearth.font {
	import fr.digitas.flowearth.csseditor.event.FontEvent;	
	
	import flash.text.Font;	
	import flash.events.Event;
	import flash.events.EventDispatcher;		

	/**
	 * @author Pierre Lepers
	 */
	public class FontInfo extends EventDispatcher {

		
		public function FontInfo() {
			
		}

		
		
		public function get fontFamily() : String {
			if( _fontFamily == null ) return "Untitled"; 
			return _fontFamily;
		}

		public function set fontFamily(fontFamily : String) : void {
			if( _fontFamily == fontFamily ) return;
			_fontFamily = fontFamily;
			change( );
		}
		
		public function setUnicodeRange( range : Vector.<uint> ) : void {
			
			if( equalsRange( range ) ) return;
			
			_unicodeRange = range;
			change( );
		}

		public function setChars( chars : String ) : void {
			setUnicodeRange( cleanChars( chars ) );
		}
		
		
		public function get unicodeRange() : Vector.<uint> {
			if( ! _unicodeRange ) return new Vector.<uint>();
			return _unicodeRange;
		}
		

		public function get style_normal() : Boolean {
			return _style_normal;
		}

		public function set style_normal(style_normal : Boolean) : void {
			if( _style_normal ==  style_normal ) return;
			_style_normal = style_normal;
			change( );
		}

		public function get style_bold() : Boolean {
			return _style_bold;
		}

		public function set style_bold(style_bold : Boolean) : void {
			if( _style_bold ==  style_bold ) return;
			_style_bold = style_bold;
			change( );
		}

		public function get style_italic() : Boolean {
			return _style_italic;
		}

		public function set style_italic(style_italic : Boolean) : void {
			if( _style_italic ==  style_italic ) return;
			_style_italic = style_italic;
			change( );
		}

		public function get style_bolditalic() : Boolean {
			return _style_bolditalic;
		}

		public function set style_bolditalic(style_bolditalic : Boolean) : void {
			if( _style_bolditalic ==  style_bolditalic ) return;
			_style_bolditalic = style_bolditalic;
			change( );
		}
		
		public function get font() : Font {
			return _font;
		}

		protected function cleanChars( input : String ) : Vector.<uint> {
			var result : Vector.<uint> = new Vector.<uint>( );
			var l : int = input.length;
			var code : uint;
			for (var i : int = 0; i < l ; i ++) {
				code = input.charCodeAt( i );
				if( result.indexOf( code ) == - 1 )
					result.push( code );
			}
		
			return result;
		}
		
		protected function equalsRange(range : Vector.<uint> ) : Boolean {
			if( _unicodeRange == null ) return false;
			if( range.length != _unicodeRange.length ) return false;
			for (var i : int = 0; i < range.length; i++) {
				if( _unicodeRange.indexOf( range[i] ) == -1 ) return false;
			}
			return true;
		}

		protected function change() : void {
			dispatchEvent( new Event( Event.CHANGE ) );
		}
		
		protected var _fontFamily : String;

		protected var _unicodeRange : Vector.<uint>;
		
		protected var _style_normal 		: Boolean = false;
		protected var _style_bold 			: Boolean = false;
		protected var _style_italic 		: Boolean = false;
		protected var _style_bolditalic 	: Boolean = false;
		
		protected var _font : Font;
		
	}
}
