package fr.digitas.flowearth.font.view {
	import fl.controls.ComboBox;
	
	import fr.digitas.flowearth.csseditor.view.fontprofile.details.RangeProvider;
	import fr.digitas.flowearth.font.FontConfig;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.text.Font;		

	/**
	 * @author Pierre Lepers
	 */
	public class FontView extends FontView_FC {
		
//		public var unicoderange_tf : TextArea;
//		public var chars_tf : TextArea;
//		public var style_normal_cb : CheckBox;
//		public var style_italic_cb : CheckBox;
//		public var style_bold_cb : CheckBox;
//		public var style_bolditalic_cb : CheckBox;
//		public var charset_cb : ComboBox;
//		public var fontname_tf : TextInput;
//		public var fontfamily_cb : ComboBox;
		
		public function FontView( fontConfig : FontConfig ) {
			_fontConfig = fontConfig;
			_build( );
			addEventListener( Event.ADDED_TO_STAGE, onAdded );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemoved );
		}

		private function onAdded( e : Event ) : void {
			_fontConfig.addEventListener( Event.CHANGE , update );
			update( null );
		}
		
		private var rangeProvider : RangeProvider;

		private function onRemoved( e : Event ) : void {
			_fontConfig.removeEventListener( Event.CHANGE , update );
		}
		

		public function get fontConfig() : FontConfig {
			return _fontConfig;
		}
		
		public function dispose() : void {
			
		}

		private function update(event : Event) : void {
			
			style_bold_cb.selected = _fontConfig.style_bold;
			style_bolditalic_cb.selected = _fontConfig.style_bolditalic;
			style_italic_cb.selected = _fontConfig.style_italic;
			style_normal_cb.selected = _fontConfig.style_normal;
			
			var charStr : String = "";
			var charcode : uint;
			for (var i : int = 0; i < _fontConfig.unicodeRange.length ; i++) {
				charcode = _fontConfig.unicodeRange[ i ];
				charStr += String.fromCharCode( charcode );
			}
			
			chars_tf.text = charStr;
			
			if( _fontConfig.fontFamily )
				fontname_tf.text = _fontConfig.fontFamily;
			
			if( _fontConfig.sourceName ) {
				for ( i = 0; i < fontfamily_cb.dataProvider.length ; i++) {
					var item : Object = fontfamily_cb.dataProvider.getItemAt( i );
					if( item.label == _fontConfig.sourceName ) {
						fontfamily_cb.selectedIndex = i;
						break;
					}
				}
			} else if (_fontConfig.sourceFile )
				fileInput.text = _fontConfig.sourceFile.nativePath;
			
			
			
		}

		
		
		private function _build() : void {
			
			// systemFontCb
			
			for each (var f : Font in getSystemFonts() ) {
				fontfamily_cb.addItem( { label : f.fontName,data : f.fontName } );
			}
			
			// range preset
			charset_cb.dropdown.allowMultipleSelection = true;
			rangeProvider = new RangeProvider( null );
			var presets : Array = rangeProvider.getPresetRangesIds();
			for (var i : int = 0; i < presets.length; i++) {
				charset_cb.addItem( {label : presets[i],data : presets[i] } );
			}
			
			if( fontConfig.unicodeRange ) {
//				_fillUnicode();
//				_fillChars();
			}
			
			fontfamily_cb.addEventListener( Event.CHANGE , onSourceNameChange );
			fontname_tf.addEventListener( Event.CHANGE, onFontfamilyChange );
			
			charset_cb.addEventListener( Event.CHANGE, onCharsetChange );
			chars_tf.addEventListener( Event.CHANGE, onCharsChange );
			fileInput.addEventListener( Event.CHANGE, onFileInputChange );
			
			
			style_normal_cb.addEventListener( Event.CHANGE , onSNormalChange );
			style_bold_cb.addEventListener( Event.CHANGE , onSBoldChange );
			style_italic_cb.addEventListener( Event.CHANGE , onSItalicChange );
			style_bolditalic_cb.addEventListener( Event.CHANGE , onSBIChange );
			
			fileBrowse.addEventListener( MouseEvent.CLICK , browseTtf );
			
			rb_system.groupName = rb_ttf.groupName = Math.random()*100000 +"";
			
			if( _fontConfig.sourceName ) 
				rb_system.selected = true;
			else
				rb_ttf.selected = true;
			
			rb_system.group.addEventListener( Event.CHANGE , onSourceTypeChange );
			onSourceTypeChange( null );
		}
		
		private function onFileInputChange(event : Event) : void {
			_fontConfig.sourceFile = new File( fileInput.text );
		}

		private function browseTtf(event : MouseEvent) : void {
			var baseDir : File = File.desktopDirectory;
			baseDir.browseForOpen( "Open true type font" );
			baseDir.addEventListener( Event.SELECT , onOutputSelected );
		}

		private function onOutputSelected(event : Event) : void {
			event.currentTarget.removeEventListener( Event.SELECT , onOutputSelected );
			var f : File = event.target as File;
			_fontConfig.sourceFile = f;
		}

		private function onSourceTypeChange(event : Event) : void {
			if( rb_system.group.selection == rb_system ) {
				lbl_system.enabled = fontfamily_cb.enabled = true;
				lbl_ttf.enabled = fileBrowse.enabled = fileInput.enabled = false;
				
			} else {
				lbl_system.enabled = fontfamily_cb.enabled = false;
				lbl_ttf.enabled = fileBrowse.enabled = fileInput.enabled = true;
			}
		}

		private function onCharsChange(event : Event) : void {
			_fontConfig.setChars(chars_tf.text );
		}

		private function onCharsetChange(event : Event) : void {
			var items : Array = charset_cb.dropdown.selectedItems;
			var chars : Vector.<uint> = new Vector.<uint>();
			var range : Vector.<uint>;
			for each (var item : Object in items) {
				range = rangeProvider.getRange( item.label );
				for each (var cc : uint in range) {
					if( chars.indexOf( cc ) == -1 ) 
						chars.push( cc );
				}
			}
			_fontConfig.setUnicodeRange(chars);
		}

		private function onSBIChange(event : Event) : void {
			_fontConfig.style_bolditalic = style_bolditalic_cb.selected;
		}

		private function onSItalicChange(event : Event) : void {
			_fontConfig.style_italic = style_italic_cb.selected;
		}

		private function onSBoldChange(event : Event) : void {
			_fontConfig.style_bold = style_bold_cb.selected;
		}

		private function onSNormalChange(event : Event) : void {
			_fontConfig.style_normal = style_normal_cb.selected;
		}
		

		private function onSourceNameChange(event : Event) : void {
			_fontConfig.sourceName = fontfamily_cb.selectedLabel;
		}

		private function onFontfamilyChange(event : Event) : void {
			_fontConfig.fontFamily = fontname_tf.text;
		}

		private var _fontConfig : FontConfig;
		
		private static function getSystemFonts() : Array {
			if( _asfo == null ) {
				_asfo = [];
				var _fonts : Array = Font.enumerateFonts( true );
				_fonts.sortOn( "fontName" );
				
				_asfo = _fonts;
				
			}
			return _asfo;
		}
		
		private static var _asfo : Array;
	}
}
