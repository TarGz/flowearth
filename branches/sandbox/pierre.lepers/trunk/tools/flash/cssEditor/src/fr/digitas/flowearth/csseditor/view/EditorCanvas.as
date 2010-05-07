package fr.digitas.flowearth.csseditor.view {
	import fr.digitas.flowearth.csseditor.managers.CssDragManager;	
	import fr.digitas.flowearth.csseditor.view.editor.EditorToolBar_FC;	
	import fr.digitas.flowearth.csseditor.view.editor.EditorToolBar;	
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
			
			new CssDragManager( ).init( this );
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
				cssEditor.setCss( CSSProvider.instance.currentCss );
		}

		private function _buildViews() : void {
			// tabs
			cssTabs = new StyleTabs( );
			addContent( cssTabs );

			// tools
			cssTools = new EditorToolBar_FC( );
			addContent( cssTools );

			cssEditor = new StyleEditor( );
			addContent( cssEditor, true );
			
		}
		
		private var cssTabs : StyleTabs;
		private var cssTools : EditorToolBar;
		private var cssEditor : StyleEditor;
	}
}