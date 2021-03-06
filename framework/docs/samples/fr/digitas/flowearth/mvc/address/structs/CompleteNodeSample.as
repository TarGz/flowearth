package {


	public class CompleteNodeSample extends BasicExample {

		
		public function CompleteNodeSample() {
			run( );
		}
		
		private function run() : void {
			
			// creation of the main Panel object
			// provide it url of root site tree
			// This panel handle itself sub content 
			// by creating sub panels and so on.
			addChild( rootPanel = new Panel() );
			rootPanel.loadDatas( "CompleteNodeSample_tree.xml" );
			
		}

		private var rootPanel : Panel;
		
	}
}

// Store a global instance of SWFAddressConnector 
internal const swfAddressConnector : SWFAddressConnector = new SWFAddressConnector( );

//_____________________________________________________________________________
//																		 PANEL
//		
//		PPPPPP    AAA   NN  NN EEEEEEE LL      
//		PP   PP  AAAAA  NNN NN EE      LL      
//		PPPPPP  AA   AA NNNNNN EEEE    LL      
//		PP      AAAAAAA NN NNN EE      LL      
//		PP      AA   AA NN  NN EEEEEEE LLLLLLL


import fr.digitas.flowearth.core.IIterator;
import fr.digitas.flowearth.event.NodeEvent;
import fr.digitas.flowearth.mvc.address.structs.INode;
import fr.digitas.flowearth.mvc.address.structs.Node;
import fr.digitas.flowearth.mvc.address.structs.connector.SWFAddressConnector;
import fr.digitas.flowearth.mvc.address.structs.descriptor.BaseDescriptor;
import fr.digitas.flowearth.mvc.address.structs.system.nodeSystem;
import fr.digitas.flowearth.ui.layout.Layout;
import fr.digitas.flowearth.ui.layout.renderer.TopRenderer;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

class Panel extends Sprite {
	
	/**
	 * The Panel is the container of a Nav object and a Content object.
	 * It built both of them passing the proper INode object
	 * 
	 * It also load sub nodes datas, if they don't directly provided ( externalTree in content datas )
	 * 
	 */
	public function Panel( rootNode : INode = null ) {
		_rootNode = rootNode;
	}
	
	/**
	 * methode called when the parent panel's content find sub content's datas in his own content datas
	 */
	public function setDatas( datas : XML ) : void {
		
		// sub datas are in an external file
		// we load this additional site tree data
		// as well as the root Panel does
		if( datas.externalTree.length() > 0 )
			loadDatas( datas.externalTree.text() );
			

		// sub data are directly in the xml, build views
		else {
			buildNav();
			buildContent( datas );
		}
	}
	
	/**
	 * methode called when the parent panel's content don't find sub content's datas but just the corresponding url.
	 */
	public function loadDatas( url  : String ) : void {
		var  l : URLLoader = new URLLoader();
		l.addEventListener( Event.COMPLETE , onDatasLoaded );
		l.load( new URLRequest( url ) );
	}
	

	
	
	private function onDatasLoaded(event : Event) : void {
		var datas : XML = XML( ( event.currentTarget as URLLoader ).data );

		buildNodes( datas.tree[0] );
		buildNav();
		buildContent( datas.contents[0] );
	}

	private function buildNodes( xmlTree : XML ) : void {
		var descriptor : BaseDescriptor = new BaseDescriptor( xmlTree.node[0] );
		
		if( _rootNode == null ) 
		{
			// if the panel is the "root" panel, his node is register to the 
			// nodeSystem and swfAddress connection in initialized
			_rootNode = new Node( descriptor );
			nodeSystem.addDevice( _rootNode );
			swfAddressConnector.connectNode( _rootNode );
			swfAddressConnector.connectAddress();
		} else 
		{
			// the panel is a sub content panel which has loaded additional site tree datas ( <externalTree> )
			// the additionnal site tree data is append to the current node
			_rootNode.describe( descriptor );
		}
		
	}

	private function buildNav() : void {
		addChild( _nav = new Nav( _rootNode ) );
	}

	private function buildContent( contentDatas : XML ) : void {
		addChild( _content = new Content( _rootNode , contentDatas ) );
		_content.x = _nav.width + 10;
	}

	private var _nav : Nav;

	private var _content : Content;

	private var _rootNode : INode;

}

//_____________________________________________________________________________
//																		 NAV
//		
//		NN  NN   AAA   V     V 
//		NNN NN  AAAAA  V     V 
//		NNNNNN AA   AA  V   V  
//		NN NNN AAAAAAA   V V   
//		NN  NN AA   AA    V    

class Nav extends Sprite  {

	/**
	 * Nav object handle a node of the site tree
	 * It create nav items for each child of this given node, an activate these child nodes on click on corresponding nav items
	 */
	public function Nav( node : INode ) {
		_node = node;
		_build( );
	}
	
	private function _build() : void {
		addChild( _layout = new Layout() );
		_layout.renderer = new TopRenderer();
		
		// for each child nodes, we create a menu item
		var childs : Array = _node.getChilds();
		var child : INode;
		for (var i : int = 0; i < childs.length; i++) {
			child = childs[ i ];
			_layout.addChild( new NavItem ( child ) );
		}
	}

	private var _layout : Layout;

	private var _node : INode;
	
}

//_____________________________________________________________________________
//																		NAVITEM
//		
//		NN  NN   AAA   V     V         IIIIII TTTTTT EEEEEEE MM   MM 
//		NNN NN  AAAAA  V     V           II     TT   EE      MMM MMM 
//		NNNNNN AA   AA  V   V            II     TT   EEEE    MMMMMMM 
//		NN NNN AAAAAAA   V V             II     TT   EE      MM M MM 
//		NN  NN AA   AA    V            IIIIII   TT   EEEEEEE MM   MM 


class NavItem extends Sprite {
	
	/**
	 * the NavItem handle one child node of the Nav node.
	 * 
	 * On click on the item, the node is activated.
	 * 
	 * When the node state change (NodeEvent.CHANGE) the view of the item change ( bold or not )
	 */
	public function NavItem( node : INode ) {
		_node = node;
		_build( );
		useHandCursor = buttonMode = true;
	}
	
	private function _build() : void {
		
		// Build nav item label
		addChild( tf = new TextField() );
		
		tf.autoSize = TextFieldAutoSize.LEFT;
		tf.selectable = false;
		
		// syncronize node's activation state with nav item view (bold or not)
		_node.addEventListener( NodeEvent.CHANGE , onNodeChange );
		onNodeChange();
		
		// handle click action on item
		addEventListener( MouseEvent.CLICK , onClick );
	}

	private function onNodeChange( event : NodeEvent = null ) : void {
		if( _node.isActive() ) 	tf.defaultTextFormat = new TextFormat( "Arial" , 12, null, true );
		else 					tf.defaultTextFormat = new TextFormat( "Arial" , 12, null, false );
		tf.text = _node.getId();
	}
	
	private function onClick(event : MouseEvent) : void {
		_node.activate();
	}

	private var tf : TextField;

	private var _node : INode;
}

//_____________________________________________________________________________
//																		CONTENT
//		
//		 CCCCC   OOOO  NN  NN TTTTTT EEEEEEE NN  NN TTTTTT 
//		CC   CC OO  OO NNN NN   TT   EE      NNN NN   TT   
//		CC      OO  OO NNNNNN   TT   EEEE    NNNNNN   TT   
//		CC   CC OO  OO NN NNN   TT   EE      NN NNN   TT   
//		 CCCCC   OOOO  NN  NN   TT   EEEEEEE NN  NN   TT

class Content extends Sprite {

	/*
	 * Content handle a node of the sitetree and the corresponding XML datas ( <contents/> )
	 * 
	 * It listening for NodeEevnt.CHILD_CHANGE on the given node :
	 *   - if no child a active ( getcurrentChild() == null ) it display the <text> data of <content>
	 *   - if on child is active, it create a new Panel() with the active child and the proper sub content datas (matching the node id )
	 */
	public function Content( node : INode, datas : XML ) {
		_datas = datas;
		_node = node;
		_build( );
	}
	
	private function _build() : void {
		
		// build content textfield
		// Build nav item label
		addChild( tf = new TextField() );
		tf.defaultTextFormat = new TextFormat( "Arial" , 16 );
		tf.autoSize = TextFieldAutoSize.LEFT;
		tf.selectable = false;
		tf.multiline = true;
		
		// sync node state with content view
		_node.addEventListener( NodeEvent.CHILD_CHANGE , onChildChange );
		onChildChange( );
	}
	
	private function onChildChange(event : NodeEvent = null ) : void {
		
		// we check which child is active
		var currentChild : INode = _node.getCurrentChild();
		
		// destroy previous content
		if( currentPanel ) {
			removeChild( currentPanel );
			currentPanel = null;
		}
		
		
		// no child is active, we are on the home of the section
		// so we display the <text> value of the <content> datas
		if( currentChild == null ) {
			var contentStr : String = _datas.text.text();
			tf.htmlText = contentStr;
			tf.htmlText += "<br/><font size='11'>Lorem ipsum dolor sit amet, consectetur adipiscing elit.<br/>Mauris eu nisl vel sapien interdum rhoncus quis sed arcu.<br/>Sed eu sem ac sem dictum ornare.<br/>Sed iaculis tortor vitae mauris tincidunt a iaculis massa porttitor.<br/>Duis elementum orci at odio laoreet vulputate.</font>";
		} 
		
		// one child is active, we create new Panel, and provide it the active child
		// teh sub panel create the sub Nav, sub Content and so on.
		else {
			tf.htmlText = "";
			addChild( currentPanel = new Panel( currentChild ) );
			currentPanel.setDatas(_datas.content.( @id == currentChild.getId() )[0] );
		}
	}

	private var tf : TextField;

	private var currentPanel : Panel;

	private var _node : INode;

	private var _datas : XML;

}





