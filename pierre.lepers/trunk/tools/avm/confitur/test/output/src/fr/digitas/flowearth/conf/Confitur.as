package fr.digitas.flowearth.conf { 

	public const Confitur : _Configuration_ = new _Configuration_();

}

import fr.digitas.flowearth.conf.nsB;
import fr.digitas.flowearth.conf.nsA;
import fr.digitas.flowearth.conf.ns_1;


class _Configuration_ {


		public var TemplateName : String = "";
		public var FirstName : String = "";
		public var initialization : String = "INITIALISATION";
		public var nodeDescriptorBExt : XML = 
<nodeDescriptorBExt>
  <node id="C">
    <node id="A">
      <node id="A">
        <node id="A"/>
        <node id="B"/>
        <node id="C"/>
      </node>
      <node id="B">
        <node id="A"/>
        <node id="B"/>
        <node id="C"/>
      </node>
      <node id="C">
        <node id="A"/>
        <node id="B"/>
        <node id="C"/>
      </node>
    </node>
    <node id="B">
      <node id="A">
        <node id="A"/>
        <node id="B"/>
        <node id="C"/>
      </node>
      <node id="B">
        <node id="A"/>
        <node id="B"/>
        <node id="C"/>
      </node>
      <node id="C">
        <node id="A"/>
        <node id="B"/>
        <node id="C"/>
      </node>
    </node>
    <node id="C">
      <node id="A">
        <node id="A"/>
        <node id="B"/>
        <node id="C"/>
      </node>
      <node id="B">
        <node id="A"/>
        <node id="B"/>
        <node id="C"/>
      </node>
      <node id="C">
        <node id="A"/>
        <node id="B"/>
        <node id="C"/>
      </node>
    </node>
  </node>
</nodeDescriptorBExt>;
		public var xmlURL : String = "assets/xmls";
		public var loadingExternalMedias : String = "CHARGEMENT DES MEDIAS";
		public var data2 : String = "prop externe avec maProp3";
		public var XML_GetForumAdvInfo : XML = 
<XML_GetForumAdvInfo>
  <Loreal_Reference_IN_GetForumAdvInfo>
    <SessionID/>
    <ForumAdvId/>
    <ForumAdvName/>
  </Loreal_Reference_IN_GetForumAdvInfo>
</XML_GetForumAdvInfo>;
		public var Extension : String = "";
		public var cssURL : String = "assets/styles/css";
		public var SessionID : String = "";
		public var Email : String = "";
		public var loadingComplete : String = "CHARGEMENT TERMINE";
		public var css_basic : String = "/* inline comment */\n"+
		                                "\n"+		                                "\n"+
		                                "/* \n"+
		                                "multiline \n"+
		                                "comment \n"+
		                                "*/\n"+
		                                "\n"+		                                "\n"+
		                                "\n"+
		                                ".basicStyleA {\n"+
		                                "	fontSize: 8;\n"+
		                                "    color: 0xFFFFFF;\n"+
		                                "	autoSize: \"left\";\n"+
		                                "}\n"+
		                                "\n"+		                                "\n"+
		                                "basicStyleB {\n"+
		                                "	fontSize :10;\n"+
		                                "    color : #FFFFFF;\n"+
		                                "    /* inside comment */\n"+
		                                "	autoSize:left;\n"+
		                                "}\n"+
		                                "\n"+		                                "\n"+
		                                ".basicstylec {\n"+
		                                "	fontSize :  10;\n"+
		                                "    color  :  #FFFFFF;\n"+
		                                "    /* \n"+
		                                "    inside multiline comment \n"+
		                                "    */\n"+
		                                "	autoSize:left;\n"+
		                                "}";
		public var loading : String = "CHARGEMENT";
		public var scaleMode : String = "noscale";
		public var css_basic_conflict : String = "/*conflict test with basic.css */\n"+
		                                         "\n"+		                                         "\n"+
		                                         "basicSTYLEC {\n"+
		                                         "	fontSize : 12;\n"+
		                                         "    color  :  0x000000;\n"+
		                                         "	autoSize:right;\n"+
		                                         "}";
		public var Overwrite : String = "";
		public var distUnsecureDomain : String = "";
		public var css_invalid : String = ".basicStyleA {\n"+
		                                  "	fontSize: 8;\n"+
		                                  "    color: 0xFFFFFF;\n"+
		                                  "	autoSize;";
		public var showMenu : String = "false";
		public var ForumId : String = "";
		public var PostID : String = "";
		public var distSecureDomain : String = "";
		public var css_complete : String = "@font-face {\n"+
		                                   "	src : url( \"maFont.swf\" );\n"+
		                                   "}\n"+
		                                   "\n"+		                                   "\n"+
		                                   ".completeStyle {\n"+
		                                   "	alpha : .67;\n"+
		                                   "	rotation : 12.85;\n"+
		                                   "	scaleX : 1.05;\n"+
		                                   "	scaleY : 1.05;\n"+
		                                   "	height : 12.5;\n"+
		                                   "	sharpness : 12.5;\n"+
		                                   "	thickness : 12.5;\n"+
		                                   "	width : 12.5;\n"+
		                                   "	x : 12.5;\n"+
		                                   "	y : 12.5;\n"+
		                                   "	\n"+
		                                   "	antiAliasType : normal;\n"+
		                                   "	autoSize : none;\n"+
		                                   "	blendMode : darken;\n"+
		                                   "	gridFitType :subpixel;\n"+
		                                   "	htmlText : totottotottotottotottotottotottotottotottotottotottotottotottotottotottotottotottotottotot;\n"+
		                                   "	name : totot;\n"+
		                                   "	restrict : A-Z;\n"+
		                                   "	text : totottotottotottotottotottotottotottotottotottotottotottotottotottotottotottotottotottotot;\n"+
		                                   "	type : dynamic;\n"+
		                                   "	\n"+
		                                   "	background : true;\n"+
		                                   "	border : true;\n"+
		                                   "	cacheAsBitmap : true;\n"+
		                                   "	condenseWhite : false;\n"+
		                                   "	displayAsPassword : true;\n"+
		                                   "	doubleClickEnabled : true;\n"+
		                                   "	embedFonts : true;\n"+
		                                   "	mouseEnabled : false;\n"+
		                                   "	mouseWheelEnabled : true;\n"+
		                                   "	visible : false;\n"+
		                                   "	multiline : true;\n"+
		                                   "	selectable : true;\n"+
		                                   "	tabEnabled : true;\n"+
		                                   "	useRichTextClipboard : true;\n"+
		                                   "	wordWrap : true;\n"+
		                                   "	\n"+
		                                   "	backgroundColor : 0xD456A1;\n"+
		                                   "	borderColor : 0xD456A1;\n"+
		                                   "	textColor : 0x345678;\n"+
		                                   "	maxChars : 12;\n"+
		                                   "	scrollH : 2;\n"+
		                                   "	scrollV : 2;\n"+
		                                   "	tabIndex : 1;\n"+
		                                   "}";
		public var ForumAdvId : String = "";
		public var Quality : String = "";
		public var css_extends : String = ".extC>extB{\n"+
		                                  "	background : false;\n"+
		                                  "	size : 12;\n"+
		                                  "}\n"+
		                                  "\n"+		                                  "\n"+
		                                  "extA {\n"+
		                                  "	color : 0xFF0000;\n"+
		                                  "	size : 10;\n"+
		                                  "}\n"+
		                                  "\n"+		                                  "\n"+
		                                  "extB>extA{\n"+
		                                  "	background : true;\n"+
		                                  "	size : 8;\n"+
		                                  "}\n"+
		                                  "\n"+		                                  "\n"+
		                                  ".extD>.extC{\n"+
		                                  "	color : 0x000000;\n"+
		                                  "}\n"+
		                                  "\n"+		                                  "\n"+
		                                  ".extE>.extD{\n"+
		                                  "	background : true;\n"+
		                                  "}";
		public var align : String = "T";
		public var XML_SaveForumAdvPostInfo : XML = 
<XML_SaveForumAdvPostInfo>
  <Loreal_Reference_IN_SaveForumAdvPostInfo>
    <SessionID/>
    <ForumAdvId/>
    <ForumAdvPostId/>
    <FpParentId/>
    <FpSubject><![CDATA[##FpSubject##]]></FpSubject>
    <FpText><![CDATA[##FpText##]]></FpText>
    <FpApproved/>
    <FpValid/>
    <FpExtendedProperties>
      <mw_revealator_last_name/>
      <mw_revealator_first_name/>
      <mw_revealator_telephone/>
      <mw_revealator_email/>
      <mw_revealator_newsletter/>
      <mw_revealed_initiative_name/>
      <mw_revealed_kind/>
      <mw_revealed_en_desc/>
      <mw_revealed_local_desc/>
      <mw_revealed_picture/>
      <mw_revealed_picture_preview/>
      <mw_revealed_video/>
      <mw_revealed_website_video/>
    </FpExtendedProperties>
  </Loreal_Reference_IN_SaveForumAdvPostInfo>
</XML_SaveForumAdvPostInfo>;
		public var ForumAdvName : String = "";
		public var bitmapToPreload : XML = 
<bitmapToPreload>
  <file id="btp_large_enc"><![CDATA[assets/crypto_arc4/img/large.jpg]]></file>
  <file id="secure_btp"><![CDATA[/pict.jpg]]></file>
  <file id="unsecure_btp"><![CDATA[/pict.jpg]]></file>
  <noeud_a_la_con>
    <file id="btp_large"><![CDATA[assets/img/large.jpg]]></file>
  </noeud_a_la_con>
</bitmapToPreload>;
		public var XML_CreatUserInfo : XML = 
<XML_CreatUserInfo>
  <Loreal_Reference_IN_SaveCustomerInfo>
    <FirstName/>
    <LastName/>
    <Title/>
    <BirthDate/>
    <Email/>
    <AddressLine1/>
    <AddressLine2/>
    <City/>
    <Zip/>
    <State/>
    <CountryName/>
    <CountryCode/>
    <Phone/>
    <DynamicProperties>
      <mw_revealed_website_url/>
      <mw_revealed_fax/>
    </DynamicProperties>
    <Role/>
  </Loreal_Reference_IN_SaveCustomerInfo>
</XML_CreatUserInfo>;
		public var ForumAdvPostId : String = "";
		public var Height : String = "";
		public var lockedProp : String = "locked";
		public var LastName : String = "";
		public var testXml2 : XML = 
<testXml2>
  <test1>
    <scaleMode>noscale</scaleMode>
    <T>noued align</T>
  </test1>
  <test2>
    <scaleMode>noscale</scaleMode>
    <T>noued align</T>
  </test2>
  <test3>
    <scaleMode>noscale</scaleMode>
    <T>noued align</T>
  </test3>
</testXml2>;
		public var Width : String = "";
		public var Title : String = "";
		public var depG : String = "ABCDEFG";
		public var sum123 : String = "maProp1 - maProp2 - maProp3";
		public var mediaToPreload : XML = 
<mediaToPreload>
  <noeud_a_la_con>
    <file><![CDATA[assets/img/largeExternal1.jpg]]></file>
  </noeud_a_la_con>
  <noeud_a_la_con>
    <file id="preload"><![CDATA[assets/crypto/swf/preload.swf]]></file>
  </noeud_a_la_con>
</mediaToPreload>;
		public var depI : String = "ABCDEFGHI";
		public var BirthDate : String = "";
		public var sum12 : String = "maProp1 - maProp2";
		public var FpApproved : String = "";
		public var depH : String = "ABCDEFGH";
		public var AddressLine1 : String = "";
		public var FpValid : String = "";
		public var AddressLine2 : String = "";
		public var property1 : String = "maProp1";
		public var property2 : String = "maProp2";
		public var City : String = "";
		public var mw_revealator_last_name : String = "";
		public var whatCplx : String = "";
		public var property3 : String = "maProp3";
		public var depF : String = "ABCDEF";
		public var soundLibrairies : XML = 
<soundLibrairies>
  <file url="soundsFile">
    <def>bi.portfolio.sounds.Roll</def>
    <def>bi.portfolio.sounds.Double</def>
  </file>
</soundLibrairies>;
		public var mw_revealator_first_name : String = "";
		public var definedAfter : String = "/definedAfter";
		public var what : String = "";
		public var Zip : String = "";
		public var mw_revealator_telephone : String = "";
		public var definedAfterCplx : XML = 
<definedAfterCplx>
  <c>
    <c>/definedAfterCplx</c>
  </c>
</definedAfterCplx>;
		public var nsPropnoNs : String = "propNons";
		public var mw_revealator_email : String = "";
		public var State : String = "";
		public var depB : String = "AB";
		public var siteMainFile : XML = 
<siteMainFile>
  <file><![CDATA[assets/swf/site.swf]]></file>
</siteMainFile>;
		public var CountryName : String = "";
		public var soundsFile : String = "assets/crypto/swf/sounds.swf";
		public var depC : String = "ABC";
		public var mw_revealed_initiative_name : String = "";
		public var CountryCode : String = "";
		public var mw_revealator_newsletter : String = "";
		public var extManagerDatas : String = "extManager.xml";
		public var depD : String = "ABCD";
		public var nsProp2 : String = "prop1 nsBZZZ";
		public var Phone : String = "";
		public var external2 : String = "external2.xml";
		public var mw_revealed_kind : String = "";
		public var mw_revealed_en_desc : String = "";
		public var depA : String = "A";
		public var depE : String = "ABCDE";
		public var dtl2 : String = "externalData2.xml";
		public var mw_revealed_website_url : String = "";
		public var mw_revealed_local_desc : String = "";
		public var lang : String = "en";
		public var mw_revealed_fax : String = "";
		public var mw_revealed_picture : String = "";
		public var rsl : XML = 
<rsl>
  <file url="rsla"/>
  <file url="rslCorrupt"/>
</rsl>;
		public var datatl2 : String = "assets/xmls/externalData2.xml";
		public var country : String = "en/france";
		public var nsProp1 : String = "prop1 no ns";
		public var mw_revealed_video : String = "";
		public var Role : String = "";
		public var baseURL : String = "assets/";
		public var rslCorrupt : String = "assets/crypto/swf/corruptCryptRsl.swf";
		public var property4 : String = "maProp3/4";
		public var cryptURL : String = "assets/crypto";
		public var XML_ResizePicture : XML = 
<XML_ResizePicture>
  <Loreal_Reference_IN_ResizePicture>
    <SourceFilename/>
    <DestinationFilename/>
    <Extension/>
    <EncodingParameters>
      <Quality/>
    </EncodingParameters>
    <Overwrite/>
    <Width/>
    <Height/>
  </Loreal_Reference_IN_ResizePicture>
</XML_ResizePicture>;
		public var nodeDescriptorB : XML = 
<nodeDescriptorB>
  <node id="ndB">
    <node id="A">
      <node id="A">
        <node id="A"/>
        <node id="B"/>
        <node id="C"/>
      </node>
      <node id="B">
        <node id="A"/>
        <node id="B"/>
        <node id="C"/>
      </node>
      <node id="C">
        <node id="A"/>
        <node id="B"/>
        <node id="C"/>
      </node>
    </node>
    <node id="B">
      <node id="A">
        <node id="A"/>
        <node id="B"/>
        <node id="C"/>
      </node>
      <node id="B">
        <node id="A"/>
        <node id="B"/>
        <node id="C"/>
      </node>
      <node id="C">
        <node id="A"/>
        <node id="B"/>
        <node id="C"/>
      </node>
    </node>
    <node id="C">
      <node id="A">
        <node id="A"/>
        <node id="B"/>
        <node id="C"/>
      </node>
      <node id="B">
        <node id="A"/>
        <node id="B"/>
        <node id="C"/>
      </node>
      <node id="C">
        <node id="A"/>
        <node id="B"/>
        <node id="C"/>
      </node>
    </node>
  </node>
</nodeDescriptorB>;
		public var SourceFilename : String = "";
		public var rsla : String = "assets/crypto/swf/rsl.swf";
		public var XML_WS_tellAFriend : XML = 
<XML_WS_tellAFriend>
  <Loreal_Reference_IN_TellAFriend>
    <SessionID/>
    <TemplateName/>
    <Friend>
      <FirstName/>
      <Email/>
    </Friend>
    <Customs>
      <mw_revealed_initiative_name/>
      <ForumId/>
      <PostID/>
    </Customs>
  </Loreal_Reference_IN_TellAFriend>
</XML_WS_tellAFriend>;
		public var swfURL : String = "assets/crypto/swf";
		public var imgURL : String = "assets/img";
		public var mw_revealed_website_video : String = "";
		public var nodeDescriptorA : XML = 
<nodeDescriptorA>
  <node id="ndA" default="C">
    <node id="A">
      <node id="AA">
        <node id="AAA"/>
        <node id="AAB"/>
      </node>
      <node id="AB">
        <node id="ABA"/>
        <node id="ABB"/>
      </node>
    </node>
    <node id="B">
      <node id="BA">
        <node id="BAA"/>
        <node id="BAB"/>
      </node>
      <node id="BB">
        <node id="BBA"/>
        <node id="BBB"/>
      </node>
    </node>
    <node id="C" default="CB">
      <node id="CA" default="CAB">
        <node id="CAA"/>
        <node id="CAB"/>
      </node>
      <node id="CB" default="CBA">
        <node id="CBA" default="CBAA">
          <node id="CBAA" default="CBAAA">
            <node id="CBAAA"/>
          </node>
        </node>
        <node id="CBAB"/>
        <node id="CBB"/>
      </node>
    </node>
  </node>
</nodeDescriptorA>;
		public var data1 : XML = 
<data1>
  <root>
    <noeud>cool</noeud>
    <dyn>en</dyn>
    <arbo>
      <noeud>cool</noeud>
    </arbo>
  </root>
  <root>
    <ert>cool</ert>
    <dyn2>en2</dyn2>
  </root>
</data1>;
		public var DestinationFilename : String = "";
		nsB var nsProp1 : String = "prop1 nsB";
		nsB var nsProp2 : String = "prop1 nsBZZZ";
		nsB var nsProp3 : String = "propNons-ZZZ";
		nsA var nsProp1 : String = "prop1 nsA";
		nsA var nsProp2 : String = "prop1 nsBZZZ";
		ns_1 var propWithNsDtl : XML = 
<propWithNsDtl>
  <node>prop</node>
  <datasInNs>
    <test>datasInNs</test>
  </datasInNs>
</propWithNsDtl>;
		ns_1 var nsDtl : XML = 
<nsDtl>
  <datasInNs>
    <test>datasInNs</test>
  </datasInNs>
</nsDtl>;




		public function getPropertiesNames() : Array {
			return _allQns_;
		}

		private const _allQns_ : Array = 	[

											new QName( "", "TemplateName" ),
											new QName( "", "FirstName" ),
											new QName( "", "initialization" ),
											new QName( "", "nodeDescriptorBExt" ),
											new QName( "", "xmlURL" ),
											new QName( "", "loadingExternalMedias" ),
											new QName( "", "data2" ),
											new QName( "", "XML_GetForumAdvInfo" ),
											new QName( "", "Extension" ),
											new QName( "", "cssURL" ),
											new QName( "", "SessionID" ),
											new QName( "", "Email" ),
											new QName( "", "loadingComplete" ),
											new QName( "", "css_basic" ),
											new QName( "", "loading" ),
											new QName( "", "scaleMode" ),
											new QName( "", "css_basic_conflict" ),
											new QName( "", "Overwrite" ),
											new QName( "", "distUnsecureDomain" ),
											new QName( "", "css_invalid" ),
											new QName( "", "showMenu" ),
											new QName( "", "ForumId" ),
											new QName( "", "PostID" ),
											new QName( "", "distSecureDomain" ),
											new QName( "", "css_complete" ),
											new QName( "", "ForumAdvId" ),
											new QName( "", "Quality" ),
											new QName( "", "css_extends" ),
											new QName( "", "align" ),
											new QName( "", "XML_SaveForumAdvPostInfo" ),
											new QName( "", "ForumAdvName" ),
											new QName( "", "bitmapToPreload" ),
											new QName( "", "XML_CreatUserInfo" ),
											new QName( "", "ForumAdvPostId" ),
											new QName( "", "Height" ),
											new QName( "", "lockedProp" ),
											new QName( "", "LastName" ),
											new QName( "", "testXml2" ),
											new QName( "", "Width" ),
											new QName( "", "Title" ),
											new QName( "", "depG" ),
											new QName( "", "sum123" ),
											new QName( "", "mediaToPreload" ),
											new QName( "", "depI" ),
											new QName( "", "BirthDate" ),
											new QName( "", "sum12" ),
											new QName( "", "FpApproved" ),
											new QName( "", "depH" ),
											new QName( "", "AddressLine1" ),
											new QName( "", "FpValid" ),
											new QName( "", "AddressLine2" ),
											new QName( "", "property1" ),
											new QName( "", "property2" ),
											new QName( "", "City" ),
											new QName( "", "mw_revealator_last_name" ),
											new QName( "", "whatCplx" ),
											new QName( "", "property3" ),
											new QName( "", "depF" ),
											new QName( "", "soundLibrairies" ),
											new QName( "", "mw_revealator_first_name" ),
											new QName( "", "definedAfter" ),
											new QName( "", "what" ),
											new QName( "", "Zip" ),
											new QName( "", "mw_revealator_telephone" ),
											new QName( "", "definedAfterCplx" ),
											new QName( "", "nsPropnoNs" ),
											new QName( "", "mw_revealator_email" ),
											new QName( "", "State" ),
											new QName( "", "depB" ),
											new QName( "", "siteMainFile" ),
											new QName( "", "CountryName" ),
											new QName( "", "soundsFile" ),
											new QName( "", "depC" ),
											new QName( "", "mw_revealed_initiative_name" ),
											new QName( "", "CountryCode" ),
											new QName( "", "mw_revealator_newsletter" ),
											new QName( "", "extManagerDatas" ),
											new QName( "", "depD" ),
											new QName( "", "nsProp2" ),
											new QName( "", "Phone" ),
											new QName( "", "external2" ),
											new QName( "", "mw_revealed_kind" ),
											new QName( "", "mw_revealed_en_desc" ),
											new QName( "", "depA" ),
											new QName( "", "depE" ),
											new QName( "", "dtl2" ),
											new QName( "", "mw_revealed_website_url" ),
											new QName( "", "mw_revealed_local_desc" ),
											new QName( "", "lang" ),
											new QName( "", "mw_revealed_fax" ),
											new QName( "", "mw_revealed_picture" ),
											new QName( "", "rsl" ),
											new QName( "", "datatl2" ),
											new QName( "", "country" ),
											new QName( "", "nsProp1" ),
											new QName( "", "mw_revealed_video" ),
											new QName( "", "Role" ),
											new QName( "", "baseURL" ),
											new QName( "", "rslCorrupt" ),
											new QName( "", "property4" ),
											new QName( "", "cryptURL" ),
											new QName( "", "XML_ResizePicture" ),
											new QName( "", "nodeDescriptorB" ),
											new QName( "", "SourceFilename" ),
											new QName( "", "rsla" ),
											new QName( "", "XML_WS_tellAFriend" ),
											new QName( "", "swfURL" ),
											new QName( "", "imgURL" ),
											new QName( "", "mw_revealed_website_video" ),
											new QName( "", "nodeDescriptorA" ),
											new QName( "", "data1" ),
											new QName( "", "DestinationFilename" ),
											new QName( "http://www.digitas.fr.flash.conftest/ns/nsB", "nsProp1" ),
											new QName( "http://www.digitas.fr.flash.conftest/ns/nsB", "nsProp2" ),
											new QName( "http://www.digitas.fr.flash.conftest/ns/nsB", "nsProp3" ),
											new QName( "http://www.digitas.fr.flash.conftest/ns/nsA", "nsProp1" ),
											new QName( "http://www.digitas.fr.flash.conftest/ns/nsA", "nsProp2" ),
											new QName( "http://www.digitas.fr.flash.conftest/ns/defaultNsDefConf", "propWithNsDtl" ),
											new QName( "http://www.digitas.fr.flash.conftest/ns/defaultNsDefConf", "nsDtl" )
											];

}