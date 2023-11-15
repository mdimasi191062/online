package com.taglib.pag;

import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.zip.GZIPOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.BodyTagSupport;

public class downloadTag1 extends BodyTagSupport
{

    public downloadTag1()
    {
        compress = false;
        inline = false;
        file = null;
        dir = null;
        contentType = null;
    }

    public void setCompress(boolean flag)
    {
        compress = flag;
    }

    public void setCompress(String s)
    {
        if("true".equals(s))
            compress = true;
        else
            compress = false;
    }

    public boolean getCompress()
    {
        return compress;
    }

    public void setInline(boolean flag)
    {
        inline = flag;
    }

    public void setInline(String s)
    {
        if("true".equals(s))
            inline = true;
        else
            inline = false;
    }

    public boolean getInline()
    {
        return inline;
    }

    public void setFile(String s)
    {
        file = s;
    }

    public String getFile()
    {
        return file;
    }

    public void setDir(String s)
    {
        dir = s;
    }

    public String getDir()
    {
        return dir;
    }

    public void setContentType(String s)
    {
        contentType = s;
    }

    public String getContentType()
    {
        return contentType;
    }

    public int doEndTag()
        throws JspException
    {
        HttpServletRequest httpservletrequest = (HttpServletRequest)pageContext.getRequest();
        HttpServletResponse httpservletresponse = (HttpServletResponse)pageContext.getResponse();
        String s;
        if(dir == null)
        {
            s = "";
        } else
        {
            s = dir;
            String s1 = System.getProperty("file.separator");
            if(!s.endsWith(s1) && !s.endsWith("/") && !file.startsWith(s1) && !file.startsWith("/"))
                s = s + s1;
            else
            if((s.endsWith(s1) || s.endsWith("/")) && (file.startsWith(s1) || file.startsWith(s1)))
                s = s.substring(0, s.length() - 1);
        }
        s = s + file;
        if(!compress)
            sendFile(s, httpservletresponse);
        else
        if(httpservletrequest.getHeader("Accept-Encoding").indexOf("gzip") < 0)
            sendFile(s, httpservletresponse);
        else
            sendCompressed(s, httpservletresponse);
        return 6;
    }

    private void sendCompressed(String s, HttpServletResponse httpservletresponse)
        throws JspException
    {
        String s1 = System.getProperty("file.separator");
        try
        {
            pageContext.getOut().clearBuffer();
        }
        catch(Exception exception) { }
        int i = s.lastIndexOf(s1);
        if(i < 0 && s1.equals("\\"))
            i = s.lastIndexOf("/");
        String s2;
        if(i > 0 && i != s.length() - 1)
            s2 = s.substring(i + 1);
        else
            s2 = s;
        httpservletresponse.setContentType(getContentType(s2) + "; name=" + s2 + "");
        httpservletresponse.setHeader("Content-Encoding", "gzip");
        if(!inline)
            httpservletresponse.setHeader("Content-Disposition", "attachment;filename=\"" + s2 + "\"");
        else
            httpservletresponse.setHeader("Content-Disposition", "inline;filename=\"" + s2 + "\"");
        javax.servlet.ServletOutputStream servletoutputstream;
        GZIPOutputStream gzipoutputstream;
        try
        {
            servletoutputstream = httpservletresponse.getOutputStream();
            gzipoutputstream = new GZIPOutputStream(servletoutputstream);
        }
        catch(Exception exception1)
        {
            throw new JspException("Could not get OutputStream");
        }
        if(!dumpFile(s, gzipoutputstream))
            throw new JspException("Could not download file");
        try
        {
            gzipoutputstream.close();
            servletoutputstream.flush();
            servletoutputstream.close();
        }
        catch(Exception exception2) { }
    }

    private void sendFile(String s, HttpServletResponse httpservletresponse)
        throws JspException
    {
        String s1 = System.getProperty("file.separator");
        try
        {
            pageContext.getOut().clearBuffer();
        }
        catch(Exception exception) { }
        int i = s.lastIndexOf(s1);
        if(i < 0 && s1.equals("\\"))
            i = s.lastIndexOf("/");
        String s2;
        if(i > 0 && i != s.length() - 1)
            s2 = s.substring(i + 1);
        else
            s2 = s;
        httpservletresponse.setContentType(getContentType(s2) + "; name=" + s2 + "");
        if(!inline)
            httpservletresponse.setHeader("Content-Disposition", "attachment;filename=\"" + s2 + "\"");
        else
            httpservletresponse.setHeader("Content-Disposition", "inline;filename=\"" + s2 + "\"");
        javax.servlet.ServletOutputStream servletoutputstream;
        try
        {
            servletoutputstream = httpservletresponse.getOutputStream();
        }
        catch(Exception exception1)
        {
            throw new JspException("Could not get OutputStream");
        }
        if(!dumpFile(s, servletoutputstream))
            throw new JspException("Could not download file: "+s);
        try
        {
            servletoutputstream.flush();
            servletoutputstream.close();
        }
        catch(Exception exception2) { }
    }

    private boolean dumpFile(String s, OutputStream outputstream)
    {
        byte abyte0[] = new byte[4096];
        boolean flag = true;
        try
        {
            FileInputStream fileinputstream = new FileInputStream(s);
            int i;
            while((i = fileinputstream.read(abyte0)) != -1)
                outputstream.write(abyte0, 0, i);
            fileinputstream.close();
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
            flag = false;
        }
        return flag;
    }

    private String getContentType(String s)
    {
        if(contentType != null)
            return contentType;
        else
            return "application/octet-stream";
    }

    public void setPageContext(PageContext pagecontext)
    {
        pageContext = pagecontext;
    }

    public void release()
    {
        compress = false;
        inline = false;
        file = null;
        dir = null;
        contentType = null;
    }

    PageContext pageContext;
    private static final int BUFFER_SIZE = 4096;
    private boolean compress;
    private boolean inline;
    private String file;
    private String dir;
    private String contentType;
}