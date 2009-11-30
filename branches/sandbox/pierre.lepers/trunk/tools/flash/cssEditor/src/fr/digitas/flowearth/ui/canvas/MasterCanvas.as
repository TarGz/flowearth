package fr.digitas.flowearth.ui.canvas {
	import flash.geom.Rectangle;	
	import flash.display.Sprite;	
	
	import fr.digitas.flowearth.ui.canvas.Canvas;
	import fr.digitas.flowearth.ui.layout.LayoutAlign;	

	/**
	 * @author Pierre Lepers
	 */
	public class MasterCanvas extends Canvas {
		public function MasterCanvas(align : String = LayoutAlign.TOP) {
			super( align );
			addChildAt( bg = new CanvasBg_FC( ) , 0 );
			padding = new Rectangle( 4, 4, 4, 4);
		}

		override public function set width(value : Number) : void {
			bg.width = value;
			super.width = value;
		}
		

		override public function set height(value : Number) : void {
			bg.height = value;
			super.height = value;
		}
		
		protected var bg : Sprite;
	}
}
