package fr.digitas.flowearth.csseditor.view.preview {
	import fr.digitas.flowearth.csseditor.data.StyleData;	
	
	import flash.text.TextFormat;	
	
	import fr.digitas.flowearth.csseditor.event.FontEvent;	
	
	import flash.text.TextField;	
	
	import fr.digitas.flowearth.csseditor.data.CSS;
	import fr.digitas.flowearth.csseditor.data.CSSProvider;
	import fr.digitas.flowearth.csseditor.event.CSSEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;	

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
		}
		
		
		private function onAdded( e : Event ) : void {
			CSSProvider.instance.addEventListener( CSSEvent.CURRENT_CHANGE , onCssChange );
		}

		private function onRemoved( e : Event ) : void {
			CSSProvider.instance.removeEventListener( CSSEvent.CURRENT_CHANGE , onCssChange );
		}
		
		
		private function onCssChange(event : CSSEvent) : void {
			if( _css ) {
				_css.datas.removeEventListener( CSSEvent.CURRENT_CHANGE , onFocusStyleChange );
				_css.fontsDatas.removeEventListener( FontEvent.SANDBOX_READY, onSandboxReady );
				_css = null;
			}
			
			_css = CSSProvider.instance.currentCss;
			if( !_css ) return;
			
			var tf : TextField = _css.fontsDatas.getSandboxedTf( );
			if( !tf ) { 
				tf = new TextField();
			}
			trace( "fr.digitas.flowearth.csseditor.view.preview.Preview - onCssChange -- ",tf );
			renderside.tf = tf;
			
			_css.fontsDatas.addEventListener( FontEvent.SANDBOX_READY, onSandboxReady );
			_css.datas.addEventListener( CSSEvent.CURRENT_CHANGE , onFocusStyleChange );
			onFocusStyleChange( null );
		}
		
		private function onSandboxReady(event : FontEvent) : void {
			var tf : TextField = _css.fontsDatas.getSandboxedTf( );
			trace( "fr.digitas.flowearth.csseditor.view.preview.Preview - onSandboxReady -- ", tf );
			renderside.tf = tf;
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

		
		
		private static var instance : Preview;
		
	}
}
