package com.taglib.pag;

import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.*;

public class pagerSupport  extends TagSupport
{

	public static final String PAGE_URL    = "pageUrl";
	public static final String PAGE_NUMBER = "pageNumber";

	protected pager pagerTag = null;
	protected Object oldPageUrl = null;
	protected Object oldPageNumber = null;


	public int doStartTag() throws JspException 
  {
		pagerTag = (pager) findAncestorWithClass(this, pager.class);
		if (pagerTag == null)
			throw new JspTagException("not nested within a pager tag.");

		oldPageUrl = pageContext.getAttribute(PAGE_URL);
		oldPageNumber = pageContext.getAttribute(PAGE_NUMBER);

		return EVAL_BODY_INCLUDE;
	}

	public int doEndTag() throws JspException 
  {
		if (oldPageUrl != null)
			pageContext.setAttribute(PAGE_URL, oldPageUrl);
		else 
			pageContext.removeAttribute(PAGE_URL);
		if (oldPageNumber != null)
			pageContext.setAttribute(PAGE_NUMBER, oldPageNumber);
		else 
			pageContext.removeAttribute(PAGE_NUMBER);
		return EVAL_BODY_INCLUDE;
	}

	public void release() 
  {
		pagerTag = null;
		oldPageUrl = null;
		oldPageNumber = null;
		super.release();
	}
}