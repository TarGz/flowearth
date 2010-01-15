package fr.digitas.flowearth.csseditor.view.preview {
	import flash.display.BitmapData;	
	import flash.display.Shape;
	
	/**
	 * @author Pierre Lepers
	 */
	public class DottedLine extends Shape {

		
		public function DottedLine( horizontal : Boolean = true ) {
			_horizontal = horizontal;
		}

		public function set size ( val : int ) : void {
			graphics.clear();
			graphics.beginBitmapFill( motif, null, true, false );
			
			if( _horizontal ) 
				graphics.drawRect( 0 , 0 , val , 1 );
			else			
				graphics.drawRect( 0 , 0 , 1 , val );
		}
		
		private var _horizontal : Boolean;
		
		private static const motif : BitmapData = _buildMotif();
		private static function _buildMotif() : BitmapData {
			var bmp : BitmapData = new BitmapData( 2, 2, true, 0 );
			bmp.setPixel32(0, 0, 0x80000000);
			bmp.setPixel32(1, 1, 0x80000000);
			return bmp;
		}
	}
}
