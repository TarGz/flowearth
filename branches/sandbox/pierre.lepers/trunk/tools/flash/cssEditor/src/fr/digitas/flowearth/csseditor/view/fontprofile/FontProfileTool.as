package fr.digitas.flowearth.csseditor.view.fontprofile {
	import fr.digitas.flowearth.csseditor.data.CSS;
	import fr.digitas.flowearth.csseditor.event.FontEvent;
	import fr.digitas.flowearth.csseditor.view.picts.Picts;
	import fr.digitas.flowearth.ui.toobar.ToolBar;
	import fr.digitas.flowearth.ui.toobar.ToolBarButton;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TextEvent;	

	/**
	 * @author Pierre Lepers
	 */
	public class FontProfileTool extends Sprite {

		public function FontProfileTool() {
			_build( );
		}

		public var bg : Sprite;

		public function setCss( css : CSS ) : void {
			_css = css;
			_css.fontProfile.addEventListener( FontEvent.SELECTION_CHANGE , onSelectedFontChange );
			onSelectedFontChange( null );
		}
		
		private function onSelectedFontChange(event : FontEvent) : void {
			if( _css.fontProfile.selectedSource ) {
				if( _css.fontProfile.selectedSource.configurable() ) {
					_btn_remove.mouseEnabled = 
					_btn_config.mouseEnabled = 
					_btn_rebuild.mouseEnabled = true;
				} else {
					_btn_config.mouseEnabled = 
					_btn_rebuild.mouseEnabled = false;
				}
				_btn_remove.mouseEnabled = true;
			} else {
				_btn_remove.mouseEnabled = 
				_btn_config.mouseEnabled = 
				_btn_rebuild.mouseEnabled = false;
			}
		}

		
		override public function set width(value : Number) : void {
			bg.width = value;
			_rightTb.x = value - _rightTb.width -4;
		}

		override public function get height() : Number {
			return bg.height;
		}

		private function _build() : void {
			_leftTb = new ToolBar( );
			_rightTb = new ToolBar( );

			addChild( _rightTb );
			addChild( _leftTb );

			_leftTb.y = -2;
			_rightTb.width = 200;
			
			_leftTb.addButton( "addfontfile" , null , Picts.ADD_STYLE );

			_btn_remove = _rightTb.addButton( "remove" , null , Picts.REMOVE );
			_btn_config = _rightTb.addButton( "configure" , null , Picts.FONT_SETTING );
			_btn_rebuild = _rightTb.addButton( "rebuild" , null , Picts.BUILD_PLAY );
			_btn_rebuildAll = _rightTb.addButton( "rebuildAll" , null , Picts.REFRESH );
			
			
			_leftTb.addEventListener( Event.SELECT , onClick );
			_rightTb.addEventListener( Event.SELECT , onClick );
		}

		private function onClick(event : TextEvent ) : void {
			if( _css == null ) return;
			switch ( event.text ) {
				case "addfontfile": 
					_css.fontProfile.addNewFont();
					break;
				case "remove":
				  _css.fontProfile.removeSource( _css.fontProfile.selectedSource );
					break;
				case "configure":
				 	_css.fontProfile.selectedSource.getConfig().openPanel();
					break;
				case "rebuild":
				 	_css.fontProfile.selectedSource.getConfig().build();
					break;
				case "rebuildAll":
				 	_css.fontProfile.rebuildAll();
					break;
			}
		}

		private var _leftTb : ToolBar;

		private var _rightTb : ToolBar;

		private var _css : CSS;
		
		private var _btn_remove : ToolBarButton;
		private var _btn_config : ToolBarButton;
		private var _btn_rebuild : ToolBarButton;
		private var _btn_rebuildAll : ToolBarButton;
	}
}
