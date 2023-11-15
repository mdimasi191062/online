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
public class Action_J2_CheckGestoreSap implements ActionInterface
{
  public Action_J2_CheckGestoreSap()
  {
  }
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
    String code_gestore=request.getParameter("code_gestore");
    String code_gestore_sap=request.getParameter("code_gestore_sap");
          
    int ritorno = 0;
    String messaggio = "";

    Ent_CatalogoHome home=(Ent_CatalogoHome)EjbConnector.getHome("Ent_Catalogo",Ent_CatalogoHome.class);
    ritorno = home.create().checkGestoreSap(code_gestore,code_gestore_sap);
         
    if (ritorno == 0)
      messaggio = "OK";
    else
      messaggio = "KO";
          
    return new Java2JavaScript().execute(new ViewLancioBatch(messaggio),new String[]{"_messaggio"},new String[]{"messaggio"});
  }
}
