package fr.digitas.flowearth.csseditor.view.preview {
	import fr.digitas.flowearth.csseditor.App;
	import fr.digitas.flowearth.csseditor.data.CSS;
	import fr.digitas.flowearth.csseditor.data.CSSProvider;
	import fr.digitas.flowearth.csseditor.data.StyleData;
	import fr.digitas.flowearth.csseditor.event.CSSEvent;
	import fr.digitas.flowearth.csseditor.event.FontEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;		

	/**
	 * @author Pierre Lepers
	 */
	public class Preview extends Sprite {

		
		public function Preview( ) {
			addEventListener( Event.ADDED_TO_STAGE, onAdded );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemoved );
			
			_build( );
		}
		
		
		override public function set width(value : Number) : void {
			inputside.width = renderside.width = Math.round( inputside.width = value/2 ) - 2;
			renderside.x = renderside.width + 2;
		}

		override public function set height(value : Number) : void {
			inputside.height =
			renderside.height = value;
		}
		
		//_____________________________________________________________________________
		//																		PRIVATE
		
		private function _build() : void {
			inputside = new InputSide();
			addChild( inputside );
			renderside = new RenderSide();
			addChild( renderside );
			inputside.addEventListener( Event.CHANGE , onTextChange );
			_initFontSystem( );
			onTextChange( null );
		}
		
		private function _initFontSystem( e : Event = null ) : void {
			App.getFontSystem().addEventListener( FontEvent.FONT_LOADED , _updateField );
			App.getFontSystem().removeEventListener( FontEvent.SANDBOX_READY, _updateField );
			var tf : TextField = App.getFontSystem().getSandboxedTf( );
			if( !tf ) { 
				tf = new TextField();
				tf.text = "not ready";
				App.getFontSystem().addEventListener( FontEvent.SANDBOX_READY, _updateField );
			}
			renderside.tf = tf;
		}
		
		private function _updateField( e : Event = null ) : void {
			var tf : TextField = App.getFontSystem().getSandboxedTf( );
			if( tf ) renderside.tf = tf;
		}

		
		
		
		private function onAdded( e : Event ) : void {
			CSSProvider.instance.addEventListener( CSSEvent.CURRENT_CHANGE , onCssChange );
			onCssChange(null);
		}

		private function onRemoved( e : Event ) : void {
			CSSProvider.instance.removeEventListener( CSSEvent.CURRENT_CHANGE , onCssChange );
			App.getFontSystem().removeEventListener( FontEvent.SANDBOX_READY, _initFontSystem );
		}
		
		
		private function onCssChange(event : CSSEvent) : void {
			if( _css ) {
				_css.datas.removeEventListener( CSSEvent.CURRENT_CHANGE , onFocusStyleChange );
				_css = null;
			}
			
			_css = CSSProvider.instance.currentCss;
			if( !_css ) return;
			
			_css.datas.addEventListener( CSSEvent.CURRENT_CHANGE , onFocusStyleChange );
			onFocusStyleChange( null );
		}
		
		private function onFocusStyleChange(event : CSSEvent) : void {
			if( _focusedStyle ) {
				_focusedStyle.removeEventListener( Event.CHANGE , onStyleChange );
			}
			
			_focusedStyle = _css.datas.currentStyle;
			
			if( _focusedStyle ) {
				_focusedStyle.addEventListener( Event.CHANGE , onStyleChange );
				onStyleChange( null );
			}
		}
		
		private function onStyleChange(event : Event) : void {
			renderside.setStyle( new QName( _css.filepath, _focusedStyle.getName() ) );
		}

		
		private function onTextChange(event : Event) : void {
			renderside.setText( inputside.getText() );
		}

		
		private var renderside : RenderSide;
		private var inputside : InputSide;

		private var _css : CSS;
		private var _focusedStyle : StyleData;
		
	}
}
