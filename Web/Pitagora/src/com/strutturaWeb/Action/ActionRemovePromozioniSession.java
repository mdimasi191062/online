package com.strutturaWeb.Action;

import com.ejbSTL.Ent_CatalogoHome;

import java.util.StringTokenizer;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.*;
import javax.rmi.PortableRemoteObject;
import com.ejbSTL.Ent_Contratti;
import com.ejbSTL.Ent_ContrattiHome;
import com.utl.*;
import com.strutturaWeb.View.*;
import com.strutturaWeb.*;

import java.util.Vector;

public class ActionRemovePromozioniSession implements ActionInterface
{
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
    String user_name=request.getParameter("user_name");
    int ritorno = 0;
    String messaggio = "OK";
    
    HttpSession session = request.getSession();
    
    String sessionObject = "ElencoPromozioni_"+user_name;
    
    try{
      if(session.getAttribute(sessionObject) != null)
        session.removeAttribute(sessionObject);
        
      return new Java2JavaScript().execute(new ViewLancioBatch(messaggio),new String[]{"_messaggio"},new String[]{"messaggio"});
    }catch(Exception e){
      System.out.println(e.getMessage());
      messaggio = "KO sessione";
      return messaggio;
    }
  }
}