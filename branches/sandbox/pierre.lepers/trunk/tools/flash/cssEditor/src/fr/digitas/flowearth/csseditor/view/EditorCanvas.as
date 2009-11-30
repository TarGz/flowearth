package fr.digitas.flowearth.csseditor.view {
	import fr.digitas.flowearth.csseditor.data.CSSProvider;
	import fr.digitas.flowearth.csseditor.event.CSSEvent;
	import fr.digitas.flowearth.csseditor.view.editor.StyleEditor;
	import fr.digitas.flowearth.csseditor.view.editor.StyleTabs;
	import fr.digitas.flowearth.ui.canvas.Canvas;
	import fr.digitas.flowearth.ui.layout.LayoutAlign;
	
	import flash.events.Event;	

	/**
	 * @author Pierre Lepers
	 */
	public class EditorCanvas extends Canvas {
		
		public function EditorCanvas(align : String = LayoutAlign.TOP) {
			super( align );
			
			_buildViews();
			
			addEventListener( Event.ADDED_TO_STAGE, onAdded );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemoved );
		}
		

		private function onAdded( e : Event ) : void {
			CSSProvider.instance.addEventListener( CSSEvent.CURRENT_CHANGE , onCurrentChange );
		}
		

		private function onRemoved( e : Event ) : void {
			CSSProvider.instance.removeEventListener( CSSEvent.CURRENT_CHANGE , onCurrentChange );
			
		}
		
		private function onCurrentChange(event : CSSEvent) : void {
			cssEditor.setCss( event.css );
		}

		private function _buildViews() : void {
			// tabs
			cssTabs = new StyleTabs( );
			addContent( cssTabs );

			cssEditor = new StyleEditor( );
			addContent( cssEditor, true );
			
		}
		
		private var cssTabs : StyleTabs;
		private var cssEditor : StyleEditor;
	}
}
