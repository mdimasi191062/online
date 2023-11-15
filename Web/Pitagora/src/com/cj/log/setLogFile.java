

package com.cj.log;

import java.util.Hashtable;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

// Referenced classes of package com.cj.log:
//            LogBean, LogConst

public class setLogFile extends TagSupport
    implements LogConst
{

    public setLogFile()
    {
        fileName = null;
        id = null;
    }

    public int doStartTag()
        throws JspException
    {
        Hashtable hashtable = getHash();
        if(hashtable.get(fileName) == null)
        {
            LogBean logbean = new LogBean();
            logbean.setFileName(fileName);
            if(hashtable.get(fileName) == null)
                hashtable.put(id, logbean);
        }
        return 0;
    }

    public String getFileName()
    {
        return fileName;
    }

    public Hashtable getHash()
    {
        Hashtable hashtable = (Hashtable)super.pageContext.getAttribute("coldjavalog", 4);
        if(hashtable != null)
        {
            return hashtable;
        } else
        {
            Hashtable hashtable1 = new Hashtable();
            super.pageContext.setAttribute("coldjavalog", hashtable1, 4);
            return hashtable1;
        }
    }

    public String getId()
    {
        return id;
    }

    public void release()
    {
        fileName = null;
        id = null;
    }

    public void setFileName(String s)
    {
        fileName = s;
    }

    public void setId(String s)
    {
        id = s;
    }

    private String fileName;
    private String id;
}