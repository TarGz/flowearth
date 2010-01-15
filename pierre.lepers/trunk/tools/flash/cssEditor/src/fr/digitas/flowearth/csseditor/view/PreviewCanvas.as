package fr.digitas.flowearth.csseditor.view {
	import fr.digitas.flowearth.csseditor.view.misc.CanvasHeader_FC;	
	import fr.digitas.flowearth.csseditor.view.preview.Preview;	
	import fr.digitas.flowearth.csseditor.view.misc.CanvasHeader;	
	import fr.digitas.flowearth.ui.canvas.Canvas;	
	
	/**
	 * @author Pierre Lepers
	 */
	public class PreviewCanvas extends Canvas {

		
		
		public function PreviewCanvas() {
			super();
			_buildViews( );
		}
		
		private function _buildViews() : void {
			_header = new CanvasHeader_FC( );
			_header.setLabel( "Preview" );
			addContent( _header );

			_preview = new Preview( );
			addContent( _preview , true );
		}

		private var _header : CanvasHeader;
		
		private var _preview : Preview;
	}
}
