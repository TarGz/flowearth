package fr.digitas.flowearth.csseditor.view.fontprofile.details {
	import fl.controls.ComboBox;
	
	import fr.digitas.flowearth.ui.utils.FlUtils;
	
	import flash.display.Sprite;
	import flash.events.Event;		

	/**
	 * @author Pierre Lepers
	 */
	public class RangeSelector extends Sprite {

		public var rangeCombo : ComboBox;

		
		public function get range() : Array {
			return _range;
		}
		
		public function RangeSelector( ) {
		}
		

		public function init( provider : RangeProvider ) : void {
			_provider = provider;
			
			var ranges : Array = _provider.getRangesIds();
			
			for (var i : int = 0; i < ranges.length; i++) {
				rangeCombo.addItem( { label: ranges[i], data: ranges[i] } );
			}
			
			FlUtils.autoSizeCombo( rangeCombo );
			
			rangeCombo.addEventListener( Event.CHANGE , onCbChange );
		}
		
		private function onCbChange(event : Event) : void {
			_range = _provider.getRange( rangeCombo.selectedLabel );
			dispatchEvent(event);
		}

		
		
		
		
		private var _range : Array;

		private var _provider : RangeProvider;
		
	}
}
