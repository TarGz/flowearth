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


package fr.digitas.flowearth.debug {
	import fr.digitas.flowearth.Version;

	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.Stage;
	import flash.events.ContextMenuEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;

	/**
	 * @author Pierre Lepers
	 */
	public class DebuggingMenu {

		
		
		public static function run ( stage : Stage ) : void { 
			_stage = stage;
			var cl : int = stage.numChildren;
			var children : DisplayObject;
			for (var i : Number = 0; i < cl; i++) {
				children = stage.getChildAt( i );
				if( children is InteractiveObject ) ( children as InteractiveObject ).contextMenu = ct;
			}
		}

		public static function stop ( ) : void { 
			var cl : int = _stage.numChildren;
			var children : DisplayObject;
			for (var i : Number = 0; i < cl; i++) {
				children = _stage.getChildAt( i );
				if( children is InteractiveObject ) ( children as InteractiveObject ).contextMenu = new ContextMenu;
			}
			_stage = null;
		}

		
		private static function getCt () : ContextMenu {
			var ct : ContextMenu = new ContextMenu( );
			ct.hideBuiltInItems( );
			ct.customItems = [titleItem( ),
            					objectUnderPointItem( )];
            ct.builtInItems.quality = true;
			return ct;
		}
		

		
		private static function titleItem () : ContextMenuItem {
			var item : ContextMenuItem = new ContextMenuItem( "Flowearth v " + Version.major + "." + Version.minor + "." + Version.build );
			item.enabled = false;
			return item;
		}

		//______________________________________________________________
		//												OBJECT UNDER POINT

		
		
		private static function objectUnderPointItem () : ContextMenuItem {
			var item : ContextMenuItem = new ContextMenuItem( "D - object under point" );
			item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, objectUnderPointHandler );
			return item;
		}

		private static function objectUnderPointHandler ( event : ContextMenuEvent ) : void {
			if( _stage == null ) return ;
			
			_stage.addChild( new ObjectUnderPointWatcher( ) );
		}

		
		private static const ct : ContextMenu = getCt( );
		private static var _stage : Stage;

	}
}

import fr.digitas.flowearth.utils.StringUtility;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

class ObjectUnderPointWatcher extends Sprite {

	
	public function ObjectUnderPointWatcher() {
		addEventListener( Event.ADDED_TO_STAGE, onAdded );
		addEventListener( Event.REMOVED_FROM_STAGE, onRemoved );
		_prevObjects = [];
	}

	
	private function onAdded( e : Event ) : void {
		addChild( _tf = buildText( ) );
		stage.addEventListener( MouseEvent.MOUSE_MOVE, mouseMove );
		stage.addEventListener( MouseEvent.MOUSE_DOWN, mouseDown );
	}

	private function onRemoved( e : Event ) : void {
		stage.removeEventListener( MouseEvent.MOUSE_MOVE, mouseMove );
		stage.removeEventListener( MouseEvent.MOUSE_DOWN, mouseDown );
	}

	private function mouseMove(event : MouseEvent) : void {
		x = parent.mouseX;
		y = parent.mouseY;
		
		var str : String = "";
		_prevObjects = stage.getObjectsUnderPoint( new Point( stage.mouseX, stage.mouseY ) );
		
		graphics.clear( );
		graphics.lineStyle( 0, 0xFF0000 );
		
		for each ( var _do : DisplayObject in _prevObjects ) {
			if( _do == _tf ) continue;
			
			var c : DisplayObject = _do;
			var depth : int = 1;
			while( c.parent ) {
				str += "\n"+StringUtility.multiply("	", depth)+" | " + c + " : " + c.name;
				c = c.parent;
				depth++;
			}
			str += "\n";
			
			var b : Rectangle = _do.getBounds( this );
			graphics.drawRect( b.x, b.y, b.width, b.height );
		}
		
		_tf.text = str;
		_tf.x = _tf.y = 2;
		
		var gb : Rectangle = _tf.getBounds( stage );
		
		if( gb.right > stage.stageWidth ) 
			_tf.x = - _tf.width - 2;
		if( gb.bottom > stage.stageHeight ) 
			_tf.y = -_tf.height - 2;
	}


	private var _prevObjects : Array;


	private function mouseDown(event : MouseEvent) : void {
		parent.removeChild( this );
	}

	private function buildText() : TextField {
		var tf : TextField = new TextField( );
		tf.width = 200;
		tf.height = 200;
		tf.background = true;
		tf.backgroundColor = 0x50FFFFFF;
		tf.autoSize = TextFieldAutoSize.LEFT;
		tf.defaultTextFormat = new TextFormat( "_sans", 9, 0x000000 );
		//tf.blendMode = BlendMode.DIFFERENCE;
		tf.selectable = false;
		
		return tf;
	}

	private var _tf : TextField;
}