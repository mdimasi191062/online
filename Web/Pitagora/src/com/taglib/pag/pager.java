package com.taglib.pag;

import com.utl.StaticContext;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.*;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

public class pager extends TagSupport 
{

	public static final String DEFAULT_ID = "pager";
	public static final int 	DEFAULT_MAX_ITEMS = Integer.MAX_VALUE;
	public static final int		DEFAULT_MAX_PAGE_ITEMS = 10;
	public static final int		DEFAULT_MAX_INDEX_PAGES = 10;

	public static final String PAGE_NUMBER = "PageNumber";
	public static final String 	OFFSET = "Offset";
	public static final String 	MAX_ITEMS = "MaxItems";
	public static final String 	OFFSET_PARAM = ".offset";

  protected int offset = 0;
	protected int itemCount = 0;
	protected boolean maxItemsReached = false;
	protected String params = null;
	protected int pageNumber = 0;
	protected Integer pageNumberInteger = null;
	protected Object oldPageNumber = null;
	protected Object oldOffset = null;
	protected Object oldMaxItems = null;

  /*
  tag attribute: id
  */

  protected String id =DEFAULT_ID;
  /*
  tag attribute: url
  */
  protected String url = "";
  /*
  tag attribute: maxItems
  */
  protected int maxItems = DEFAULT_MAX_ITEMS;
  /*
  tag attribute: maxPageItems
  */
  protected int maxPageItems = DEFAULT_MAX_PAGE_ITEMS;
  /*
  tag attribute: maxIndexPages
  */
  protected int maxIndexPages = DEFAULT_MAX_INDEX_PAGES;
  /*
  tag attribute: isOffset
  */
  protected boolean isOffset = false;
  /*
  tag attribute: totalItemCount
  */
  private int totalItemCount;


  /**
   * Method called at start of tag.
   * @return EVAL_BODY_TAG
   */
  public int doStartTag() throws JspException
  {
		if (url == null) 
    {
			url = ((HttpServletRequest)pageContext.getRequest())	.getRequestURI();
			int i = url.indexOf('?');
			if (i != -1)
				url = url.substring(0, i);
		}

		String tmp = pageContext.getRequest().getParameter(id+OFFSET_PARAM);
		if (tmp != null) 
    {
			try 
      {
				offset = Integer.parseInt(tmp);
				if (offset < 0)
					offset = 0;
				if (isOffset)
					itemCount = offset;

			}
      catch (NumberFormatException e) 
      {
			}
		}

    itemCount=totalItemCount;
		pageNumber = pageNumber(offset);
		pageNumberInteger = new Integer(1+pageNumber);

		pageContext.setAttribute(id+PAGE_NUMBER, pageNumberInteger);
		pageContext.setAttribute(id+OFFSET, new Integer(offset));
		pageContext.setAttribute(id+MAX_ITEMS, new Integer(maxItems));

		return EVAL_BODY_INCLUDE;
  }


  /**
   * Method called at end of tag.
   * @return EVAL_PAGE
   */
  public int doEndTag()
  {
		if (oldPageNumber != null)
			pageContext.setAttribute(id+PAGE_NUMBER, oldPageNumber);
		else 
			pageContext.removeAttribute(id+PAGE_NUMBER);

		if (oldOffset != null)
			pageContext.setAttribute(id+OFFSET, oldOffset);
		else 
			pageContext.removeAttribute(id+OFFSET);

		if (oldMaxItems != null)
			pageContext.setAttribute(id+MAX_ITEMS, oldMaxItems);
		else 
			pageContext.removeAttribute(id+MAX_ITEMS);

		return EVAL_BODY_INCLUDE;
  }

	public void release() 
  {
		id = DEFAULT_ID;
		maxItems = DEFAULT_MAX_ITEMS;
		maxPageItems = DEFAULT_MAX_PAGE_ITEMS;
		maxIndexPages = DEFAULT_MAX_INDEX_PAGES;
		isOffset = false;
		offset = 0;
		itemCount = 0;
		url = null;
		params = null;
		pageNumber = 0;
		pageNumberInteger = null;
		oldPageNumber = null;
		oldOffset = null;
		oldMaxItems = null;
		super.release();
	}



  public void setId(String value)
  {
    id = value;
  }


  public String getId()
  {
    return id;
  }


  public void setUrl(String value)
  {
    url = value;
  }


  public String getUrl()
  {
    return url;
  }


  public void setMaxItems(int value)
  {
    maxItems = value;
  }


  public int getMaxItems()
  {
    return maxItems;
  }


  public void setMaxPageItems(int value)
  {
    maxPageItems = value;
  }


  public int getMaxPageItems()
  {
    return maxPageItems;
  }


  public void setMaxIndexPages(int value)
  {
    maxIndexPages = value;
  }


  public int getMaxIndexPages()
  {
    return maxIndexPages;
  }


  public void setIsOffset(boolean value)
  {
    isOffset = value;
  }


  public boolean getIsOffset()
  {
    return isOffset;
  }





  /****************************************************************************************************************************************
  ******************FUNZIONI DI UTILITA'
  ****************************************************************************************************************************************/
  	public void addParam(String name, String value) throws UnsupportedEncodingException
    {
      if (value == null)
        value = pageContext.getRequest().getParameter(name);

      if (value != null) 
      {
        name = java.net.URLEncoder.encode(name,StaticContext.ENCCharset);
        value = java.net.URLEncoder.encode(value,StaticContext.ENCCharset);

        if (params == null)
          params = "?" + name + "=" + value;
        else
          params += "&" + name + "=" + value;
      }
	}


	public int getOffset() 
  {
		return offset;
	}


	public int getItemCount() 
  {
		return itemCount;
	}


	public int nextItem() 
  {
		if (!maxItemsReached) 
    {
			itemCount++;
			if (itemCount > maxItems) 
      {
				maxItemsReached = true;
				itemCount--;
			}
		}
		return itemCount;
	}


	public boolean skipItem() 
  {
		return (maxItemsReached || itemCount <= offset || itemCount > (offset + maxPageItems));
	}


	public int pageNumber(int offset) 
  {
		return (offset / maxPageItems) + (offset % maxPageItems == 0 ? 0 : 1);
	}



	public boolean hasPrevPage() 
  {
		return (offset > 0);
	}

	public String getPrevPageUrl() 
  {
		int prevOffset = offset - maxPageItems;
		if (prevOffset < 0)
			prevOffset = 0;

		if (params == null)
			return url+"?"+id+OFFSET_PARAM+"="+prevOffset;
		else
			return url+params+"&"+id+OFFSET_PARAM+"="+prevOffset;
	}

	public Integer getPrevPageNumber() 
  {
		int prevOffset = offset - maxPageItems;
		if (prevOffset < 0)
			prevOffset = 0;
		return new Integer(1+pageNumber(prevOffset));
	}


	public boolean hasNextPage() 
  {
		return (itemCount > (offset + maxPageItems));
	}

	public String getNextPageUrl() 
  {
		if (params == null)
			return url+"?"+id+OFFSET_PARAM+"="+(offset + maxPageItems);
		else
			return url+params+"&"+id+OFFSET_PARAM+"="+(offset + maxPageItems);
	}

	public Integer getNextPageNumber() 
  {
		return new Integer(1+pageNumber(offset + maxPageItems));
	}



	public String getPageUrl(int i) 
  {
		if (params == null)
			return url+"?"+id+OFFSET_PARAM+"="+(maxPageItems * i);
		else
			return url+params+"&"+id+OFFSET_PARAM+"="+(maxPageItems * i);
	}


	public int getPageNumber() 
  {
		return pageNumber;
	}

	public Integer getPageNumber(int i) 
  {
		if (i == pageNumber)
			return pageNumberInteger;
		return new Integer(1+pageNumber(maxPageItems * i));
	}


  public void setTotalItemCount(int value)
  {
    totalItemCount = value;
  }


  public int getTotalItemCount()
  {
    return totalItemCount;
  }

}