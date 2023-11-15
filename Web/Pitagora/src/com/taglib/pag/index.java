package com.taglib.pag;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.*;

public class index extends pagerSupport 
{

  /**
   * Method called at start of tag.
   * @return EVAL_BODY_TAG
   */
  public int doStartTag() throws JspException
  {
		super.doStartTag();

		// Se il numero di elementi è minore del max numero per pagina non è necessario l'idice

		if (pagerTag.getOffset() == 0 && 	pagerTag.getItemCount() <= pagerTag.getMaxPageItems())
			return SKIP_BODY;

		return EVAL_BODY_INCLUDE;
  }


  /**
   * Method called at end of tag.
   * @return EVAL_PAGE
   */
  public int doEndTag()
  {
    return EVAL_PAGE;
  }

}