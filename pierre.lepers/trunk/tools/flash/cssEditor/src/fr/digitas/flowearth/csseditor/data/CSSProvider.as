package fr.digitas.flowearth.csseditor.data {
	import fr.digitas.flowearth.core.IIterator;
	import fr.digitas.flowearth.core.Iterator;
	import fr.digitas.flowearth.csseditor.event.CSSEvent;
	
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;		

	/**
	 * @author Pierre Lepers
	 */
	public class CSSProvider extends EventDispatcher {

		
		
		public function CSSProvider() {
			if( instance != null ) throw new Error( "fr.digitas.flowearth.csseditor.data.CSSProvider est deja instancié" );
			_dCss = new Dictionary( );
			_aCss = [];
		}
		
		public function addCss(css : CSS) : void {
			if( _dCss[ css.filepath ] != undefined ) {
				currentCss = _dCss[ css.filepath ];
				return;
			}
			_dCss[ css.filepath ] = css;
			_aCss.push( css );
			dispatchEvent( new CSSEvent( CSSEvent.ADDED, css ) );
			
			if( currentCss == null ) currentCss = css;
		}

		public function removeCss( css : CSS ) : void {
			if( _dCss[ css.filepath ] == undefined ) 
				 return;
				
			delete _dCss[ css.filepath ];
			_aCss.splice( _aCss.indexOf( css ) , 1 );
			dispatchEvent( new CSSEvent( CSSEvent.REMOVED, css ) );
			if( currentCss == css ) {
				if( _aCss.length>0 ) currentCss = _aCss[0];
				else currentCss = null;
			}
		}
		
		public function getAllCss() : IIterator {
			return new Iterator( _aCss );
		}

		
		
		//_____________________________________________________________________________
		//																		 currentCSS
		public function set currentCss ( css :  CSS ) : void {
			if( _currentCss ==css) return;
			_currentCss = css;
			dispatchEvent( new CSSEvent( CSSEvent.CURRENT_CHANGE , _currentCss ) );
		}
		public function get currentCss ( ) : CSS {
			return _currentCss;
		}
				
		private var _currentCss : CSS;
				
		

		private var _dCss : Dictionary;
		private var _aCss : Array;
		
		
		public static var instance : CSSProvider;
		
		public static function start( ) : CSSProvider {
			if (instance == null)
				instance = new CSSProvider();
			return instance;
		}
	}
}
