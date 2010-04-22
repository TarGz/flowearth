package fr.digitas.flowearth.font {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.text.Font;
	import flash.text.FontStyle;
	import flash.utils.Dictionary;		

	/**
	 * @author Pierre Lepers
	 */
	public class FontFileInfo extends EventDispatcher {

		
		
		public function FontFileInfo( file : File ) {
			_output = file;
		}

		public function get output() : File {
			return _output;
		}
		
		
		public function getFontInfos() : Vector.<FontInfo> {
			return _fontInfos;
		}
		
		public function getInfoByName( fontName : String ) : FontInfo {
			if( ! _families ) return null;
			return _families[ fontName ];
		}

		public function hasInfoByName( fontName : String ) : Boolean {
			if( ! _families )return false;
			return _families[ fontName ] != undefined;
		}

		
		protected function change() : void {
			dispatchEvent( new Event( Event.CHANGE ) );
		}
		
		protected var _output : File;
		
		protected var _fontInfos : Vector.<FontInfo>;

		protected var _families : Dictionary;

		public function init( _afonts : Array) : void {
			
			_families = new Dictionary();
			var font : Font;
			var finfo : FontInfo;
			for each (var fontClass : Class in _afonts) {
				font = new fontClass();
				if( _families[ font.fontName ] == undefined ) 
					_families[ font.fontName ] = new FontInfo();
				
				finfo = _families[ font.fontName ];
				finfo.fontFamily = font.fontName;
				//finfo.
				switch( font.fontStyle ) {
					case FontStyle.REGULAR :
						finfo.style_normal = true;
						break;
					case FontStyle.BOLD:
						finfo.style_bold = true;
						break;
					case FontStyle.ITALIC:
						finfo.style_italic = true;
						break;
					case FontStyle.BOLD_ITALIC:
						finfo.style_bolditalic = true;
						break;
				}
			}
			
			_fontInfos = new Vector.<FontInfo>();
			
			for each ( finfo in _families ) {
				_fontInfos.push( finfo );
			}
		}
		
	}
}
