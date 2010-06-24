package fr.digitas.flowearth.ui.colorpicker {

	/**
	 * @author Pierre Lepers
	 */
	public class ColorUtils {

		public static function getColor( r : uint, g : uint, b : uint ) : uint {
			return (r<<16) + (g << 8) + b;
		}
	}
}
