package {
	import fr.digitas.flowearth.mvc.address.structs.Node;
	import fr.digitas.flowearth.mvc.address.structs.Path;
	import fr.digitas.flowearth.mvc.address.structs.descriptor.BaseDescriptor;
	import fr.digitas.flowearth.mvc.address.structs.system.nodeSystem;	

	public class NodeSystemSample extends BasicExample {

		public function NodeSystemSample() {
			run( );
		}
		
		private function run() : void {
			
			var siteTreeDatas : XML = 
								<node id="main">
									<node id="products">
										<node id="men">
											<node id="product1"/>
											<node id="product2"/>
										</node>
										<node id="women">
											<node id="product1"/>
											<node id="product2"/>
										</node>
									</node>
									<node id="services">
										<node id="aftersale"/>
										<node id="warranties">
											<node id="1year"/>
											<node id="2year"/>
										</node>
									</node>
									<node id="contact">
										<node id="jobs"/>
										<node id="mailinglist"/>
									</node>
								</node>;
									
			var descriptor : BaseDescriptor = new BaseDescriptor( siteTreeDatas );
			
			var mainDevice : Node = new Node( descriptor );
			
			nodeSystem.addDevice( mainDevice );
			
			var p : Path = new Path( "main:/services/aftersale" );
			trace( p.toNode() );
		}
	}
}