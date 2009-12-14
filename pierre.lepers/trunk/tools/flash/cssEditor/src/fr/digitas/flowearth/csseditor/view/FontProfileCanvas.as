package fr.digitas.flowearth.csseditor.view {
	import fr.digitas.flowearth.csseditor.data.CSSProvider;
	import fr.digitas.flowearth.csseditor.event.CSSEvent;
	import fr.digitas.flowearth.csseditor.view.fontprofile.FontProfileTool;
	import fr.digitas.flowearth.csseditor.view.fontprofile.FontProfileView;
	import fr.digitas.flowearth.ui.canvas.Canvas;
	import fr.digitas.flowearth.ui.layout.LayoutAlign;
	
	import flash.events.Event;	

	/**
	 * @author Pierre Lepers
	 */
	public class FontProfileCanvas extends Canvas {
		
		public function FontProfileCanvas(align : String = LayoutAlign.TOP) {
			super( align );
			
			_buildViews();
			
			addEventListener( Event.ADDED_TO_STAGE, onAdded );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemoved );
		}
		

		private function onAdded( e : Event ) : void {
			CSSProvider.instance.addEventListener( CSSEvent.CURRENT_CHANGE , onCurrentChange );
			onCurrentChange( null );
		}
		

		private function onRemoved( e : Event ) : void {
			CSSProvider.instance.removeEventListener( CSSEvent.CURRENT_CHANGE , onCurrentChange );
			
		}
		
		private function onCurrentChange(event : CSSEvent) : void {
			if( CSSProvider.instance.currentCss )
				fontProfileView.setCss( CSSProvider.instance.currentCss );
		}

		private function _buildViews() : void {
			// tabs
			fontProfileTools = new FontProfileTool( );
			addContent( fontProfileTools );

			fontProfileView = new FontProfileView( );
			addContent( fontProfileView, true );
			
		}
		
		private var fontProfileTools : FontProfileTool;
		private var fontProfileView : FontProfileView;
	}
}
