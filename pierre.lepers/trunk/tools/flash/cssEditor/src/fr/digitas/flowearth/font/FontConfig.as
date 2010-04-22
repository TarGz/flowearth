package fr.digitas.flowearth.font {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;	

	/**
	 * @author Pierre Lepers
	 */
	public class FontConfig extends FontInfo {

		
		private var _sourceName : String;

		private var _sourceFile : File;
		
		public function FontConfig( datas : XML = null ) {
			super();
			_style_normal = true;
			if( datas )
				_import( datas );
		}
		



		
		
		public function remove() : void {
			dispatchEvent( new Event( Event.REMOVED ) );
		}
		
		public function clone() : FontConfig {
			//TODO optimizer le clone des FontConfig
			return new FontConfig( export() );
		}

		
		
		
		
		
		
		public function get sourceName() : String {
			return _sourceName;
		}

		public function set sourceName(sourceName : String) : void {
			if( _sourceName == sourceName ) return;
			_sourceName = sourceName;
			change( );
		}

		
		public function get sourceFile() : File {
			return _sourceFile;
		}

		public function set sourceFile(sourceFile : File) : void {
			if( _sourceFile &&  (_sourceFile.nativePath == sourceFile.nativePath) ) return;
			_sourceFile = sourceFile;
			change( );
		}

		public function getDeclarations() : Vector.<FontDeclaration> {
			var res : Vector.<FontDeclaration> = new Vector.<FontDeclaration>( );
			
			if( style_normal )
				res.push( new FontDeclaration( getClassName( false , false ) , getOutput( false , false ) ) );
			if( style_bold )
				res.push( new FontDeclaration( getClassName( true , false ) , getOutput( true , false ) ) );
			if( style_italic )
				res.push( new FontDeclaration( getClassName( false , true ) , getOutput( false , true ) ) );
			if( style_bolditalic )
				res.push( new FontDeclaration( getClassName( true , true ) , getOutput( true , true ) ) );
				
			return res;
		}

		private function getSource() : String {
			/*FDT_IGNORE*/
			if( _sourceFile != null )
				return "source='" + _sourceFile.nativePath.replace( /\\/g, "/" ) + "'";
			else if( _sourceName != null )
				return "systemFont='" + _sourceName + "'";
			else
				throw new Error( "FontConfig : sourceName or sourceFile must be defined" );	
			/*FDT_IGNORE*/
			return null;	
		}

		internal function getClassName( bold : Boolean, italic : Boolean ) : String {
			var fm : String = fontFamily.replace( " " , "_" );
			fm = fm.replace( "-" , "_" );
			var fs : String = italic ? "italic" : "normal";
			var fw : String = bold ? "bold" : "normal";
			return "_embed__font_" + fm + "_" + fw + "_" + fs;
		}

		internal function getOutput( bold : Boolean, italic : Boolean ) : String {
			
			var res : String = EMBED_TEMPLATE + "\n" + CLASS_TEMPLATE + "\n\n";
			
			var fss : String = "";
			if( italic )
				fss += "fontStyle='italic', ";
			if( bold )
				fss += "fontWeight='bold', ";
			
			res = res.replace( /\$\{fontStyles\}/g , fss );
			
			res = res.replace( /\$\{unicodeRange\}/g , transcodeRange() );
			res = res.replace( /\$\{fontName\}/g , fontFamily );
			res = res.replace( /\$\{source\}/g , getSource( ) );
		
			res = res.replace( /\$\{className\}/g , getClassName( bold , italic ) );
		
			return res;
		}
		


		private function transcodeRange() : String {
			var res : String = "";
			
			_unicodeRange.sort( Array.NUMERIC );
			var prevval : int = -10;
			var val : uint;
			var currRangeStart : uint = _unicodeRange[0];
			for (var i : int = 0; i < _unicodeRange.length; i++) {
				val = _unicodeRange[ i ];
				
				if( prevval != -10 && val != prevval+1 ) {
					if( currRangeStart != prevval ) 
						res += toUnicodeHex( currRangeStart ) + "-" +toUnicodeHex( prevval )+",";
					else
						res += toUnicodeHex( prevval ) +",";
						
					
					currRangeStart = val;
				}
				prevval = val;
			}
			
			if( currRangeStart != prevval ) 
				res += toUnicodeHex( currRangeStart ) + "-" +toUnicodeHex( prevval )+",";
			else
				res += toUnicodeHex( prevval ) +",";
			
			return res;
		}
		
		private function toUnicodeHex( val : uint ) : String {
			var str : String  = val.toString( 16 );
			while( str.length < 4 )str = "0"+str;
			return "U+" + str;
		}

		
		


		private static const EMBED_TEMPLATE : String = "[Embed(${fontStyles} unicodeRange='${unicodeRange}', fontName='${fontName}', ${source}, _pathsep='true', mimeType='application/x-font')]";

		private static const CLASS_TEMPLATE : String = "private static var ${className}:Class;";

		
		
		
		
		public function export() : XML {
			var res : XML = <font normal={style_normal} bold={style_bold} italic={style_italic} bolditalic={style_bolditalic}/>;
			
			var range : XML = <range/>;
			var rstr : String = "";
			for (var i : int = 0; i < unicodeRange.length ; i++) {
				rstr += String.fromCharCode( unicodeRange[i] );
			}
			
			range.appendChild( rstr );
			res.appendChild( range );
			
			if( _sourceFile != null )
				res.appendChild(<source>{_sourceFile.nativePath}</source> );
			else if( _sourceName != null )
				res.appendChild(<systemFont>{_sourceName}</systemFont> );
			
			res.appendChild(<fontfamily>{fontFamily}</fontfamily> );
			
			return res;
		}
		
		
		private function _import(datas : XML) : void {
			
			style_normal = datas.@normal == "true";
			style_bold = datas.@bold == "true";
			style_italic = datas.@italic == "true";
			style_bolditalic = datas.@bolditalic == "true";
			
			setChars( datas.range.text() );
			
			if( datas.source.length() > 0 )
				_sourceFile = new File( datas.source[0].text() );
			else if( datas.systemFont.length() > 0 )
				_sourceName = datas.systemFont[0].text();
			
			fontFamily = datas.fontfamily[0].text();
			
		}
		
	}
}