package fr.digitas.flowearth.csseditor.view.console {
	import fr.digitas.flowearth.csseditor.data.CSS;	
	import fr.digitas.flowearth.core.IIterator;	
	import fr.digitas.flowearth.csseditor.data.CSSProvider;	
	
	import flash.events.TimerEvent;	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;		

	/**
	 * @author Pierre Lepers
	 */
	public class Infos extends Sprite {
		
		public var tf : TextField;
		
		public var stressBtn : MovieClip;

		public function Infos() {
			
			tf.defaultTextFormat = new TextFormat( "Arial", 11 );
			tf.multiline = true;
			tf.wordWrap = true;
			tf.background = true;
			tf.backgroundColor = 0xededed;
			tf.height = 60;
			
			addEventListener( Event.ADDED_TO_STAGE, onAdded );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemoved );
			
			stressBtn.addEventListener( MouseEvent.CLICK , switchStressTest );
		}
		
		private function switchStressTest(event : MouseEvent) : void {
			_stress = ! _stress;
			if( _stressTimer ) {
				_stressTimer.stop();
				_stressTimer.removeEventListener( TimerEvent.TIMER , stressTick );
				_stressTimer = null;
			}
			if( _stress ) {
				_stressTimer = new Timer( 50 , 1000 );
				_stressTimer.start();
				_stressTimer.addEventListener( TimerEvent.TIMER , stressTick );
			}
		}
		
		private function stressTick(event : TimerEvent) : void {
			var iter : IIterator = CSSProvider.instance.getAllCss();
			var item : CSS;
			var all : Array  =[];
			while( iter.hasNext() ) {
				item	= iter.next() as CSS;
				all.push( item );
				if( CSSProvider.instance.currentCss == item ) {
					if( iter.hasNext() ) CSSProvider.instance.currentCss = iter.next() as CSS;
					else CSSProvider.instance.currentCss = all[0] as CSS;
					return;
				}
			}
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
		
		private var _stress : Boolean = false;
		
		private var _stressTimer : Timer;
		
	}
}
