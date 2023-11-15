package com.strutturaWeb;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.naming.*;
import javax.rmi.*;
import java.io.*;
import java.util.*;
import com.ejbBMP.*;
import com.ejbSTL.*;
import java.text.*;
import com.utl.*;
import com.strutturaWeb.View.*;
import com.strutturaWeb.Action.*;
public class ServletStrutturaSpecial extends HttpServlet 
{
  public ServletStrutturaSpecial()
  {
  }

  
	public void init() throws ServletException
	{
         
  }

  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
  {
    doPost(request,response);
  }

//************
  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
  {
    String azione=request.getParameter("action");
    PrintWriter pw=response.getWriter();
    ActionInterface af=new ActionFactory().getAction(azione);
    String javascript=null;
    try
    {
      
      javascript= af.esegui(request,response);
      
      if (javascript.equalsIgnoreCase("var dati = new Array({messaggio:'ELEMENTI MANUALI'});")){
        String tempJavascript="var richiesta = window.confirm(\"Per gli account selezionati esistono Fatture o Note di credito manuali.\\n";
        String parametri=request.getAttribute("LISTA_FILES").toString(); 
        String[] listaFiles=parametri.split("\\$");
        
        for(int i =0; i<listaFiles.length;i++)
        {
          tempJavascript+=listaFiles[i]+"\\n";
        }
        tempJavascript+="Procedere comunque?\");if(richiesta){BATCHMANUALE(); }";
        //javascript="var richiesta = window.confirm(\"Per gli account selezionati esistono Fatture o Note di credito manuali. Procedere comunque?\");if(richiesta){BATCHMANUALE(); }";
        javascript=tempJavascript;
      }
    //  var dati = new Array(window.confirm("test"));
    }
    catch(Exception e)
    {
      ViewErrore view=new ViewErrore(e.getMessage());
      try
      {
        javascript=new Java2JavaScript().execute(view,new String[]{"_messaggio"},new String[]{"messaggio"});
      }
      catch(Exception e1)
      {
        System.out.println("ServletStrutturaSpecial - "+e1.getMessage());
      }
    }
    finally
    {
      response.setContentType("text/plain");
      response.setHeader("Cache-Control", "no-cache");
      pw.print(javascript);
    
    }
  }

    
     
    


   
  


	



}