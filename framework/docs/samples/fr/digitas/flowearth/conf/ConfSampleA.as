package {
	import flash.net.URLRequest;	
	
	import fr.digitas.flowearth.conf.Conf;
	
	import flash.events.Event;		

	public class ConfSampleA extends BasicExample {

		
		public function ConfSampleA() {
			//-----°1
			Conf.setProperty( "basepath", "." );
			Conf.grabParam( loaderInfo );
			
			//-----°2
			Conf.addEventListener( Event.COMPLETE , onConfLoaded );
			Conf.loadXml( new URLRequest ( Conf.getString("basepath") + "/confSampleA.conf") );
		}
		
		private function onConfLoaded(event : Event) : void {
			
			//-----°3
			trace( "°3",  Conf.getString( "assets_dir" ) );
			
			//-----°4
			Conf.setProperty( "local", "fr_FR" );
			trace( "°4", Conf.getString( "assets_dir" ) );
		
			//-----°5
			trace( "°5", Conf.getString( "basepath" ) );
			// --> if flashvar exist 		"../../../../../samples/fr/digitas/flowearth/conf"
			// --> if swf is standalone		"."
			
		}
	}
}
