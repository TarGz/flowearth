package fr.digitas.flowearth.font {
	import fl.controls.TextInput;

	import fr.digitas.flowearth.font.view.FontViewContainer;
	import fr.digitas.flowearth.process.flex.MxmlcProcess;
	import fr.digitas.flowearth.ui.layout.Layout;
	import fr.digitas.flowearth.ui.layout.renderer.TopRenderer;
	import fr.digitas.flowearth.ui.scroller.Scroller;
	import fr.digitas.flowearth.ui.scroller.Scroller_FC;

	import flash.desktop.NativeProcess;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.text.TextField;
	import flash.utils.Dictionary;		

	/**
	 * @author Pierre Lepers
	 */
	public class FontBuilder extends FontBuilder_FC {

		//		public var fileBrowse : Button;
		//
		//		public var fileName_title : TextField;
		//		public var viewContainer : MovieClip;
		//		public var className_input : TextInput;
		//		public var fileInput : TextInput;
		//		public var addFont : Button;

		public function FontBuilder( config : FontFileConfig = null, baseDir : File = null ) {
			if( baseDir ) {
				if( baseDir.isDirectory )
					_baseDir = baseDir;
				else
					_baseDir = baseDir.parent;
			} else {
				_baseDir = File.desktopDirectory;
			}
			
			if( config )
				_config = config;
			else 
				_config = new FontFileConfig( );
			
			
			_init( );
			initList( );
			
			_config.addEventListener( Event.CHANGE , _update );
			_config.addEventListener( FontConfigEvent.CONFIG_ADDED , onConfigAdded );
			_config.addEventListener( FontConfigEvent.CONFIG_REMOVED , onConfigRemoved );
			
			_update( );
			
			addEventListener( Event.ADDED_TO_STAGE , onAdded );
			addEventListener( Event.REMOVED_FROM_STAGE , onRemoved );
		}

		
		
		private function onAdded( e : Event ) : void {
			stage.addEventListener( Event.RESIZE , onResize );
			onResize( null );
		}

		private function onRemoved( e : Event ) : void {
			stage.removeEventListener( Event.RESIZE , onResize );
		}

		private function onResize(event : Event) : void {
			_scroller.height = stage.stageHeight - viewContainer.y;
			bg.height = stage.stageHeight;
		}

		public function buildFile( ) : NativeProcess {
			
			return MxmlcProcess.run( _config.getMxmlcConfig( ) );
		}

		private var _baseDir : File;

		
		private function _init() : void {
			
			
			_viewMap = new Dictionary( );
			
			fileBrowse.addEventListener( MouseEvent.CLICK , onFileBrowse );
			addFont.addEventListener( MouseEvent.CLICK , onAddFont );
			
			_scroller = new Scroller_FC( );
			_scroller.width = 419;
			_scroller.height = 419;
			viewContainer.addChild( _scroller );
			_buildLayout( );
			
			
			fileInput.addEventListener( Event.CHANGE , onFileInputChange );
			className_input.addEventListener( Event.CHANGE , onCNameInputChange );
		}

		private function onFileInputChange(event : Event) : void {
			_config.output = new File( fileInput.text );
		}

		private function onCNameInputChange(event : Event) : void {
			_config.className = className_input.text;
		}

		private function _buildLayout() : void {
			_layout = new Layout( );
			_layout.renderer = new TopRenderer( );
			
			_scroller.addChild( _layout );
			
			_layout.addEventListener( Event.CHANGE , onLayoutChange );
		}

		private function onLayoutChange(event : Event) : void {
			_scroller.update( );
		}

		
		
		private function onAddFont(event : MouseEvent) : void {
			var fconfig : FontConfig = new FontConfig( );
			_config.addConfig( fconfig );
		}

		private function onFileBrowse(event : MouseEvent) : void {
			_baseDir.browseForSave( "Save font's swf" );
			_baseDir.addEventListener( Event.SELECT , onOutputSelected );
		}

		private function onOutputSelected(event : Event) : void {
			event.currentTarget.removeEventListener( Event.SELECT , onOutputSelected );
			var f : File = event.target as File;
			_config.output = f;
		}

		private function _update( e : Event = null ) : void {
			
			if( _config.output ) {
				fileName_title.text = _config.output.name;
				fileInput.text = _config.output.nativePath;
				_baseDir = _config.output.parent;
			} else {
				fileName_title.text = "untitled.swf";
				fileInput.text = "untitled.swf";
			}
			
			if( _config.className )
				className_input.text = _config.className;
			else
				className_input.text = "untitled";
			
//			_checkFontList();
		}

		//		
		//		private function _checkFontList() : void {
		//			
		//			var fconfig : Vector.<FontConfig> = _config.getConfigs();
		//			
		//			var view : FontViewContainer;
		//			for (var i : int = _layout.numChildren-1; i >-1 ; i--) {
		//				view = _layout.getChildAt( i ) as FontViewContainer;
		//				if( fconfig.indexOf( view.fontConfig ) == -1 ) {
		//					view.dispose();
		//					_layout.removeChild( view );
		//				}
		//			}
		//			
		//			for ( i = 0; i < fconfig.length; i++) {
		//				if ( _viewMap[fconfig[i] ] == undefined ) {
		//					
		//					view = new FontViewContainer( fconfig[i] );
		//					_viewMap[ fconfig[i] ] = view;
		//					_layout.addChild( view );
		//					
		//				}
		//				
		//			}
		//		}

		
		private function initList() : void {
			var fconfig : Vector.<FontConfig> = _config.getConfigs( );
			var view : FontViewContainer;
			for ( var i : int = 0; i < fconfig.length ; i ++ ) {
				
				view = new FontViewContainer( fconfig[i] );
				_viewMap[ fconfig[i] ] = view;
				_layout.addChild( view );
			}
			_layout.update();
		}

		private function onConfigAdded(event : FontConfigEvent) : void {
			var view : FontViewContainer;
			view = new FontViewContainer( event.fontConfig );
			_viewMap[ event.fontConfig ] = view;
			_layout.addChild( view );
		}

		private function onConfigRemoved(event : FontConfigEvent) : void {
			_layout.removeChild( _viewMap[event.fontConfig] );
		}

		private var _config : FontFileConfig;

		
		private var _viewMap : Dictionary;

		private var _layout : Layout;

		private var _scroller : Scroller;		

		public function dispose() : void {
		}
	}
}