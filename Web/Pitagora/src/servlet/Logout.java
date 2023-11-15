package com.servlet;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import com.utl.StaticContext;
import com.utl.StaticMessages;
import java.util.Hashtable;

public class Logout extends HttpServlet 
{
  private static final String CONTENT_TYPE = "text/html; charset=windows-1252";

  public void init(ServletConfig config) throws ServletException
  {
    super.init(config);
  }

  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
  {
    HttpSession session = null; 
    Hashtable hstUtente = null;
    
    session = request.getSession(false); 
    if (session!=null) {

      // lp 20040511 : se la sessione � valorizzata provvede a scrivere 
      //               il msg di logout sul log-utente.
      hstUtente = (Hashtable)session.getServletContext().getAttribute(StaticContext.ATTRIBUTE_LOG_FILE);
      StaticContext.writeLogUser(StaticMessages.getMessage(3002,""),session,hstUtente);
        //log collector
        HttpSession sessioneHttp = null;
        Hashtable hashtable = null;
        HttpServletRequest   req = (HttpServletRequest)request;
        sessioneHttp = req.getSession();
        hashtable=(Hashtable)sessioneHttp.getServletContext().getAttribute(StaticContext.ATTRIBUTE_LOG_FILE);
        StaticContext.writeLogDaily(StaticMessages.getMessage(3002,"Controller.java"),req,hashtable);
        //log collector*/
      session.invalidate();
    }
    
    response.sendRedirect(response.encodeRedirectURL(StaticContext.LOGIN_MAIN_PAGE));
  }
}