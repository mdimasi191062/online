package com.taglib.pag;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.*;

public class prev extends indexSupport 
{

  /**
   * Method called at start of tag.
   * @return EVAL_BODY_TAG
   */
  public int doStartTag() throws JspException
  {
		super.doStartTag();

		if (pagerTag.hasPrevPage()) 
    {
			pageContext.setAttribute(PAGE_URL,pagerTag.getPrevPageUrl());
			pageContext.setAttribute(PAGE_NUMBER,pagerTag.getPrevPageNumber());
		}
    else 
    {
			if (!ifnull)
				return SKIP_BODY;

			pageContext.removeAttribute(PAGE_URL);
			pageContext.removeAttribute(PAGE_NUMBER);
		}

		return EVAL_BODY_INCLUDE;
  }
}