# Introduction #

You can use two reserved kewords in a conf file :
> - "externalConf"
> - "externalData"

The first one lets you externalize a part of your configuration properties into one or more external files.

The second one lets you load the content of any text file into a Conf property


# Usage #

## externalConf ##

mainConf.xml
```
<conf>

   <prop_one>depend external prop 2 : ${prop_two}</prop_one>

   <externalConf>
      <file>myExternalConf.xml</file>
   <externalConf>

</conf>

```

myExternalConf.xml
```
<conf>

   <prop_two>my external prop 2</prop_two>

</conf>

```

while parsing the main conf file, the Conf class will automatically load externals files and solving properties.


## externalData ##


It's quite the same format as externalConf, except you put and id to file node, this id can be used to retreive the content of the file as a String property of the conf.


### exemple ###

external\_data.css
```

.header_style 
{
	font-size: 12;
	font-family: arial;
	antiAliasType: advanced;
}

.footer_style {
	font-family: NissanAGMedium;
	font-size: 12;
	wordWrap: false;
	selectable: false;
}

```

some\_conf\_file.xml
```
<conf>

   <externalData>
      <file id="myStyle">external_data.css</file>
   <externalData>

</conf>

```

Internally, the content of the file is inserted into a node with the same name as id attribute.

The previous example is the same than write :

some\_conf\_file.xml
```
<conf>

   <myStyle>

.header_style 
{
	font-size: 12;
	font-family: arial;
	antiAliasType: advanced;
}

.footer_style {
	font-family: NissanAGMedium;
	font-size: 12;
	wordWrap: false;
	selectable: false;
}

   </myStyle>

</conf>

```

Note that the external data's file will be interpretted as XML (to be insert in a Conf prop). So xml char should be escaped.


