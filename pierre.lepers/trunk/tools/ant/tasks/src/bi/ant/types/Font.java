package bi.ant.types;

import java.awt.geom.IllegalPathStateException;
import java.io.File;

import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.Project;
import org.apache.tools.ant.types.Path;
import org.apache.tools.ant.util.StringUtils;

public class Font {
	
	
	
	private Project _project;

	public Font( ) {
		
	}
	
	public String getOutput() {
		
		String res = embedTemplate + StringUtils.LINE_SEP + classTemplate+ StringUtils.LINE_SEP+ StringUtils.LINE_SEP;
		res = res.replaceAll("\\$\\{fontStyle\\}", fontStyle );
		res = res.replaceAll("\\$\\{fontWeight\\}", fontWeight );
		res = res.replaceAll("\\$\\{unicodeRange\\}", getUnicodeRange() );
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

	public void setChars(String charsStr) throws BuildException {
		chars = cleanChars( charsStr );
	}
	
	private char[] cleanChars ( String input ) {
		char[] in = input.toCharArray();
		String buff = "";
		for (int i = 0; i < in.length; i++) {
			if( buff.indexOf(in[i]) == -1 )
				buff += in[i];
		}
		
		return buff.toCharArray();
	}

	public void setSourceFile(Path fontSource) throws BuildException {
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
	
	public String getUnicodeRange() {
		if( chars != null )
			return charsToRange();
		return unicodeRange;
		
	}
	

	private String getSource() {
		if( fontSourceFile != null )
			return "source='"+fontSourceFile.toString().replace("\\", "/")+"'";
		else if( fontSourceName != null )
			return "systemFont='"+fontSourceName+"'";
		else
			throw new BuildException( "sourceName or sourceFile must be defined" );
	}
	

	
	private String charsToRange() {
		String res = "";
		int l = chars.length;
		String hex;
		for (int i = 0; i < l; i++) {
			char c = chars[i];
			hex = (Integer.toHexString((int)c));
			while ( hex.length() < 4 ) 
				hex = "0"+hex;
			res += "U+"+hex;
			if( i < l-1 )res += ",";
		}
		
		return res;
	}

	public String fontFamily;

	public String unicodeRange = "U+0000-U+FFFF";
	
	public char[] chars;

	public Path fontSourceFile;
	
	public String fontSourceName;

	public String fontWeight = "normal";
	
	public String fontStyle = "normal";
	
	public String getClassName() {
		String fm = fontFamily.replaceAll( " ", "_" );
		fm = fm.replaceAll( "-", "_" );
		return "_embed__font_"+fm+"_"+fontWeight;
	}
	
	//systemFont='Font'
	//source='c:/Font'
	private String embedTemplate = "[Embed(fontStyle='${fontStyle}', fontWeight='${fontWeight}', unicodeRange='${unicodeRange}', fontName='${fontName}', ${source}, _pathsep='true', mimeType='application/x-font')]";
	private String classTemplate = "private static var ${className}:Class;";

	public void setProject ( Project project ) {
		_project = project;
	}

}
