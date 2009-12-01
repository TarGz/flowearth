package fr.digitas.flowearth.csseditor.view.console {
	import flash.system.System;	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;	

	/**
	 * @author Pierre Lepers
	 */
	public class Infos extends Sprite {
		
		private var tf : TextField;
		
		public function Infos() {
			
			tf = new TextField( );
			tf.defaultTextFormat = new TextFormat( "Arial", 11 );
			tf.multiline = true;
			tf.wordWrap = true;
			tf.background = true;
			tf.backgroundColor = 0xededed;
			tf.height = 60;
			addChild( tf );
			
			addEventListener( Event.ADDED_TO_STAGE, onAdded );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemoved );
		}
		
		private function onAdded( e : Event ) : void {
			addEventListener( Event.ENTER_FRAME , _oef );
		}
		
		private function onRemoved( e : Event ) : void {
			removeEventListener( Event.ENTER_FRAME , _oef );
		}
		
		private function _oef(event : Event) : void {
			tf.text = "Memory usage : "+int( System.totalMemory/1000 );
		}

		override public function set width(value : Number) : void {
			tf.width = value;
			
		}

		override public function set height(value : Number) : void {
			tf.height = value;
		}
	}
}
