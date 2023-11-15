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
public class Action_J2_CheckCodeAccordo implements ActionInterface
{
  public Action_J2_CheckCodeAccordo()
  {
  }
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
    String code_accordo             = request.getParameter("pstrCodeAccordo");
   
          
    int ritorno = 0;
    String messaggio = "";
    try
    {
      Ent_AccordoHome home=(Ent_AccordoHome)EjbConnector.getHome("Ent_Accordo",Ent_AccordoHome.class);
      Vector vctritorno = home.create().getAccordo(code_accordo);
       
      if (vctritorno.size() == 0) messaggio = "OK";
         

    
    }catch(Exception e){
      System.out.println("Action_J2_CheckCodeAccordo Exception");
      System.out.println(e.getMessage().toString());
    }
          
    return new Java2JavaScript().execute(new ViewLancioBatch(messaggio),new String[]{"_messaggio"},new String[]{"messaggio"});
  }
}
