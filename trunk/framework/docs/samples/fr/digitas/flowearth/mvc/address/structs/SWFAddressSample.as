package {
	import fr.digitas.flowearth.core.IIterator;
	import fr.digitas.flowearth.mvc.address.structs.Node;
	import fr.digitas.flowearth.mvc.address.structs.connector.SWFAddressConnector;
	import fr.digitas.flowearth.mvc.address.structs.descriptor.BaseDescriptor;
	import fr.digitas.flowearth.mvc.address.structs.system.nodeSystem;
	import fr.digitas.flowearth.ui.layout.Layout;
	import fr.digitas.flowearth.ui.layout.renderer.TopWeakRenderer;		

	/**
	 * @author Pierre Lepers
	 */
	public class SWFAddressSample extends BasicExample {
		
		public function SWFAddressSample() {
			super( );
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
			
			var mainNode : Node = new Node( descriptor );
			
			nodeSystem.addDevice( mainNode );
			
			swfAddressConnector = new SWFAddressConnector();
			
			swfAddressConnector.connectNode( mainNode );
			
			swfAddressConnector.connectAddress();
			
			_buildView( mainNode );
		}
		
		private function _buildView( node : Node ) : void {
			_layout = new Layout( );
			_layout.renderer = new TopWeakRenderer();
			addChild( _layout );
			_layout.x = _layout.y = 20;

			addChildNodes( node, 0 );
		}

		
		
		private function addChildNodes( node : Node, indent : int = 0 ) : void {
			
			var btn : NodeBtn = new NodeBtn( node );
			btn.x = indent * 20;
			_layout.addChild( btn );
			
			var iter : IIterator = node.getChilds();
			var item : Node;
			while( iter.hasNext() ) {
				item = iter.next() as Node;
				addChildNodes( item, indent+1 );
			}
		}

		
		private var  swfAddressConnector : SWFAddressConnector;

		private var _layout : Layout;
	}
}

import fr.digitas.flowearth.event.NodeEvent;
import fr.digitas.flowearth.mvc.address.structs.Node;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFormat;

class NodeBtn extends Sprite {
		
	private var tf : TextField;

	public function NodeBtn( n : Node ) {
		
		this._node = n;
		addChild( tf = new TextField() );
		tf.autoSize = "left";
		tf.defaultTextFormat = new TextFormat( "Arial" );
		tf.selectable = false;
		
		addEventListener( MouseEvent.CLICK , onClick );
		mouseChildren = false;
		useHandCursor = buttonMode = true;
		
		n.addEventListener( NodeEvent.CHANGE , onNodeChange );
		n.addEventListener( NodeEvent.CHILD_CHANGE, onChildChange );
		n.addEventListener( NodeEvent.CHILD_CHANGE, onChildChange, false );
		onNodeChange( );
	}
	
	private function onChildChange(event : NodeEvent) : void {
		trace( " # ", event );
	}

	private function onNodeChange(event : NodeEvent = null ) : void {
		if( _node.isActive() )
			tf.defaultTextFormat = new TextFormat( "Arial",null, 0xFF0000 );
		else
			tf.defaultTextFormat = new TextFormat( "Arial",null, 0 );

		tf.text = _node.getId();
	}

	private function onClick(event : MouseEvent) : void {
		_node.activate();
	}

	private var _node : Node;

}
