package fr.digitas.flowearth.ui.form {
	import fr.digitas.flowearth.ui.form.InputField;
	
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.ui.Keyboard;	

	/**
	 * @author Pierre Lepers
	 */
	public class CompletionInputField extends InputField {

		
		public function CompletionInputField(tf : TextField) {
			super( tf );
			_tf.addEventListener( Event.ADDED_TO_STAGE, onAdded );
			_tf.addEventListener( Event.REMOVED_FROM_STAGE, onRemoved );
		}

		override protected function onAdded( e : Event ) : void {
			super.onAdded(e);
		}
		
		override protected function onRemoved( e : Event ) : void {
			super.onRemoved( e );
			if( _completionList ) _destroyList();
		}

		public function setProvider( provider : CompletionProvider ) : void {
			_provider = provider;
		}
		
		override protected function keyDown(event : KeyboardEvent) : void {
			super.keyDown( event );
			if( event.ctrlKey && event.keyCode == Keyboard.SPACE ) {
				onCtrlSpace();
			}
			if( event.keyCode == Keyboard.DOWN ) {
				onArrowDown();
			}
			if( event.keyCode == Keyboard.UP ) {
				onArrowUp();
			}
		}
		
		
		private function onArrowUp() : void {
			if( _completionList )
				_completionList.focusIndex --;
		}

		private function onArrowDown() : void {
			if( _completionList )
				_completionList.focusIndex ++;
		}

		override protected function onTextChange(event : Event) : void {
			super.onTextChange( event );
			if( _completionList && ! _lockChange )
				_updateList(  );
		}
		
//		override protected function onTextInput(event : TextEvent) : void {
//			if( _lockInput ) event.preventDefault();
//			
//		}

		override protected function focusOut(event : FocusEvent) : void {
			super.focusOut( event );
			if( ! _tf.stage ) return;

			if( _completionList && event.relatedObject ) {
				if( _completionList.contains( event.relatedObject ) )
					return;
			}

			_destroyList();
		}

		override protected function onEnterKey() : void {
			if( _completionList ) {
				tf.text = _completionList.getFocusedItem( )._cdata.completion;
				dispatchEvent( new Event( Event.CHANGE ) );
				_destroyList();
			}
			super.onEnterKey( );
		}

		private function onCtrlSpace() : void {
			if( _completionList ) return;
			_updateList( null, true );
		}
		
		private function fillResult( result : String ) : void {
			var l : int = tf.length;
			_lockChange = true;
			tf.text = result;
			tf.setSelection( l , result.length );
			_lockChange = false;
		}

		private function _buildList( results : Array ) : void {
			if( _completionList ) {
				_completionList.populate( results );
				return;
			}
			if( ! _tf.stage ) return;
			_completionList = new CompletionList_FC( );
			_tf.stage.addChild( _completionList );
			var pos : Point = _tf.localToGlobal( new Point( 0, 0 + tf.height ) );
			_completionList.x = pos.x;
			_completionList.y = pos.y;
			_completionList.width = 180;
			_completionList.height = 250;
			_completionList.populate( results );
		}

		private function _destroyList() : void {
			if( ! _completionList ) return;
			_tf.stage.removeChild( _completionList );
			_completionList = null;
		}
		
		private function _updateList( value : String = null, fillIfOne : Boolean = false ) : void {
			var caretSub : String;
			if( value ) 
				caretSub = value;
			else
				caretSub = tf.text.substr( 0 , tf.selectionEndIndex );
			
			var matched : Array = _provider.getFilteredItems( caretSub );
			if( matched.length == 0 )
				_destroyList();
			else if( matched.length == 1 ) {
				if (fillIfOne) fillResult( matched[ 0 ].completion );
				if( _completionList ) _completionList.populate( matched );
			} else {
				_buildList( matched );
			}
		}

		
		
		
		
		private var _provider : CompletionProvider;
		
		private var _completionList : CompletionList;
		
		private var _lockChange : Boolean = false;
	}
}
