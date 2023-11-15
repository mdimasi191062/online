package com.taglib.pag;

import java.io.UnsupportedEncodingException;

import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.*;

public class param extends pagerSupport 
{
  /*
  tag attribute: name
  */

  private String name = "";
  /*
  tag attribute: value
  */
  private String value = "";



  /**
   * Method called at start of tag.
   * @return EVAL_BODY_TAG
   */
  public int doStartTag() throws JspException
  {
		super.doStartTag();
    try {
		pagerTag.addParam(name, value);
    }
    catch (UnsupportedEncodingException ue)
    { 
      new JspException(ue.getMessage());
    }
		return EVAL_BODY_INCLUDE;
  }

	public void release() 
  {
		name = null;
		value = null;
		super.release();
	}


  public void setName(String value)
  {
    name = value;
  }


  public String getName()
  {
    return name;
  }


  public void setValue(String val)
  {
    value = val;
  }


  public String getValue()
  {
    return value;
  }
}