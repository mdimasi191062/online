package com.filter;
import javax.servlet.ServletResponse;
import javax.servlet.Filter;
import javax.servlet.ServletException;
import javax.servlet.FilterConfig;
import javax.servlet.ServletRequest;
import javax.servlet.FilterChain;
import java.io.IOException;
import javax.servlet.http.*;
import java.io.PrintWriter;
import java.util.Vector;
import com.utl.StaticContext;
import com.utl.clsApplication;
import com.usr.clsInfoUser;
import com.ejbSTL.Security;



public class ChkAutServlet implements Filter 
{
  private FilterConfig filterConfig = null;
  String theActionIndicator=null;

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
    try
    {
      String ServletName=""; 
      String my_param="";
      boolean isModal=false;
      HttpSession session = null; 
      clsInfoUser locClsInfoUser = null;
      Vector locVector = null;
      boolean found=false; 
      HttpServletResponse  resp = (HttpServletResponse)response;
      HttpServletRequest   req = (HttpServletRequest)request;
      session = req.getSession(false); 
      PrintWriter out = resp.getWriter();

      ServletName= StaticContext.getJspName(req);

      if ("true".equals(filterConfig.getInitParameter(ServletName)) )
        isModal=true;
      else
        isModal=false;
      if((session==null)||(session.getAttribute(StaticContext.ATTRIBUTE_USER) == null))
      {
        StaticContext.RedirectPageToLogin (req,out,isModal);
      }
      else
      {
        locClsInfoUser=(clsInfoUser) session.getAttribute(StaticContext.ATTRIBUTE_USER);


        Security remote=locClsInfoUser.getRemoteInterface();
        my_param=remote.chk_param();
        if((my_param!="")&&(my_param!=null))
        {

            if((my_param.equals("ALL"))&&(StaticContext.ADMIN_INDICATOR.equals(locClsInfoUser.getAdminIndicator())))
            {
              //System.out.println("Utente Amministratore: "+locClsInfoUser.getAdminIndicator());
              //System.out.println("servlet trovato parametro: "+my_param.toString());
            }
            else
            {
              //System.out.println("servlet trovato parametro: "+my_param.toString());
              //System.out.println("servlet non passato controllo parametri");
              StaticContext.RedirectPageDisconnect (req,out,isModal,my_param);
              found=true;
            }
        }

        if (!found)
        {
//          Security remote=locClsInfoUser.getRemoteInterface();
      
          locVector=remote.findAllOpEl  (locClsInfoUser.getUserProfile(),StaticContext.getJspName(req));
          if (locVector==null) 
          {
            session.invalidate();
            StaticContext.RedirectPageNoIusses(req,out,isModal);
          }
          else
            chain.doFilter(request, response);
        }
      }
    }
    catch(Exception exception)
    {
        exception.printStackTrace();
        throw new ServletException(exception.toString());
    }
  }
}














