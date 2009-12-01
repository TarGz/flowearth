package fr.digitas.flowearth.csseditor.view.editor {
	import fr.digitas.flowearth.csseditor.data.StyleData;
	import fr.digitas.flowearth.csseditor.view.console.Console;
	import fr.digitas.flowearth.ui.layout.ILayoutItem;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;		

	/**
	 * @author Pierre Lepers
	 */
	public final class StyleItemRenderer extends Sprite implements ILayoutItem {
		
		public function StyleItemRenderer() {
			_buildView();
			
			addEventListener( FocusEvent.FOCUS_IN , focusIn );
			addEventListener( FocusEvent.FOCUS_OUT , focusOut );
			addEventListener( FocusEvent.MOUSE_FOCUS_CHANGE , mfocusChange );
		}

		
		
		
		internal function init( sData : StyleData ) : void {
			_header.init( sData );
			_list.init( sData );
		}

		override public function set width(value : Number) : void {
			_header.width = value;
			_list.width = value;
		}

		override public function set height(value : Number) : void {
			return;
			value;
		}
		

		
		public function getWidth() : Number {
			return 0;
		}
		
		public function getHeight() : Number {
			if( _collapse )
				return Math.round( _header.height );
			return Math.round( _list.height + _list.y );
		}
		
		public function dispose() : void {
			removeEventListener( FocusEvent.FOCUS_IN , focusIn );
			removeEventListener( FocusEvent.FOCUS_OUT , focusOut );
			removeEventListener( FocusEvent.MOUSE_FOCUS_CHANGE , mfocusChange );
			_header.cArrow.removeEventListener( MouseEvent.CLICK , switchCollapse );
			_header.dispose();
			_list.dispose( );
			_header = null;
			_list = null;
		}

		public function get collapse() : Boolean {
			return _collapse;
		}
		
		public function set collapse(collapse : Boolean) : void {
			if( _collapse == collapse ) return;
			_collapse = collapse;
			if( _collapse )
				removeChild( _list );
			else
				addChild( _list );
			_list.visible = ! _collapse;
			_header.collapse( _collapse );
			dispatchEvent( new Event( Event.RESIZE, true ) );
		}
		
		private var _collapse : Boolean = false;

		private function _buildView() : void {
			_header = new StyleHeader();
			_header.collapse( _collapse );
			_header.cArrow.addEventListener( MouseEvent.CLICK , switchCollapse );
			addChild( _header );

			_list = new PropertyList( );
			addChild( _list );
			_list.y = _header.height;

			_header.visible = 
			_list.visible = false;
		}

		private function switchCollapse(event : MouseEvent) : void {
			collapse = !collapse;
		}
		
		
		private function focusOut(event : FocusEvent) : void {
			if (_lockFocus ) {
//				_lockFocus = false;
				return;
			}
			if( event.relatedObject && contains( event.relatedObject ) ) return;
			_list.quickAddItem = false;
		}

		private function focusIn(event : FocusEvent) : void {
			if (_lockFocus ) {
				_lockFocus = false;
				return;
			}
			_list.quickAddItem = true;
		}
		
		
		private function mfocusChange(event : FocusEvent) : void {
			if( event.relatedObject && contains( event.relatedObject ) )
				_lockFocus = true;
		}

		private var _lockFocus : Boolean = false;
		private var _header : StyleHeader;
		private var _list : PropertyList;
		
		private var _render : Boolean = false;
		
		public function get render() : Boolean {
			return _render;
		}
		
		public function set render(render : Boolean) : void {
			if( render == _render ) return;
			_render = render;
			_header.visible = 
			_list.visible = render;
			_list.render = render;
		}
	}
}
