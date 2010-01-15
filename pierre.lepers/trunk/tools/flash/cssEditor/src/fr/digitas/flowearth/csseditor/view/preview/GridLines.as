package fr.digitas.flowearth.csseditor.view.preview {
	import flash.geom.Rectangle;	
	import flash.display.DisplayObject;	
	import flash.display.Sprite;
	
	/**
	 * @author Pierre Lepers
	 */
	public class GridLines extends Sprite {
		
		public function GridLines() {
			_build( );
		}
		
		public function fit( _do : DisplayObject, bound : Rectangle ) : void {
			h2.size = h1.size = bound.width;
			v2.size = v1.size = bound.height;
			
			h1.x = h2.x = bound.x;
			h1.y = _do.y;
			h2.y = Math.round( _do.y + _do.height );

			v1.y = v2.y = bound.y;
			v1.x = _do.x;
			v2.x = Math.round( _do.x + _do.width );
		}

		
		
		private function _build() : void {
			addChild( h1 = new DottedLine() );
			addChild( h2 = new DottedLine() );
			addChild( v1 = new DottedLine( false ) );
			addChild( v2 = new DottedLine( false ) );
		}

		private var h1 : DottedLine;
		private var h2 : DottedLine;
		private var v1 : DottedLine;
		private var v2 : DottedLine;
	}
}
