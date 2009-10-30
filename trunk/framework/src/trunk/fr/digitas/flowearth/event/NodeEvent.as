////////////////////////////////////////////////////////////////////////////////
//
//  DIGITAS FRANCE / VIVAKI COMMUNICATIONS
//  Copyright 2008-2009 Digitas France
//  All Rights Reserved.
//
//  NOTICE: Digitas permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////


package fr.digitas.flowearth.event {
	import fr.digitas.flowearth.mvc.address.structs.INode;
	
	import flash.events.Event;	

	/**
	 * @author Pierre Lepers
	 */
	public class NodeEvent extends FlowEvent {
		
		public static const PATH_CHANGE 	: String = "_pathChange";

		public static const CHANGE 			: String = "_nodeChange";

		public static const PARAM_CHANGE 	: String = "_nodeParamChange";

		public static const ADDED 			: String = "_nodeAdded";

		public static const CHILD_CHANGE 	: String = "_child_nodeChange";

		public static const CHILD_ADDED 	: String = "_child_nodeAdded";

		public static const DEFAULT_CHANGE 	: String = "_defaultChange";


		
		public function get nodeTarget() : INode {
			return _ntarget;
		}

		public function get nodeCurrentTarget() : INode {
			return currentTarget as INode;
		}

		public function NodeEvent( type : String, target : INode, capureFlow : Boolean = false ) {
			_ntarget = target;
			super( type , false, false, capureFlow );
		}

		override public function clone() : Event {
			var c : NodeEvent = new NodeEvent( _nativeType, _ntarget, _capureFlow );
			return c;
		}

		private var _ntarget : INode;
		
	}
}
