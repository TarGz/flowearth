package fr.digitas.flowearth.ui.utils {
	import flash.display.Sprite;	
	
	import fl.managers.FocusManager;	
	import fl.controls.ComboBox;		

	/**
	 * @author Pierre Lepers
	 */
	public class FlUtils {

		public static function autoSizeCombo( cb : ComboBox ) : Number {
			
			var initIndex : int = cb.selectedIndex;
			
			var maxLength : Number = 0;
			var i : uint;
			for (i = 0; i < cb.length ; i ++) {
				cb.selectedIndex = i;
				cb.drawNow( );
				var currWidth : Number = cb.textField.textWidth;
				maxLength = Math.max( currWidth , maxLength );
			}
			
			cb.selectedIndex = initIndex;
			cb.width = cb.dropdownWidth = maxLength + 30;
			return maxLength + 30;
		}
		
		public static const nullFocusManager : FocusManager = new FocusManager( null );
	}
}
