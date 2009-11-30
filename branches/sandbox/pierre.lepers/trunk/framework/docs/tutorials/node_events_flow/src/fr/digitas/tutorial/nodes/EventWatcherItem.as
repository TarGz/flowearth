package fr.digitas.tutorial.nodes {
	import fr.digitas.flowearth.event.NodeEvent;
	
	import flash.events.Event;
	import flash.utils.Dictionary;		

	/**
	 * @author Pierre Lepers
	 */

	
	public class EventWatcherItem {

		public function get node() : ExtraNode {
			return _event.currentTarget as ExtraNode;
		}

		public function get target() : ExtraNode {
			return _event.nodeTarget as ExtraNode;
		}
		
		
		public function get event() : NodeEvent {
			return _event;
		}

		public function getString( ) : String {
			return _string;
		}

		
		public function EventWatcherItem( event : NodeEvent ) {
			_event = event;
			_type = getType( _event.type );
			build( );
		}

		private function build() : void {
			_string = stringifyEvent( );
		}

		
		private function stringifyEvent( ) : String {
		
			var str : String = "";
		
			str += getDecoration( );
			str += "[" + _type + "] ";
			str += _event.currentTarget.getId( );
		
			return str;
		}

		private function getDecoration() : String {
			//		if( _event.currentTarget == _event.nodeTarget )
			//			return "<font color='#AAAA00'>&gt; </font>";
			if( _event.capureFlow )
			return "<font color='#AA0000'>↓ </font>";
		else
			return "<font color='#00AA00'>↑ </font>";
			return "";
		}
		
		private function getType( intype : String ) : String  {
			var etype : String = _event.type;
			if( _event.capureFlow ) etype = etype.substr( 7 );
			return TYPE_MAP[ etype ];
		}

		
		
		private var _event : NodeEvent;

		private var _type : String;

		private var _string : String;
		
		public function decorateNode() : void {
			var str :  String = getDecoration();
			str += _type;
			node.attribute = str;
		}

		public function decorateTarget() : void {
			target.attribute += "<font color='#AA0000'> target</font>";
		}

		public function clearDecorations() : void {
			target.attribute = 
			node.attribute = "";
		}

		private static const TYPE_MAP : Dictionary = _init();
		
		private static function _init() : Dictionary {
			var tm : Dictionary = new Dictionary();
			tm[ "_nodeChange" ] = "CHANGE";
			tm[ "_nodeParamChange" ] = "PARAM_CHANGE";
			tm[ "_nodeAdded" ] = "ADDED";
			tm[ "_child_nodeChange" ] = "CHILD_CHANGE";
			tm[ "_child_nodeAdded" ] = "CHILD_ADDED";
			tm[ "_defaultChange" ] = "DEFAULT_CHANGE";
			tm[ "_pathChange" ] = "PATH_CHANGE";
			return tm;
		}
		
		
		public function get type() : String {
			return _type;
		}
	}
}
