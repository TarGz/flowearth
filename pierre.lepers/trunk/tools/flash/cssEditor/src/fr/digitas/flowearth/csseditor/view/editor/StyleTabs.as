package fr.digitas.flowearth.csseditor.view.editor {
	import fr.digitas.flowearth.core.IIterator;
	import fr.digitas.flowearth.csseditor.data.CSS;
	import fr.digitas.flowearth.csseditor.data.CSSProvider;
	import fr.digitas.flowearth.csseditor.event.CSSEvent;
	import fr.digitas.flowearth.csseditor.view.console.Console;
	import fr.digitas.flowearth.ui.tabs.CloseControl_FC;
	import fr.digitas.flowearth.ui.tabs.TabData;
	import fr.digitas.flowearth.ui.tabs.Tabs;
	import fr.digitas.flowearth.ui.tabs.Tabs_FC;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;	

	/**
	 * @author Pierre Lepers
	 */
	public class StyleTabs extends Sprite {
		
		public function StyleTabs() {
			
			tabs = new Tabs_FC();
			addChild( tabs );
			tabs.controls.addControl( new CloseControl_FC( ) );
			_dataMap = new Dictionary();
			build();
			CSSProvider.instance.addEventListener( CSSEvent.ADDED , onCssAdded );
			CSSProvider.instance.addEventListener( CSSEvent.REMOVED , onCssRemoved );
			CSSProvider.instance.addEventListener( CSSEvent.CURRENT_CHANGE , onCurrentChange );
			
			tabs.addEventListener( Event.CHANGE, onTabChange );
			onCurrentChange( null );
		}
		
		override public function set width(value : Number) : void {
			tabs.width = value;
		}

		override public function set height(value : Number) : void {
			tabs.height = value;
		}
		
		public function build() : void {
			
			clear( );
			_dataMap = new Dictionary();
			
			var iter : IIterator = CSSProvider.instance.getAllCss();
			var css : CSS;
			while( iter.hasNext() ) {
				css = iter.next() as CSS;
				addCss( css );
			}
		}
		
			
		private function onCssRemoved(event : CSSEvent) : void {
			removeCss( event.css );
		}

		private function onCssAdded(event : CSSEvent) : void {
			addCss( event.css );
		}
		
		private function onCurrentChange(event : CSSEvent) : void {
			if( CSSProvider.instance.currentCss )
				tabs.currentItem = getTabData( CSSProvider.instance.currentCss );
		}
		
		private function onTabChange( event : Event ) : void {
			if( !tabs.currentItem ) return;
			
			var css : CSS = ( tabs.currentItem as CssTabData ).css;
			CSSProvider.instance.currentCss = css;
		}
		
		private function addCss(css : CSS) : void {
			var tdata : TabData = new CssTabData( css );
			tabs.addItem( tdata );
		}

		private function removeCss(css : CSS) : void {
			var tdata : TabData = getTabData( css );
			if( tdata )
				tabs.removeItem( tdata );
		}
		
		private function getTabData( css : CSS ) : CssTabData {
			var tabData : CssTabData;
			for (var i : int = 0; i < tabs.length; i++) {
				tabData = tabs.getItemAt( i ) as CssTabData;
//				Console.log( tabData.label );
				if( tabData.css == css ) 
					return tabData;
				
			}
			return null;
		}

		private function clear() : void {
			var tabData : TabData;
			for (var i : int = 0; i < tabs.length; i++) {
				tabData = tabs.getItemAt( i );
				tabs.removeItem( tabData );
			}
		}

		private var tabs : Tabs;
		
		private var _dataMap : Dictionary;
	}
}

import fr.digitas.flowearth.csseditor.data.CSS;
import fr.digitas.flowearth.csseditor.event.CSSEvent;
import fr.digitas.flowearth.csseditor.view.console.Console;
import fr.digitas.flowearth.ui.tabs.TabData;

import flash.events.Event;

class CssTabData extends TabData {

	private var _css : CSS;
	
	public function CssTabData( css : CSS ) {
		super( css.filepath );
		_css = css;
		css.addEventListener( CSSEvent.PATH_CHANGE , onLabelChange );
		css.addEventListener( CSSEvent.FILE_SYNC , onLabelChange );
		addEventListener( Event.CLOSING , onClosing );
		addEventListener( Event.CLOSE , onClose );
		onLabelChange( );
	}
	
	private function onClose(event : Event) : void {
		_css.close(  );
	}

	private function onClosing(event : Event) : void {
		if( ! _css.fileSystemSync ) {
			Console.log( "JS popup for closing "+_css.filepath );
			event.preventDefault();
		}
		
	}

	private function onLabelChange(event : CSSEvent = null ) : void {
		var fname : String = _css.filepath;
		label = fname.substr( fname.lastIndexOf( "/") + 1 ) + ( _css.fileSystemSync ? "" : "*" );
	}

	public function get css() : CSS {
		return _css;
	}
}
