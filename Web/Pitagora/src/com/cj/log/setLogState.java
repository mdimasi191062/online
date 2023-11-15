

package com.cj.log;

import java.util.Hashtable;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

// Referenced classes of package com.cj.log:
//            LogBean, LogConst

public class setLogState extends TagSupport
    implements LogConst
{

    public setLogState()
    {
        state = null;
        id = null;
    }

    public int doStartTag()
        throws JspException
    {
        Hashtable hashtable = (Hashtable)super.pageContext.getAttribute("coldjavalog", 4);
        if(hashtable == null)
            throw new JspException("Could not detect log file. Use setLogFile tag at the first hand");
        LogBean logbean;
        if((logbean = (LogBean)hashtable.get(id)) == null)
            throw new JspException("Could not detect log file for id " + id);
        if("ON".equals(state.toUpperCase()))
            logbean.setOnState(true);
        else
            logbean.setOnState(false);
        return 0;
    }

    public String getId()
    {
        return id;
    }

    public String getState()
    {
        return state;
    }

    public void release()
    {
        state = null;
        id = null;
    }

    public void setId(String s)
    {
        id = s;
    }

    public void setState(String s)
    {
        state = s;
    }

    private String state;
    private String id;
}