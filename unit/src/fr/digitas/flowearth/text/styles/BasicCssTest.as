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


package fr.digitas.flowearth.text.styles {	import asunit.framework.TestCase;
	
	import fr.digitas.flowearth.conf.Conf;
	
	import flash.display.BlendMode;
	import flash.text.AntiAliasType;
	import flash.text.GridFitType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;	
	public class BasicCssTest extends TestCase {		public function BasicCssTest(testMethod:String = null) {			super(testMethod );		}		override public function run() : void {			var cssText : String = Conf.getString( "css_basic" );			styleManager.addCss( cssText );			super.run( );		}				public function testAccessStyles():void {			var sname : String;			var s : AdvancedFormat;									sname = "basicStyleA";			s = styleManager.getStyle( sname );			assertNotNull("acces " + sname , s );			sname = ".basicStyleA";			s = styleManager.getStyle( sname );			assertNotNull("acces " + sname , s );						sname = ".basicStyleB";			s = styleManager.getStyle( sname );			assertNotNull("acces " + sname , s );			sname = "basicStyleB";			s = styleManager.getStyle( sname );			assertNotNull("acces " + sname , s );						sname = ".basicStylec";			s = styleManager.getStyle( sname );			assertNotNull("acces " + sname , s );			sname = "basicStylec";			s = styleManager.getStyle( sname );			assertNotNull("acces " + sname , s );			sname = ".BASICSTYLEC";			s = styleManager.getStyle( sname );			assertNotNull("acces " + sname , s );			sname = "BASICSTYLEC";			s = styleManager.getStyle( sname );			assertNotNull("acces " + sname , s );		}				public function testStyleNameConflict() : void {						var cssText : String = Conf.getString( "css_basic_conflict" );						var thrown : Boolean = false;			try {				styleManager.addCss( cssText );			} catch ( e : Error ) {				thrown = ( e.errorID == 1000 );			}			assertTrue( "conflict throw error" , thrown );		}				public function testCssIdConflict() : void {						var cssText : String = Conf.getString( "css_basic" );			styleManager.addCss( cssText, "testCssIdConflict/cssUriA", "nonuiqueid" );						var thrown : Boolean = false;			try {				styleManager.addCss( cssText, "testCssIdConflict/cssUriB", "nonuiqueid" );			} catch ( e : Error ) {				thrown = ( e.errorID == 1003 );			}			assertTrue( "testCssIdConflict throw error" , thrown );		}		public function testInvalidStyle() : void {						var cssText : String = Conf.getString( "css_invalid" );						var thrown : Boolean = false;			try {				styleManager.addCss( cssText );			} catch ( e : Error ) {				thrown = ( e.errorID == 1001 );			}			assertTrue( "invalid throw error" , thrown );		}		public function testBasicNativValues() : void {						var sname : String;			var s : AdvancedFormat;									sname = "basicStyleA";			s = styleManager.getStyle( sname );//			fontSize: 8;//		    color: 0xFFFFFF;//			autoSize: "left";			assertEquals( "test " + sname +" values 1", s.getObject().fontSize , 8 );			assertTrue( "test " + sname +" type 1", ( s.getObject().fontSize is String ) );			assertEquals( "test " + sname +" values 2", s.getObject().color , 0xFFFFFF );			assertTrue( "test " + sname +" type 2", ( s.getObject().color is String ) );			assertEquals( "test " + sname +" values 3", s.getObject().autoSize , '"left"' );			assertTrue( "test " + sname +" type 3", ( s.getObject().autoSize is String ) );			sname = ".basicStyleB";			s = styleManager.getStyle( sname );//			fontSize :10;//		    color : #FFFFFF;//			autoSize:left;			assertEquals( "test " + sname +" values 1", s.getObject().fontSize , 10 );			assertTrue( "test " + sname +" type 1", ( s.getObject().fontSize is String ) );			assertEquals( "test " + sname +" values 2", s.getObject().color , "#FFFFFF" );			assertTrue( "test " + sname +" type 2", ( s.getObject().color is String ) );			assertEquals( "test " + sname +" values 3", s.getObject().autoSize , "left" );			assertTrue( "test " + sname +" type 3", ( s.getObject().autoSize is String ) );		}		public function testAllTfProps() : void {						styleManager.autoEmbed = false;			var cssText : String = Conf.getString( "css_complete" );			styleManager.addCss( cssText );			styleManager.autoEmbed = true;						var sname : String;			var s : AdvancedFormat;			var tf : TextField;									sname = "completeStyle";			s = styleManager.getStyle( sname );			tf = new TextField();			s.format(tf);			var model : TextField = getNeutralTF();						for each( var prop : String in TESTED_PROPS ) {				assertEquals( "testAllTfProps "+prop, model[ prop ], tf[ prop ] );			}								}				private function getNeutralTF() : TextField {			var tf : TextField = new TextField();						// NUMBER			tf.alpha = .67;			tf.rotation = 12.85;			tf.scaleX = 1.05;			tf.scaleY = 1.05;			tf.height = 12.5;			tf.sharpness = 12.5;			tf.thickness = 12.5;			tf.width = 12.5;			tf.x = 12.5;			tf.y = 12.5;									// BOOLEAN			tf.background = true;			tf.border = true;			tf.cacheAsBitmap = true;			tf.condenseWhite = false;			tf.displayAsPassword = true;			tf.doubleClickEnabled = true;			tf.embedFonts = true;			tf.mouseEnabled = false;			tf.mouseWheelEnabled = true;			tf.multiline = true;			tf.selectable = true;			tf.tabEnabled = true;			tf.useRichTextClipboard = true;			tf.visible = false;			tf.wordWrap = true;			// STRING			tf.antiAliasType = AntiAliasType.NORMAL;			tf.autoSize = TextFieldAutoSize.NONE;			tf.blendMode = BlendMode.DARKEN;			tf.gridFitType = GridFitType.SUBPIXEL;			tf.htmlText = "totottotottotottotottotottotottotottotottotottotottotottotottotottotottotottotottotottotot";			tf.name = "totot";			tf.restrict = "A-Z";			tf.text = "totottotottotottotottotottotottotottotottotottotottotottotottotottotottotottotottotottotot";			tf.type = TextFieldType.DYNAMIC;						// uint			tf.backgroundColor = 0xD456A1;			tf.borderColor = 0xD456A1;			tf.textColor = 0x345678;			// int			tf.maxChars = 12;			tf.scrollH = 2;			tf.scrollV = 2;			tf.tabIndex = 1;						return tf;		}				private static const TESTED_PROPS : Array = 													["alpha",													"rotation",													"scaleX",													"scaleY",													"height",													"sharpness",													"thickness",													"width",													"x",													"y",																											"antiAliasType",													"autoSize",													"blendMode",													"gridFitType",													"htmlText",													"name",													"restrict",													"text",													"type",																											"background",													"border",													"cacheAsBitmap",													"condenseWhite",													"displayAsPassword",													"doubleClickEnabled",													"embedFonts",													"mouseEnabled",													"mouseWheelEnabled",													"visible",													"multiline",													"selectable",													"tabEnabled",													"useRichTextClipboard",													"wordWrap",																											"backgroundColor",													"borderColor",													"textColor",													"maxChars",//													"scrollH",//													"scrollV",													"tabIndex" ] ;	}		}