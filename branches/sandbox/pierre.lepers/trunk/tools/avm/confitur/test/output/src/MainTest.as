package {
	import flash.net.URLRequest;	
	
	import fr.digitas.flowearth.conf.Conf;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import fr.digitas.flowearth.conf.Confitur;	

	/**
	 * @author Pierre Lepers
	 */
	public class MainTest extends Sprite {
		
		public function MainTest() {
			
			Conf.addEventListener( Event.COMPLETE , onConfLoaded );
			Conf.loadXml( new URLRequest( "assets/xmls/completeConf.xml" ) );
		}
		
		private function onConfLoaded(event : Event) : void {
			
			var allQns : Array = Confitur.getPropertiesNames();
			
			var cprop : *;
			var cfprop : *;
			var ns : Namespace;
			for each (var qn : QName in allQns) {
				ns = new Namespace( qn.uri );
				cprop = Conf.ns::[ qn.localName ];
				cfprop = Confitur.ns::[ qn.localName ];
				
				trace( "test "+qn.toString() );
				
				if( cprop != cfprop )
					throw new Error( "Confitur test props not equals : "+qn.toString() );
					
			}
		}
	}
}
