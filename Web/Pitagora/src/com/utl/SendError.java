package com.utl;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;


public class SendError extends HttpServlet
{
  public void sendErrorRedirect(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response,ServletConfig servletconfig,String errorPageURL, Throwable e) throws javax.servlet.ServletException,IOException
  {
    request.setAttribute("javax.servlet.jsp.jspException",e);
    servletconfig.getServletContext().getRequestDispatcher(errorPageURL).include(request,response);
  }
}

