package fr.digitas.flowearth.csseditor.view.fontprofile {
	import fr.digitas.flowearth.core.IIterator;
	import fr.digitas.flowearth.csseditor.data.fonts.FontProfile;
	import fr.digitas.flowearth.csseditor.data.fonts.FontSource;
	import fr.digitas.flowearth.csseditor.event.FontEvent;
	import fr.digitas.flowearth.ui.layout.Layout;
	import fr.digitas.flowearth.ui.layout.renderer.TopJustifyRenderer;
	import fr.digitas.flowearth.ui.tree.TreeItem;
	
	import flash.display.Sprite;
	import flash.utils.Dictionary;		

	/**
	 * @author Pierre Lepers
	 */
	public class FontsTable extends Sprite {

		public var bg : Sprite;

		public function FontsTable() {
			_buildLayout( );
			_itemMap = new Dictionary( );
		}

		
		public function init( profile : FontProfile ) : void {
			_profile = profile;
			_profile.addEventListener( FontEvent.FONT_ADDED , onFontAdded );
			_profile.addEventListener( FontEvent.FONT_REMOVED , onFontRemoved );
			onFontAdded( null );
		}

		
		override public function set width(value : Number) : void {
			_layout.width = value;
			_layout.update( );
		}

		override public function set height(value : Number) : void {
			_layout.height = value;
			_layout.update( );
		}

		private function onFontAdded(event : FontEvent) : void {
			var iter : IIterator = _profile.sources;
			var item : FontSource;
			var renderer : FontSourceItem;
			
			while( iter.hasNext( ) ) {
				item = iter.next( ) as FontSource;
				
				if( _itemMap[ item ] != undefined ) continue;
				
				renderer = new FontSourceItem( );
				renderer.init( item );
				_itemMap[ item ] = renderer;
				_layout.addChild( renderer );
			}
			_layout.update( );
		}

		
		private function onFontRemoved(event : FontEvent) : void {
			var source : FontSource = event.source;
			var view : FontSourceItem = _itemMap[ source ];
			if( view ) {
				_layout.removeChild( view );
				view.dispose();
				delete  _itemMap[ source ];
			}
		}

		public function dispose() : void {
			if( _profile ) {
				_profile.removeEventListener( FontEvent.FONT_ADDED , onFontAdded );
				_profile.removeEventListener( FontEvent.FONT_REMOVED , onFontRemoved );
			}
			
			while( _layout.numChildren > 0 ) {
				(_layout.getChildAt( 0 ) as TreeItem ).dispose();
				_layout.removeChildAt( 0 );
			}
				
			_profile = null;
			_itemMap = null;
		}

		private function _buildLayout() : void {
			_layout = new Layout( );
			_layout.renderer = new TopJustifyRenderer( );
			addChild( _layout );
		}

		
		private var _itemMap : Dictionary;

		private var _profile : FontProfile;

		private var _layout : Layout;
	}
}
