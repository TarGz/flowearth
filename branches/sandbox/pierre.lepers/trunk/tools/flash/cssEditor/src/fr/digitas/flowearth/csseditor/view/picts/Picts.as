package fr.digitas.flowearth.csseditor.view.picts {
	import fr.digitas.flowearth.csseditor.picts.AddStyle;
	import fr.digitas.flowearth.csseditor.picts.BuildPlay;
	import fr.digitas.flowearth.csseditor.picts.BuildRun;
	import fr.digitas.flowearth.csseditor.picts.BuildStop;
	import fr.digitas.flowearth.csseditor.picts.CollapseAll;
	import fr.digitas.flowearth.csseditor.picts.ErrorIco;
	import fr.digitas.flowearth.csseditor.picts.ExpandAll;
	import fr.digitas.flowearth.csseditor.picts.FontItem;
	import fr.digitas.flowearth.csseditor.picts.FontSettings;
	import fr.digitas.flowearth.csseditor.picts.InfoIcon;
	import fr.digitas.flowearth.csseditor.picts.Refresh;
	import fr.digitas.flowearth.csseditor.picts.Remove;
	import fr.digitas.flowearth.csseditor.picts.SwfConfigurableFontFile;
	import fr.digitas.flowearth.csseditor.picts.SwfFontFile;
	import fr.digitas.flowearth.csseditor.picts.WarnIco;
	
	import flash.display.BitmapData;		

	/**
	 * @author Pierre Lepers
	 */
	public class Picts {
		
		
		public static const WARN_ICO : BitmapData = new WarnIco( 0, 0 );
		public static const ERROR_ICO : BitmapData = new ErrorIco( 0, 0 );
		public static const INFO_ICO : BitmapData = new InfoIcon( 0 , 0 );
		
		
		public static const ADD_STYLE : BitmapData = new AddStyle( 0 , 0 );
		public static const EXPAND_ALL : BitmapData = new ExpandAll( 0 , 0 );
		public static const COLLAPSE_ALL : BitmapData = new CollapseAll( 0 , 0 );

		public static const SWF_FONT_FILE : BitmapData = new SwfFontFile( 0 , 0 );
		public static const SWF_CONF_FONT_FILE : BitmapData = new SwfConfigurableFontFile( 0 , 0 );
		public static const FONT_ITEM : BitmapData = new FontItem( 0 , 0 );
		public static const FONT_SETTING : BitmapData = new FontSettings( 0 , 0 );
		public static const REFRESH : BitmapData = new Refresh( 0 , 0 );
		public static const REMOVE : BitmapData = new Remove( 0 , 0 );

		public static const BUILD_RUN : BitmapData = new BuildRun( 0 , 0 );
		public static const BUILD_PLAY : BitmapData = new BuildPlay( 0 , 0 );
		public static const BUILD_STOP : BitmapData = new BuildStop( 0 , 0 );
		
	}
}
