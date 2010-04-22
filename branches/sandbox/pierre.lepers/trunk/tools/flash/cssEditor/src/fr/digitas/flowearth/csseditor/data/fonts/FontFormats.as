package fr.digitas.flowearth.csseditor.data.fonts {
	import flash.filesystem.File;	
	
	/**
	 * @author Pierre Lepers
	 */
	public class FontFormats {

		
		public static const TTF : String = "ttf";
		public static const OTF : String = "otf";
		
		public static function containFontFiles( fileList : Array) : Boolean {
			
			for each (var file : File in fileList) {
				if( isFontFile( file ) ) return true;
			}
			
			return false;
		}

		public static function isFontFile( file : File ) : Boolean {
			return _formats.indexOf( String( file.name.split( "." ).pop()).toLowerCase() ) > - 1;
			
			
		}
		
		private static const _formats : Vector.<String> = _buildExtensionList();
		private static function _buildExtensionList() : Vector.<String> {
			var res : Vector.<String> = new Vector.<String>( 2, true );
			res[0] = TTF;
			res[1] = OTF;
			return res;
		}
	}
}
