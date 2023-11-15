package com.strutturaWeb.Action;
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
import com.strutturaWeb.*;

public class ActionModificaSftpSched implements ActionInterface
{
  public ActionModificaSftpSched()
  {
  }

   public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
      int ritorno=-1;
      String azione=request.getParameter("azione");
      String idMessag=request.getParameter("idMessag");
      String dataSched=request.getParameter("dataSched");
      ModificaSftpSchedSTLHome home=(ModificaSftpSchedSTLHome)EjbConnector.getHome("ModificaSftpSchedSTL",ModificaSftpSchedSTLHome.class); 
      
      ritorno= home.create().modifica(azione,idMessag,dataSched);
      
      if(ritorno==0)      
        return new Java2JavaScript().execute(new ViewLancioBatch("Modifica effettuato con successo!!"),new String[]{"_messaggio"},new String[]{"messaggio"});
      else
        return new Java2JavaScript().execute(new ViewLancioBatch("Inserimento non effettuato!!"),new String[]{"_messaggio"},new String[]{"messaggio"});

     
      
  }
}