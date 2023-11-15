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
public class Action_J2_CheckAccordixOfferta implements ActionInterface
{
  public Action_J2_CheckAccordixOfferta()
  {
  }
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
    String code_offerta             = request.getParameter("code_offerta");
            
    int ritorno = 0;
    String messaggio = "";
    try
    {
      Ent_AccordoHome home=(Ent_AccordoHome)EjbConnector.getHome("Ent_Accordo",Ent_AccordoHome.class);
      ritorno = home.create().CheckAccordixOfferta(code_offerta);
         
      if (ritorno == 0)
        messaggio = "KO";
      else
        messaggio = "OK";
    }catch(Exception e){
      System.out.println("Action_J2_CheckAccordixOfferta Exception");
      System.out.println(e.getMessage().toString());
    }
          
    return new Java2JavaScript().execute(new ViewLancioBatch(messaggio),new String[]{"_messaggio"},new String[]{"messaggio"});
  }
}
