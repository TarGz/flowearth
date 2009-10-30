package bi.ant.types;

import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.util.StringUtils;

public class Font {
	
	
	
	public Font() {

	}
	
	public String getOutput() {
		
		String res = embedTemplate + StringUtils.LINE_SEP + classTemplate+ StringUtils.LINE_SEP+ StringUtils.LINE_SEP;
		res = res.replaceAll("\\$\\{fontStyle\\}", fontStyle );
		res = res.replaceAll("\\$\\{fontWeight\\}", fontWeight );
		res = res.replaceAll("\\$\\{unicodeRange\\}", unicodeRange );
		res = res.replaceAll("\\$\\{fontName\\}", fontFamily );
		res = res.replaceAll("\\$\\{source\\}", getSource() );
		
		res = res.replaceAll("\\$\\{className\\}", getClassName() );
		
		return res;
	}


	public void setFontFamily(String fontFamily) throws BuildException {
		this.fontFamily = fontFamily;
	}

	public void setUnicodeRange(String unicodeRange) throws BuildException {
		this.unicodeRange = unicodeRange;
	}
	
	public void setSourceFile(String fontSource) throws BuildException {
		this.fontSourceFile = fontSource;
	}

	public void setSourceName(String fontSource) throws BuildException {
		this.fontSourceName = fontSource;
	}

	public void setFontWeight(String fontWeight) throws BuildException {
		if( ! fontWeight.equals( "normal" ) && ! fontWeight.equals( "bold" ) )
			throw new BuildException( "fontweight attribute can be 'bold' or 'normal', found : "+fontWeight );
		this.fontWeight = fontWeight;
	}

	public void setFontStyle(String fontStyle) throws BuildException {
		if( ! fontStyle.equals( "normal" ) && ! fontStyle.equals( "italic" ) )
				throw new BuildException( "fontstyle attribute can be 'italic' or 'normal', found : "+fontStyle );
		this.fontStyle = fontStyle;
	}
	

	private String getSource() {
		if( fontSourceFile != null )
			return "source='"+fontSourceFile+"'";
		else if( fontSourceName != null )
			return "systemFont='"+fontSourceName+"'";
		else
			throw new BuildException( "sourceName or sourceFile must be defined" );
	}

	public String fontFamily;

	public String unicodeRange = "U+0000-U+FFFF";

	public String fontSourceFile;
	
	public String fontSourceName;

	public String fontWeight = "normal";
	
	public String fontStyle = "normal";
	
	public String getClassName() {
		return "_embed__font_"+fontFamily+"_"+fontWeight;
	}
	
	//systemFont='Font'
	//source='c:/Font'
	private String embedTemplate = "[Embed(fontStyle='${fontStyle}', fontWeight='${fontWeight}', unicodeRange='${unicodeRange}', fontName='${fontName}', ${source}, _pathsep='true', mimeType='application/x-font')]";
	private String classTemplate = "private static var ${className}:Class;";

}
