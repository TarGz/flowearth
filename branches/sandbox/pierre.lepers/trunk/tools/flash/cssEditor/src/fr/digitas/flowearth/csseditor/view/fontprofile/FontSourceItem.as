package fr.digitas.flowearth.csseditor.view.fontprofile {
	import fr.digitas.flowearth.csseditor.data.fonts.FontSource;
	import fr.digitas.flowearth.csseditor.event.FontEvent;
	import fr.digitas.flowearth.csseditor.view.picts.Picts;
	import fr.digitas.flowearth.font.FontInfo;
	import fr.digitas.flowearth.ui.tree.TreeItem;
	import fr.digitas.flowearth.ui.tree.TreeItem_FC;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;	

	/**
	 * @author Pierre Lepers
	 */
	public class FontSourceItem extends TreeItem {

		public function FontSourceItem( ) {
			super();
		}

		public function init( source : FontSource ) : void {
			_source = source;
			label.text = source.file.name;
			icon.bitmapData = getIconForType( );
			bg.visible = false;
			
			if( source.loaded )
				onSourceLoaded( );
			
			source.addEventListener( FontEvent.FONT_LOADED , onSourceLoaded );
			source.addEventListener( FontEvent.FONT_UNLOADED , onSourceUnloaded );
				
			source.profile.addEventListener( FontEvent.SELECTION_CHANGE , onSelectionChange );
			onSelectionChange( null );
			
			if( _source.configurable() ) {
				label.addEventListener( MouseEvent.DOUBLE_CLICK , onDoubleClick );
				_source.getConfig().addEventListener( Event.CHANGE, onConfigChange );
				_dragManager = new FSDragManager();
				_dragManager.init( this );
			}
		}
		
		public override function dispose() : void {
			super.dispose();
			_source.removeEventListener( FontEvent.FONT_LOADED , onSourceLoaded );
			_source.removeEventListener( FontEvent.FONT_UNLOADED , onSourceUnloaded );
			_source.profile.removeEventListener( FontEvent.SELECTION_CHANGE , onSelectionChange );
			if( _source.configurable() ) 
				_source.getConfig().removeEventListener( Event.CHANGE, onConfigChange );
			_source = null;
			
			if( _dragManager )
				_dragManager.dispose();
				
			_dragManager = null;
		}
		
		
		
		
		private function onDoubleClick(event : MouseEvent) : void {
			_source.getConfig( ).openPanel();
		}

		override protected function onClick(event : MouseEvent) : void {
			_source.profile.selectedSource = _source;
		}

		private function onSourceUnloaded(event : FontEvent) : void {
			clearLayout();
		}
		
		private function onConfigChange(event : Event) : void {
			createTree();
		}

		private function onSourceLoaded(event : FontEvent = null ) : void {
			createTree();
		}
		
		private function createTree() : void {
			
			clearLayout();
			var fontItem : FontItem;
			var cinfos : Vector.<FontInfo>;
			var infos : Vector.<FontInfo>;
			var item : FontInfo;
			
			if( _source.configurable() && _source.getInfos() ) {
				
				cinfos = _source.getConfig().getFontInfos();
				infos = _source.getInfos().getFontInfos();
				
				for (var i : int = 0; i < cinfos.length; i++) {
					item = cinfos[ i ];
					fontItem = new FontItem( );
					fontItem.collapse( false );
					fontItem.init( item );
					if( ! _source.getInfos().hasInfoByName( item.fontFamily ) ) {
						fontItem.label.textColor = 0x808080;
						fontItem.label.text = "+> "+fontItem.label.text;
					}
					addSubitem( fontItem );
				}
				
				

				for ( i = 0; i < infos.length; i++) {
					item = infos[ i ];
					if( _source.getConfig().hasInfoByName( item.fontFamily ) ) continue;
					fontItem = new FontItem( );
					fontItem.collapse( false );
					fontItem.init( item );
					fontItem.label.text = "<- "+fontItem.label.text;
					fontItem.label.textColor = 0xBB0000;	
					addSubitem( fontItem );
				}
				
			} else if( _source.configurable() ) {
				cinfos = _source.getConfig().getFontInfos();
				
				for ( i = 0; i < cinfos.length; i++) {
					item = cinfos[ i ];
					fontItem = new FontItem( );
					fontItem.collapse( false );
					fontItem.init( item );
					addSubitem( fontItem );
				}
			} else {
				cinfos = _source.getInfos().getFontInfos();
				
				for ( i = 0; i < cinfos.length; i++) {
					item = cinfos[ i ];
					fontItem = new FontItem( );
					fontItem.collapse( false );
					fontItem.init( item );
					addSubitem( fontItem );
				}
				
			}
			
			
			_subLayout.update( );
			updateTree();
			dispatchEvent( new Event( Event.RESIZE ) );
			
		}

		
		
		private function clearLayout() : void {
			while( _subLayout.numChildren > 0 )
				removeSubitem( _subLayout.getChildAt( 0 ) as FontItem );

			dispatchEvent( new Event( Event.RESIZE ) );
		}

		
		private function getIconForType() : BitmapData {
			if( _source.configurable( ) )
				return Picts.SWF_CONF_FONT_FILE;
			else
				return Picts.SWF_FONT_FILE;
		}
		
	
		
		private function onSelectionChange(event : FontEvent) : void {
			label.backgroundColor = 0xe2e2e2;
			label.background = _source.selected();
		}
		

		private var _source : FontSource;
		
		private var _dragManager : FSDragManager;

		public function dropIn( flag : Boolean) : void {
			if( flag ) {
				label.backgroundColor = 0xbebebe;
				label.background = true;
			} else
				onSelectionChange( null );
		}
		
		internal function get source() : FontSource {
			return _source;
		}
	}
}
