package com.taglib.pag;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.*;
import java.io.IOException;

public class pages extends pagerSupport implements BodyTag
{
	protected BodyContent bodyContent = null;
	protected int i = 0;
	protected int lastPage = 0;


	public void setBodyContent(BodyContent bc) 
  {
		bodyContent = bc;
	}

  /**
   * Method called at start of tag.
   * @return EVAL_BODY_TAG
   */
  public int doStartTag() throws JspException
  {
		super.doStartTag();

    
		i = 0;
		lastPage = pagerTag.pageNumber(pagerTag.getItemCount());

		// if lastPage > maxIndexPages, mette currentPage al centro della pagina
		if (lastPage > pagerTag.getMaxIndexPages())
    {
			int currentPage = pagerTag.getPageNumber();
			i = currentPage - (pagerTag.getMaxIndexPages() / 2);
			if (i < 0) i = 0;

			if ((lastPage - i) < pagerTag.getMaxIndexPages())
				i -= pagerTag.getMaxIndexPages() - (lastPage - i);

			if (lastPage > (i + pagerTag.getMaxIndexPages()))
				lastPage = i + pagerTag.getMaxIndexPages();
		}

		return EVAL_BODY_AGAIN;
  }

	public void doInitBody() throws JspException 
  {
		pageContext.setAttribute(PAGE_URL, pagerTag.getPageUrl(i));
		pageContext.setAttribute(PAGE_NUMBER, pagerTag.getPageNumber(i));
		i++;
	}

  /**
   * Method called at end of tag.
   * @return EVAL_PAGE
   */
  public int doEndTag()
  {
    return EVAL_PAGE;
  }


  /**
   * Method is invoked after every body evaluation to control whether the body will be reevaluated or not.
   * @return SKIP_BODY
   */
  public int doAfterBody() throws JspException
  {
		if (i < lastPage) 
    {
			pageContext.setAttribute(PAGE_URL, pagerTag.getPageUrl(i));
			pageContext.setAttribute(PAGE_NUMBER, pagerTag.getPageNumber(i));
			i++;
			return EVAL_BODY_AGAIN;
		}
    else 
    {
			try 
      {
				bodyContent.writeOut(bodyContent.getEnclosingWriter());
				return SKIP_BODY;
			}
      catch (IOException e) 
      {
				throw new JspTagException(e.toString());
			}
		}
  }
  	public void release() 
    {
      bodyContent = null;
      i = 0;
      lastPage = 0;
      super.release();
	}

}