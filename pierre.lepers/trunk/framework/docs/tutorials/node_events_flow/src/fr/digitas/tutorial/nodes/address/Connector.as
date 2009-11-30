package fr.digitas.tutorial.nodes.address {
	import fr.digitas.flowearth.mvc.address.SWFAddress;
	import fr.digitas.flowearth.mvc.address.SWFAddressEvent;
	import fr.digitas.flowearth.mvc.address.structs.Path;
	import fr.digitas.flowearth.mvc.address.structs.system.nodeSystem;	

	/**
	 * @author Pierre Lepers
	 */
	public class Connector {
		
		
		
		
		public function Connector(  ) {
			if( instance != null ) throw new Error( "fr.digitas.tutorial.nodes.address.Connector est deja instancié" );
		}
		
		public function connect() : void {
			SWFAddress.addEventListener( SWFAddressEvent.CHANGE , onAdressChange );
			onAdressChange( null );
			
			nodeSystem.getDefaultDevice()
		}
		
		private function onAdressChange(event : SWFAddressEvent) : void {
			var url : String = SWFAddress.getValue();
			var path : Path = new Path( url );
			nodeSystem.getDefaultDevice().activate( path );
		}
		
		

		
		
		
		
		public static var instance : Connector;
		
		
		public static function start( ) : Connector {
			if (instance == null)
				instance = new Connector();
			return instance;
		}
		
	}
	
}
