package fr.digitas.tutorial.nodes {
	import fl.controls.Button;
	import fl.controls.ComboBox;
	import fl.data.DataProvider;
	
	import fr.digitas.flowearth.event.NodeEvent;
	import fr.digitas.flowearth.mvc.address.structs.INode;
	import fr.digitas.flowearth.mvc.address.structs.Path;
	import fr.digitas.flowearth.mvc.address.structs.connector.SWFAddressConnector;
	import fr.digitas.flowearth.mvc.address.structs.descriptor.INodeDescriptor;
	import fr.digitas.flowearth.mvc.address.structs.system.nodeSystem;
	import fr.digitas.flowearth.ui.layout.Layout;
	import fr.digitas.flowearth.ui.layout.renderer.TopRenderer;
	import fr.digitas.flowearth.ui.scroller.Scroller;
	import fr.digitas.tutorial.nodes.filters.FlowFilter;
	import fr.digitas.tutorial.nodes.filters.TypeFilter;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;	

	/**
	 * @author Pierre Lepers
	 */
	public class NodeEventsFlow extends Sprite {

		public var tf : TextField;
		public var elayout : Layout;
		public var scroll : Scroller;

		public var showPathButton : Button;
		public var addBtn : Button;

		public var pathCb : ComboBox;
		public var controls : Controls_FC;
		
		

		public function NodeEventsFlow() {
			
			initTf( );
			initLayout( );
			buildNodes( );
			refresh( );
			buildWatcher( );
			buildConnector( );

			addEventListener( Event.ADDED_TO_STAGE, onAdded );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemoved );
		}

		private function onAdded( e : Event ) : void {
			stage.addEventListener( Event.RESIZE , onResize );
			onResize( null );
		}
		
		private function onRemoved( e : Event ) : void {
			stage.removeEventListener( Event.RESIZE , onResize );
		}
		
		private function buildConnector() : void {
			_addressConnector = new SWFAddressConnector( );
			_addressConnector.connectNode( nodeSystem.getDevice( "gen" ) );
			_addressConnector.connectAddress();
		}

		private function buildWatcher() : void {
			_watcher = new EventWatcher( );
			_watcher.addEventListener( Event.CHANGE , _refreshEventList );
			_watcher.connect( rootNode );
		}

		private function _refreshEventList(event : Event) : void {
			elist.append( _watcher.flush( ) );
//			var witems : Array = ;
//			var witem : EventWatcherItem;
//			var eli : EventListItem;
//			for (var i : int = 0; i < witems.length; i++) {
//				witem = witems[i];
//				elayout.addChild( eli = new EventListItem_FC() );
//				eli.init( witem );
//				eli.addEventListener( EventListItem.ACTION, refresh );
//			}
		}

		private function refresh( e : Event = null ) : void {
			var t : HtmlStringifyerTraverser = new HtmlStringifyerTraverser( showPathButton.selected );
			rootNode.scan( t );
			var str : String = t.result;
			tf.htmlText = str;
		}

		private function initTf() : void {
			tf.border = true;
			tf.mouseWheelEnabled = true;
			
			controls.clearBt.addEventListener( MouseEvent.CLICK , onClear );
			controls.showBubbling.selected = true;
			controls.showCapture.selected = true;
			controls.showChange.selected = true;
			controls.showChildChange.selected = true;
			
			tf.addEventListener( TextEvent.LINK , onLink );
			
			showPathButton.addEventListener( Event.CHANGE , onshowPathButtonChange );
			addBtn.addEventListener( MouseEvent.CLICK , addSomeNodes );
		}
		
		private function addSomeNodes(event : MouseEvent) : void {
			rootNode.scan( new NodeAddTraverser () );
		}

		
		private function initLayout() : void {
			elayout.renderer = new TopRenderer( );
			//			scroll.addChild( elayout );
			elayout.container = scroll;
			elist = new EventList( elayout );
			
			elist.addFilter( new FlowFilter( controls.showCapture , false ) );
			elist.addFilter( new FlowFilter( controls.showBubbling , true ) );
			elist.addFilter( new TypeFilter( controls.showChange , "CHANGE" ) );
			elist.addFilter( new TypeFilter( controls.showChildChange , "CHILD_CHANGE" ) );
			elist.addFilter( new TypeFilter( controls.showPathChange , "PATH_CHANGE" ) );
			
			elist.addEventListener( EventListItem.ACTION , refresh );
		}

		private function onClear(event : MouseEvent) : void {
			elist.clear( );
		}

		private function onLink(event : TextEvent) : void {
			var pathStr : String = event.text;
			new Path( pathStr ).toNode( ).activate( );
			refresh( );
		}

		private function onResize( event : Event ) : void {
			pathCb.width = tf.width = stage.stageWidth / 2 - 10;
			tf.height = stage.stageHeight - tf.y - 30;
			showPathButton.y = addBtn.y = tf.y + tf.height+5;
			controls.x = scroll.x = tf.width + 5 + tf.x;
			scroll.width = stage.stageWidth - tf.width - 10 - tf.x;
			scroll.height = stage.stageHeight - scroll.y - 10;
			
		}

		private function buildNodes() : void {
			var desc : INodeDescriptor = generateDesc( "gen" , 2 , 4 );
			nodeSystem.addDevice( rootNode = new ExtraNode( desc ) );
			
			rootNode.addEventListener( NodeEvent.PATH_CHANGE , onpc, false );
			
			var cbp : CbProvider = new CbProvider( );
			rootNode.scan( cbp );
			pathCb.dataProvider = new DataProvider( cbp.provider );
			pathCb.rowCount = 20;
			pathCb.addEventListener( Event.CHANGE , onCbChange );
		}
		
		private function onpc(event : NodeEvent) : void {
			trace( "fr.digitas.tutorial.nodes.Main - onpc -- " );
			refresh();
		}

		private function onCbChange(event : Event) : void {
			rootNode.activate( new Path( pathCb.selectedItem.data as String ) );
		}

		private function generateDesc( Id : String, childPerNode : int = 3, recurtion : uint = 1 ) : INodeDescriptor {
			if( childPerNode >= CHILDS_IDS.length ) childPerNode = CHILDS_IDS.length - 1;
			
			recurtion --;
			var d : BaseDescriptor = new BaseDescriptor( null );
			d.setId( Id );
			if( recurtion == 0 ) return d;
			for (var i : int = 0; i < childPerNode ; i ++) {
				d.getChildsArray( ).push( generateDesc( Id + "-" + CHILDS_IDS[ i ] , childPerNode , recurtion ) );
			}
			return d;
		}
		
		
		private function onshowPathButtonChange(event : Event) : void {
			refresh();
		}
		
		private var _addressConnector : SWFAddressConnector;

		private var _watcher : EventWatcher;

		private var rootNode : INode;

		private var elist : EventList;

		private static const CHILDS_IDS : Array = [ "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S" ];
	}
}

import fr.digitas.flowearth.event.NodeEvent;
import fr.digitas.flowearth.mvc.address.structs.INode;
import fr.digitas.flowearth.mvc.address.structs.traverser.INodeTraverser;
import fr.digitas.flowearth.utils.StringUtility;
import fr.digitas.tutorial.nodes.EventWatcherItem;
import fr.digitas.tutorial.nodes.ExtraNode;

import flash.events.Event;
import flash.events.EventDispatcher;

class EventWatcher extends EventDispatcher implements INodeTraverser {

	public function flush() : Array {
		var copy : Array = _buffer.concat( );
		_buffer = [];
		return copy;
	}

	public function EventWatcher() {
		_items = [];
		_buffer = [];
	}

	public function connect( node : INode ) : void {
		node.scan( this );
	}

	public function enter(node : INode) : Boolean {
		node.addEventListener( NodeEvent.ADDED , onEvent );
		node.addEventListener( NodeEvent.CHANGE , onEvent );
		node.addEventListener( NodeEvent.CHILD_ADDED , onEvent );
		node.addEventListener( NodeEvent.CHILD_CHANGE , onEvent );
		node.addEventListener( NodeEvent.DEFAULT_CHANGE , onEvent );
		node.addEventListener( NodeEvent.PARAM_CHANGE , onEvent );
		node.addEventListener( NodeEvent.PATH_CHANGE , onEvent );

		node.addEventListener( NodeEvent.ADDED , onEvent , false );
		node.addEventListener( NodeEvent.CHANGE , onEvent , false );
		node.addEventListener( NodeEvent.CHILD_ADDED , onEvent , false );
		node.addEventListener( NodeEvent.CHILD_CHANGE , onEvent , false );
		node.addEventListener( NodeEvent.DEFAULT_CHANGE , onEvent , false );
		node.addEventListener( NodeEvent.PARAM_CHANGE , onEvent , false );
		node.addEventListener( NodeEvent.PATH_CHANGE , onEvent , false );
		
		return true;
	}

	private function onEvent(event : NodeEvent) : void {
		var item : EventWatcherItem = new EventWatcherItem( event );
		_items.push( item );
		_buffer.push( item );
		dispatchEvent( new Event( Event.CHANGE ) );
	}

	public function clear() : void {
		_items = [];
		_buffer = [];
	}

	
	
	public function leave(node : INode) : void {
	}

	private var _buffer : Array;

	private var _items : Array;
}

class HtmlStringifyerTraverser implements INodeTraverser {

	
	
	
	public function HtmlStringifyerTraverser( showActivePath : Boolean = false ) {
		_showActivePath = showActivePath;
		_result = "<br/>";
	}

	public function get result() : String {
		return _result;
	}
	
	private var _showActivePath : Boolean;

	public function enter(node : INode) : Boolean {
		_tab ++;
		var tab : String = StringUtility.multiply( "|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" , _tab );
		
			
		_result += tab + createNodeString( node as ExtraNode ) + "<br/>";
	
		return true;
	}

	private function createNodeString( node : ExtraNode ) : String {
		var _result : String = "<a href='event:" + node.path( ).toString( ) + "'>";

		var params : String = "";
		if( node.getParams( ) ) params = node.getParams( ).toString( );
		
		if( node.isActive( ) )
			_result += "|- <font color='#009000'>" + node.getId( ) + "  </font><i> " + params + " </i>";
		else
			_result += "|- " + node.getId( ) + " <i> " + params + "</i>";
		
		if( node.getDefaultId( ) )
			_result += " <i> " + node.getDefaultId( ) + "</i>";
		
		_result += node.attribute;
		
		if( _showActivePath && node.activePath ) {
			_result += node.activePath.toString();
		}
		
		_result += "</a>";
		
		return _result;
	}

	public function leave(node : INode) : void {
		_tab --;
	}

	private var _result : String;
	private var _tab : int = - 1;
}



class CbProvider implements INodeTraverser {

	
	
	public function CbProvider() {
		_provider = [];
	}

	public function enter(node : INode) : Boolean {
		_provider.push( node.path().toString() );
		return true;
	}

	public function leave(node : INode) : void {
	}
	
	private var _provider : Array;
	
	public function get provider() : Array {
		return _provider;
	}
}
