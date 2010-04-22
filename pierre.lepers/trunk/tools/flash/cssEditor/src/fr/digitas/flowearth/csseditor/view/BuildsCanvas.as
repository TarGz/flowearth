package fr.digitas.flowearth.csseditor.view {
	import fr.digitas.flowearth.csseditor.view.builds.BuildsTools_FC;	
	import fr.digitas.flowearth.csseditor.view.builds.BuildsTools;
	import fr.digitas.flowearth.csseditor.view.builds.BuildsView;
	import fr.digitas.flowearth.csseditor.view.misc.CanvasHeader;
	import fr.digitas.flowearth.csseditor.view.misc.CanvasHeader_FC;
	import fr.digitas.flowearth.ui.canvas.Canvas;
	import fr.digitas.flowearth.ui.layout.LayoutAlign;
	
	import flash.events.Event;		

	/**
	 * @author Pierre Lepers
	 */
	public class BuildsCanvas extends Canvas {
		
		public function BuildsCanvas(align : String = LayoutAlign.TOP) {
			super( align );
			
			_buildViews();
			
			addEventListener( Event.ADDED_TO_STAGE, onAdded );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemoved );
		}
		

		private function onAdded( e : Event ) : void {
//			CSSProvider.instance.addEventListener( CSSEvent.CURRENT_CHANGE , onCurrentChange );
//			onCurrentChange( null );
		}
		

		private function onRemoved( e : Event ) : void {
//			CSSProvider.instance.removeEventListener( CSSEvent.CURRENT_CHANGE , onCurrentChange );
		}
		
		

		private function _buildViews() : void {
			
			_header = new CanvasHeader_FC( );
			_header.setLabel( "Builds" );
			addContent( _header );
			
						
			buildTools = new BuildsTools_FC( );
			addContent( buildTools );

			buildsView = new BuildsView( );
			addContent( buildsView, true );
			
		}
		
		private var _header : CanvasHeader;
		private var buildTools : BuildsTools;
		private var buildsView : BuildsView;
	}
}
