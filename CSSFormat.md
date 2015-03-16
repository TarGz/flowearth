# Basic css example #

```
.default {
        font-family: customFont;
	autoSize: left;
	antiAliasType: advanced;
	thickness: -40;
	sharpness: 80;
	embedFonts: true;
	
}

.titleh1>.default {
	font-size: 18;
}

.titleh2>.default {
	font-size: 15;
        autoSize: none;
}

```

You can use all available _StyleSheet_ properties and all TextField properties.

".default" is use as abstract style intended to be extend by other style. Use '>' char to specify the parent style.

You can override a property already defined in the super style.

# register a CSS file #

Use styleManager singleton to register one or more css files.
All the css styles will be available to format a textfield.

```

// String result of a loaded CSS file
var cssString : String = "..." ;

styleManager.addCss( cssString );
 
```

To avoid naming conflict, when you register several css files, you can register under a specific namespace.

```
namespace globalStyles = "http://domain.com/ns/css/global";

var cssString : String = "..." ;

styleManager.addCss( cssString, globalStyles .uri );
```

See how to retreive a style register into specific namespace in the next chapter.

# Apply style to a textField #

```

var title : TextField = new TextField();

var title_text : String = "My Title";

var title_style : String = ".titleh1";

styleManager.apply( title , title_style , title_text );	

```

To lookup for specific namespace, when you apply the format :

```

namespace globalStyles = "http://domain.com/ns/css/global";
//
var title : TextField = new TextField();

var title_text : String = "My Title";

var title_style : Qname = new Qname( globalStyles, ".titleh1" );

styleManager.apply( title , title_style , title_text );	

```

# Display rich html text #

When apply a specific style to a textField, the StyleSheet containing this style is also apply to textField, you can use html format to apply other styles of the css to the textField :

```

.description {
	width: 200;
	multiline: true;
	wordWrap: true;
	font-family: Arial;
	font-size: 11;
	color: #000000;
}

.link {
	font-size: 11;
	color: #cc3300;
	text-decoration: underline;
}

.bold_grey {
	font-size: 13;
	color: #4c4c4c;
	font-weight: bold;
}

```

```

var desc : TextField = new TextField();

var desc_text : String = 
 "This is a  <span class='link'>rich html text </span> with multiple format appied to a <span class='bold_grey'>Textfield</span>.";

var desc_style : String = ".description";

styleManager.apply( desc, desc_style, desc_text );	

```

result of this textfield :

![http://flowearth.googlecode.com/svn/branches/sandbox/pierre.lepers/trunk/framework/docs/tutorials/fonts_and_styles/deploy/result_illus.png](http://flowearth.googlecode.com/svn/branches/sandbox/pierre.lepers/trunk/framework/docs/tutorials/fonts_and_styles/deploy/result_illus.png)