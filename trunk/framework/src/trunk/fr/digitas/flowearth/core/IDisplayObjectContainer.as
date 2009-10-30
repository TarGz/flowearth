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


package fr.digitas.flowearth.core {
	import flash.display.DisplayObject;						

	/**
	 * @author Pierre Lepers
	 */
	public interface IDisplayObjectContainer {
		
		function addChild(child : DisplayObject) : DisplayObject;

		function getChildByName(name : String) : DisplayObject;

		function getChildIndex(child : DisplayObject) : int;

		function setChildIndex(child : DisplayObject, index : int) : void;

		function addChildAt(child : DisplayObject, index : int) : DisplayObject;

		function contains(child : DisplayObject) : Boolean;

		function get numChildren() : int;

		function swapChildrenAt(index1 : int, index2 : int) : void;

		function getChildAt(index : int) : DisplayObject;

		function swapChildren(child1 : DisplayObject, child2 : DisplayObject) : void;

		function removeChildAt(index : int) : DisplayObject;

		function removeChild(child : DisplayObject) : DisplayObject;
		
	}
}
