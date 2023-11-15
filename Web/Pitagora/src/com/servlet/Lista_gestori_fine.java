package com.servlet;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import com.utl.StaticContext;

public class Lista_gestori_fine extends HttpServlet 
{
  private static final String CONTENT_TYPE = "text/html; charset=windows-1252";

  public void init(ServletConfig config) throws ServletException
  {
    super.init(config);
  }

  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
  {
    response.setContentType(CONTENT_TYPE);

    ServletConfig config = getServletConfig();
    ServletContext application = config.getServletContext();
    application.removeAttribute(StaticContext.ACTION_INDICATOR);
    
    PrintWriter out = response.getWriter();
    out.println("<html>");
    out.println("<head><title>Lista_gestori_fine</title></head>");
    out.println("<body>");
    out.println("<p>Rimosso parametro ACTION_INDICATOR</p>");
    out.println("</body></html>");
    out.close();
  }
}