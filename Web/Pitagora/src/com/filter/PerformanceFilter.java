package com.filter;
import javax.servlet.ServletResponse;
import javax.servlet.Filter;
import javax.servlet.ServletException;
import javax.servlet.FilterConfig;
import javax.servlet.ServletRequest;
import javax.servlet.FilterChain;
import javax.servlet.http.*;
import java.io.IOException;
import com.utl.StaticContext;
import com.utl.StaticMessages;
import java.text.*;
import java.util.*;
import java.util.Hashtable;

public class PerformanceFilter implements Filter 
{
  private FilterConfig filterConfig = null;

  public void init(FilterConfig filterConfig) throws ServletException
  {
    this.filterConfig = filterConfig;
  }

  public void destroy()
  {
    this.filterConfig = null;
  }

  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException
  {

    Hashtable hashtable = null;
		HttpSession sessioneHttp = null;

    String ServletName="";
    String message="";
    SimpleDateFormat FMT =new SimpleDateFormat("kk:mm:ss.SSS");
    HttpServletRequest   req = (HttpServletRequest)request;
    ServletName= StaticContext.getJspName(req);

    sessioneHttp = req.getSession();
    hashtable=(Hashtable)sessioneHttp.getServletContext().getAttribute(StaticContext.ATTRIBUTE_LOG_FILE);

    if (hashtable == null) 
    {
      // scrittura su file master.log      
      StaticContext.writeLog(StaticMessages.getMessage(3008,ServletName));
      chain.doFilter(request, response);
      StaticContext.writeLog(StaticMessages.getMessage(3009,ServletName));
    }
    else 
    {
      // scrittura su file utente .log      
      StaticContext.writeLogUser(StaticMessages.getMessage(3008,ServletName),sessioneHttp,hashtable);
      chain.doFilter(request, response);
      StaticContext.writeLogUser(StaticMessages.getMessage(3009,ServletName),sessioneHttp,hashtable);
//log collector
      StaticContext.writeLogDaily(StaticMessages.getMessage(3006,ServletName),req,hashtable);
//log collector*/
    }

  }
}