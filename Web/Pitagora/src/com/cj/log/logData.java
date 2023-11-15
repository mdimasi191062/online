

package com.cj.log;

import java.io.FileOutputStream;
import java.util.Hashtable;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.*;

// Referenced classes of package com.cj.log:
//            LogBean, LogConst

public class logData extends BodyTagSupport
    implements LogConst
{

    public logData()
    {
    }

    public int doAfterBody()
        throws JspException
    {
        Hashtable hashtable = (Hashtable)pageContext.getAttribute("coldjavalog", 4);
        if(hashtable == null)
            throw new JspException("Could not detect log file. Use setLogFile tag at the first hand");
        LogBean logbean;
        if((logbean = (LogBean)hashtable.get(id)) == null)
            throw new JspException("Could not detect log file for id " + id);
        if(logbean.getOnState())
        {
            BodyContent bodycontent = getBodyContent();
            synchronized(logbean.getLock())
            {
                saveFile(logbean.getFileName(), bodycontent);
            }
        }
        return 0;
    }

    public int doStartTag()
        throws JspException
    {
        Hashtable hashtable = (Hashtable)pageContext.getAttribute("coldjavalog", 4);
        if(hashtable == null)
            throw new JspException("Could not detect log file. Use setLogFile tag at the first hand");
        LogBean logbean;
        if((logbean = (LogBean)hashtable.get(id)) == null)
            throw new JspException("Could not detect log file for id " + id);
        return !logbean.getOnState() ? 0 : 2;
    }

    public String getId()
    {
        return id;
    }

    public void release()
    {
        id = null;
        super.release();
    }

    private void saveFile(String s, BodyContent bodycontent)
        throws JspException
    {
        try
        {
            FileOutputStream fileoutputstream = new FileOutputStream(s, true);
            if(bodycontent != null)
            {
                byte abyte0[] = (bodycontent.getString().trim() + System.getProperty("line.separator")).getBytes();
                if(abyte0.length > 0)
                    fileoutputstream.write(abyte0, 0, abyte0.length);
            }
            fileoutputstream.close();
        }
        catch(Exception _ex)
        {
            throw new JspException("Could not write to file " + s);
        }
    }

    public void setId(String s)
    {
        id = s;
    }

    public void setPageContext(PageContext pagecontext)
    {
        pageContext = pagecontext;
    }

    private String id;
    private PageContext pageContext;
}