package com.utl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public final class RequestWrapper extends HttpServletRequestWrapper
{
  protected static final boolean ALWAYS_MAKE_TAGS = true;
  /**
   * flag determing whether comments are allowed in input String.
   */
  protected static String[] vRemoveBlanks;
  protected static final boolean STRIP_COMMENTS = true;
  /** regex flag union representing /si modifiers in php **/
  protected static final int REGEX_FLAGS_SI = Pattern.CASE_INSENSITIVE | Pattern.DOTALL;
  /** set of allowed html elements, along with allowed attributes for each element **/
  protected static Map<String,List<String>> vAllowed;
  /** counts of open tags for each (allowable) html element **/
  protected static Map<String,Integer> vTagCounts;
  /** html elements which must always be self-closing (e.g. "<img />") **/
  protected static String[] vSelfClosingTags;
  /** html elements which must always have separate opening and closing tags (e.g. "<b></b>") **/
  protected static String[] vNeedClosingTags;
  /** attributes which should be checked for valid protocols **/
  protected static String[] vProtocolAtts;
  /** allowed protocols **/
  protected static String[] vAllowedProtocols;
  /** tags which should be removed if they contain no content (e.g. "<b></b>" or "<b />") **/
  /** entities allowed within html markup **/
  protected static String[] vAllowedEntities;
    
	public RequestWrapper(HttpServletRequest servletRequest)
	{
		super(servletRequest);
	}

	public String[] getParameterValues(String parameter)
	{

		String[] values = super.getParameterValues(parameter);
		if (values==null)
		{
			return null;
		}
		int count = values.length;
		String[] encodedValues = new String[count];
		for (int i = 0; i < count; i++)
		{
			encodedValues[i] = cleanXSS(values[i]);
		}
		return encodedValues;
	}

	public String getParameter(String parameter)
	{
		String value = super.getParameter(parameter);
		if (value == null)
		{
			return null;
		}
		return cleanXSS(value);
	}

	public String getHeader(String name)
	{
		String value = super.getHeader(name);
		if (value == null)
			return null;
		return cleanXSS(value);

	}

	private static String replaceAll( String source, String toReplace, String replacement)
  {
		int idx = source.lastIndexOf( toReplace );
		if ( idx != -1 )
		{
			StringBuffer ret = new StringBuffer( source );
			ret.replace( idx, idx+toReplace.length(), replacement );
			while ( (idx=source.lastIndexOf(toReplace, idx-1)) != -1 )
			{
				ret.replace( idx, idx+toReplace.length(), replacement );
			}
			source = ret.toString();
		}
		return source;
	}

	protected static String cleanXSS_2(String value)
	{
		value = replaceAll(value,"<img>", "");
		value = replaceAll(value,"</img>", "");
		value = replaceAll(value,"<script>", "");
		value = replaceAll(value,"</script>", "");
		value = replaceAll(value,"<a>", "");
		value = replaceAll(value,"http", "");
		value = replaceAll(value,"ftp", "");
		value = replaceAll(value,"mailto", "");
		value = replaceAll(value,"telnet", "");
		value = replaceAll(value,"</a>", "");
		value = replaceAll(value,"<IMG>", "");
		value = replaceAll(value,"</IMG>", "");
		value = replaceAll(value,"<SCRIPT>", "");
		value = replaceAll(value,"</SCRIPT>", "");
		value = replaceAll(value,"<A>", "");
		value = replaceAll(value,"</A>", "");
		value = replaceAll(value,"\\(", "& #40;");
		value = replaceAll(value,"\\)", "& #41;");
		value = replaceAll(value,"'", "");
		value = replaceAll(value,"EVAL\\((.*)\\)", "");
		value = replaceAll(value,"[\\\"\\\'][\\s]*JAVASCRIPT:(.*)[\\\"\\\']", "\"\"");
		value = replaceAll(value,"eval\\((.*)\\)", "");
		value = replaceAll(value,"[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
		return value;
	}
  
  protected static void reset()
  {
    vTagCounts = new HashMap<String,Integer>();
  }
  
//  public synchronized String filter( String input )
  public static String cleanXSS( String input )  
  {
    vAllowed = new HashMap<String,List<String>>();
    vTagCounts = new HashMap<String,Integer>();
    
    ArrayList<String> a_atts = new ArrayList<String>();
    a_atts.add( "href" );
    a_atts.add( "target" );
    vAllowed.put( "a", a_atts );
    
    ArrayList<String> img_atts = new ArrayList<String>();
    img_atts.add( "src" );
    img_atts.add( "width" );
    img_atts.add( "height" );
    img_atts.add( "alt" );
    vAllowed.put( "img", img_atts );
    
    ArrayList<String> no_atts = new ArrayList<String>();
    vAllowed.put( "b", no_atts );
    vAllowed.put( "strong", no_atts );
    vAllowed.put( "i", no_atts );
    vAllowed.put( "em", no_atts );
    
    vSelfClosingTags = new String[] { "img" };
    vNeedClosingTags = new String[] { "a", "b", "strong", "i", "em" };
    vAllowedProtocols = new String[] { "http", "mailto" }; // no ftp.
    vProtocolAtts = new String[] { "src", "href" };
    vRemoveBlanks = new String[] { "a", "b", "strong", "i", "em" };
    vAllowedEntities = new String[] { "amp", "gt", "lt", "quot" };
    
    reset();
    String s = input;
    
//    System.out.println( "************************************************" );
//    System.out.println( "              INPUT: " + input );
    
    s = escapeComments(s);
//    System.out.println( "     escapeComments: " + s );
    
    s = balanceHTML(s);
//    System.out.println( "        balanceHTML: " + s );
    
    s = checkTags(s);
//    System.out.println( "          checkTags: " + s );
    
    s = processRemoveBlanks(s);
//    System.out.println( "processRemoveBlanks: " + s );
    
//    s = validateEntities(s);
//    System.out.println( "    validateEntites: " + s );
    
//    System.out.println( "************************************************\n\n" );
    return s;
  }

 
  protected static String escapeComments( String s )
  {
    Pattern p = Pattern.compile( "<!--(.*?)-->", Pattern.DOTALL );
    Matcher m = p.matcher( s );
    StringBuffer buf = new StringBuffer();
    if (m.find()) {
      String match = m.group( 1 ); //(.*?)
      m.appendReplacement( buf, "<!--" + htmlSpecialChars( match ) + "-->" );
    }
    m.appendTail( buf );
    
    return buf.toString();
  }
 
  public static String htmlSpecialChars( String s )
  {
    s = s.replaceAll( "&", "&amp;" );
    s = s.replaceAll( "\"","&quot;" );
    s = s.replaceAll( "<", "&lt;" );
    s = s.replaceAll( ">", "&gt;" );
    s = s.replaceAll( "#", "&#35;" );
    s = s.replaceAll( "'", "&apos;" );
    s = s.replaceAll( "(", "&#40;" );
    s = s.replaceAll( ")", "&#41;" );
    s = s.replaceAll( "`", "%60" );
    return s;
  }

  protected static String balanceHTML( String s )
  {
    if (ALWAYS_MAKE_TAGS) 
    {
      //
      // try and form html
      //
      s = regexReplace("^>", "", s);
      s = regexReplace("<([^>]*?)(?=<|$)", "<$1>", s);
      s = regexReplace("(^|>)([^<]*?)(?=>)", "$1<$2", s);
      
    } 
    else
    {
      //
      // escape stray brackets
      //
      s = regexReplace("<([^>]*?)(?=<|$)", "&lt;$1", s);
      s = regexReplace("(^|>)([^<]*?)(?=>)", "$1$2&gt;<", s);
      
      //
      // the last regexp causes '<>' entities to appear
      // (we need to do a lookahead assertion so that the last bracket can
      // be used in the next pass of the regexp)
      //
      s = s.replaceAll("<>", "");
    }
    
    return s;
  }
  
  
  protected static String regexReplace( String regex_pattern, String replacement, String s )
  {
    Pattern p = Pattern.compile( regex_pattern );
    Matcher m = p.matcher( s );
    return m.replaceAll( replacement );
  }

  protected static String checkTags( String s )
  {   
    Pattern p = Pattern.compile( "<(.*?)>", Pattern.DOTALL );
    Matcher m = p.matcher( s );
    
    StringBuffer buf = new StringBuffer();
    while (m.find()) {
      String replaceStr = m.group( 1 );
      replaceStr = processTag( replaceStr );
      m.appendReplacement(buf, replaceStr);
    }
    m.appendTail(buf);
    
    s = buf.toString();
    
    // these get tallied in processTag
    // (remember to reset before subsequent calls to filter method)
    for( String key : vTagCounts.keySet())
    {
      for(int ii=0; ii<vTagCounts.get(key); ii++) {
        s += "</" + key + ">";
      }
    }
    
    return s;
  }

  protected static String processTag( String s )
  {   
    // ending tags
    Pattern p = Pattern.compile( "^/([a-z0-9]+)", REGEX_FLAGS_SI );
    Matcher m = p.matcher( s );
    if (m.find()) {
      String name = m.group(1).toLowerCase();
      if (vAllowed.containsKey( name )) {
        if (!inArray(name, vSelfClosingTags)) {
          if (vTagCounts.containsKey( name )) {
            vTagCounts.put(name, vTagCounts.get(name)-1);
            return "</" + name + ">";
          }
        }
      }
    }
    
    // starting tags
    p = Pattern.compile("^([a-z0-9]+)(.*?)(/?)$", REGEX_FLAGS_SI);
    m = p.matcher( s );
    if (m.find()) {
      String name = m.group(1).toLowerCase();
      String body = m.group(2);
      String ending = m.group(3);
      
      //debug( "in a starting tag, name='" + name + "'; body='" + body + "'; ending='" + ending + "'" );
      if (vAllowed.containsKey( name )) {
        String params = "";
        
        Pattern p2 = Pattern.compile("([a-z0-9]+)=([\"'])(.*?)\\2", REGEX_FLAGS_SI);
        Pattern p3 = Pattern.compile("([a-z0-9]+)(=)([^\"\\s']+)", REGEX_FLAGS_SI);
        Matcher m2 = p2.matcher( body );
        Matcher m3 = p3.matcher( body );
        List<String> paramNames = new ArrayList<String>();
        List<String> paramValues = new ArrayList<String>();
        while (m2.find()) {
          paramNames.add(m2.group(1)); //([a-z0-9]+)
          paramValues.add(m2.group(3)); //(.*?)
        }
        while (m3.find()) {
          paramNames.add(m3.group(1)); //([a-z0-9]+)
          paramValues.add(m3.group(3)); //([^\"\\s']+)
        }
        
        String paramName, paramValue;
        for( int ii=0; ii<paramNames.size(); ii++ ) {
          paramName = paramNames.get(ii).toLowerCase();
          paramValue = paramValues.get(ii);
          
          //debug( "paramName='" + paramName + "'" );
          //debug( "paramValue='" + paramValue + "'" );
          //debug( "allowed? " + vAllowed.get( name ).contains( paramName ) );
          
          if (vAllowed.get( name ).contains( paramName )) {
            if (inArray( paramName, vProtocolAtts )) {
              paramValue = processParamProtocol( paramValue );
            }
            params += " " + paramName + "=\"" + paramValue + "\"";
          }
        }
        
        if (inArray( name, vSelfClosingTags )) {
          ending = " /";
        }
        
        if (inArray( name, vNeedClosingTags )) {
          ending = "";
        }
        
        if (ending == null || ending.length() < 1) {
          if (vTagCounts.containsKey( name )) {
            vTagCounts.put( name, vTagCounts.get(name)+1 );
          } else {
            vTagCounts.put( name, 1 );
          }
        } else {
          ending = " /";
        }
        return "<" + name + params + ending + ">";
      } else {
        return "";
      }
    }
    
    // comments
    p = Pattern.compile( "^!--(.*)--$", REGEX_FLAGS_SI );
    m = p.matcher( s );
    if (m.find()) {
      String comment = m.group();
      if (STRIP_COMMENTS) {
        return "";
      } else {
        return "<" + comment + ">"; 
      }
    }
    
    return "";
  }

  private static boolean inArray( String s, String[] array )
  {
    for (String item : array)
      if (item != null && item.equals(s))
        return true;
    
    return false;
  }

  protected static String processParamProtocol( String s )
  {
    s = decodeEntities( s );
    Pattern p = Pattern.compile( "^([^:]+):", REGEX_FLAGS_SI );
    Matcher m = p.matcher( s );
    if (m.find()) {
      String protocol = m.group(1);
      if (!inArray( protocol, vAllowedProtocols )) {
        // bad protocol, turn into local anchor link instead
        s = "#" + s.substring( protocol.length()+1, s.length() );
        if (s.startsWith("#//")) s = "#" + s.substring( 3, s.length() );
      }
    }
    
    return s;
  }

  protected static String decodeEntities( String s )
    {
      StringBuffer buf = new StringBuffer();
      
      Pattern p = Pattern.compile( "&#(\\d+);?" );
      Matcher m = p.matcher( s );
      while (m.find()) {
        String match = m.group( 1 );
        int decimal = Integer.decode( match ).intValue();
        m.appendReplacement( buf, chr( decimal ) );
      }
      m.appendTail( buf );
      s = buf.toString();
      
      buf = new StringBuffer();
      p = Pattern.compile( "&#x([0-9a-f]+);?");
      m = p.matcher( s );
      while (m.find()) {
        String match = m.group( 1 );
        int decimal = Integer.decode( match ).intValue();
        m.appendReplacement( buf, chr( decimal ) );
      }
      m.appendTail( buf );
      s = buf.toString();
      
      buf = new StringBuffer();
      p = Pattern.compile( "%([0-9a-f]{2});?");
      m = p.matcher( s );
      while (m.find()) {
        String match = m.group( 1 );
        int decimal = Integer.decode( match ).intValue();
        m.appendReplacement( buf, chr( decimal ) );
      }
      m.appendTail( buf );
      s = buf.toString();
      
      s = validateEntities( s );
      return s;
    }

  protected static String validateEntities( String s )
  {
    try{     
      // validate entities throughout the string
      Pattern p = Pattern.compile( "&([^&;]*)(?=(;|&|$))" );
      Matcher m = p.matcher( s );
      if (m.find()) {
        String one = m.group( 1 ); //([^&;]*) 
        String two = m.group( 2 ); //(?=(;|&|$))
        s = checkEntity(one, two );
      }
      
      // validate quotes outside of tags
      p = Pattern.compile( "(>|^)([^<]+?)(<|$)", Pattern.DOTALL );
      m = p.matcher( s );
      StringBuffer buf = new StringBuffer();
      if (m.find()) {
        String one = m.group( 1 ); //(>|^) 
        String two = m.group( 2 ); //([^<]+?) 
        String three = m.group( 3 ); //(<|$)
        m.appendReplacement( buf, one + two.replaceAll( "\"", "&quot;" ) + three);
      }
      m.appendTail( buf );
      
      return s;
    }catch(Exception e)
    {
      //System.out.println("validateEntities - ["+e.getMessage()+"]");
      return s;
    }
  }
  
  protected static String checkEntity(String preamble, String term )
  {
    if (!term.equals(";")) {
      return "&amp;" + preamble;
    }
    
    if ( isValidEntity( preamble ) ) {
      return "&" + preamble;
    }
    
    return "&amp;" + preamble;
  }
  
  protected static boolean isValidEntity( String entity )
  {
    return inArray( entity, vAllowedEntities );
  }

  public static String chr( int decimal )
  {
    return String.valueOf( (char) decimal );
  }

  protected static String processRemoveBlanks( String s )
  {
    for( String tag : vRemoveBlanks )
    {
      s = regexReplace( "<" + tag + "(\\s[^>]*)?></" + tag + ">", "", s );
      s = regexReplace( "<" + tag + "(\\s[^>]*)?/>", "", s );
    }
    
    return s;
  }
    
}

