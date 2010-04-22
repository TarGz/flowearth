package fr.digitas.flowearth.csseditor.view {
	import fr.digitas.flowearth.csseditor.view.console.Infos_FC;	
	import fr.digitas.flowearth.csseditor.view.preview.Preview;	
	import fr.digitas.flowearth.csseditor.view.console.Infos;	
	import fr.digitas.flowearth.csseditor.view.console.Console;
	import fr.digitas.flowearth.ui.canvas.Canvas;
	import fr.digitas.flowearth.ui.canvas.CanvasLayout;
	import fr.digitas.flowearth.ui.canvas.HLayout;
	import fr.digitas.flowearth.ui.canvas.MasterCanvas;
	import fr.digitas.flowearth.ui.canvas.VLayout;
	
	import flash.display.Sprite;
	import flash.events.Event;	

	/**
	 * @author Pierre Lepers
	 */
	public class MainLayout extends Sprite {
		
		public function MainLayout() {
			_build( );
		}
		
		private function _build() : void {
			
			_mainLayout = new HLayout();
			
			
			// LEFT LAYOUT
			var leftLayout : CanvasLayout = new VLayout( );
			
			_editorCanvas = new MasterCanvas();
			_bottomCanvas = new MasterCanvas();
			
			leftLayout.addCanvas( _editorCanvas );
			leftLayout.addCanvas( _bottomCanvas );
			
			_editorCanvas.height = 250;
			_bottomCanvas.height = 250;
			

			// TOOLs LAYOUT
			_rtoolsCanvas = new VLayout();
			
			var _TrtoolCanvas : Canvas = new MasterCanvas();
			var _T2rtoolCanvas : Canvas= new MasterCanvas( );
			var _BrtoolCanvas : Canvas= new MasterCanvas( );
			_rtoolsCanvas.addCanvas( _TrtoolCanvas );
			_rtoolsCanvas.addCanvas( _T2rtoolCanvas );
			_rtoolsCanvas.addCanvas( _BrtoolCanvas );

			_BrtoolCanvas.height = 300;
			_T2rtoolCanvas.height = 300;
			_TrtoolCanvas.height = 300;
			// MAIN LAYOUT

			_mainLayout.addCanvas( leftLayout );
			_mainLayout.addCanvas( _rtoolsCanvas );
			
			leftLayout.width = 250;
			_rtoolsCanvas.width = 250;
			
			addChild( _mainLayout );
			addEventListener( Event.ADDED_TO_STAGE , onAdded );
			addEventListener( Event.REMOVED_FROM_STAGE , onRemoved );
			
			
			// CONSOLE
			_bottomCanvas.addContent( new PreviewCanvas( ) , true );

			// EDITOR CANVAS
			_editorCanvas.addContent( new EditorCanvas(), true );

			// EDITOR CANVAS
			var fpc : FontProfileCanvas = new FontProfileCanvas( );
			_TrtoolCanvas.addContent( fpc, true );
			var bc : BuildsCanvas = new BuildsCanvas( );
			_T2rtoolCanvas.addContent( bc, true );
			
			fpc.height = 300;
			bc.height = 300;
			
			_BrtoolCanvas.addContent( new Infos_FC( ) );
			_BrtoolCanvas.addContent( Console.instance , true );
//			_rtoolsCanvas.addContent( new Preview( ), true );
		}

		
		private function onAdded( e : Event ) : void {
			stage.addEventListener( Event.RESIZE , onResize );
		}

		private function onRemoved( e : Event ) : void {
			stage.removeEventListener( Event.RESIZE , onResize );
		}

		private function onResize(event : Event) : void {
			
			_mainLayout.width = stage.stageWidth;
			_mainLayout.height = stage.stageHeight;
			
		}

		private var _mainLayout : CanvasLayout;
		private var _rtoolsCanvas : CanvasLayout;

		private var _editorCanvas : Canvas;
		private var _bottomCanvas : Canvas;
		
	}
}
