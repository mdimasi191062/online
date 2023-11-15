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
import com.usr.clsInfoUser;
public class ActionControllaDateRicaviAC implements ActionInterface
{
  public ActionControllaDateRicaviAC()
  {
  }
   public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
      String i_code_utente=((clsInfoUser)request.getSession().getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName();
      String i_minCiclo=request.getParameter("minCiclo");
      String i_maxCiclo=request.getParameter("maxCiclo");

      String meseminCiclo=i_minCiclo.substring(3,5);
      String annominCiclo=i_minCiclo.substring(6,10);
      String mesemaxCiclo=i_maxCiclo.substring(3,5);
      String annomaxCiclo=i_maxCiclo.substring(6,10);
  

      if(new Integer(annominCiclo).intValue()>new Integer(annomaxCiclo).intValue())
          throw new Exception("La Data Inizio Ciclo di Fatturazione deve essere minore della Data Fine Ciclo di Fatturazione!");
      else if(new Integer(annominCiclo).intValue()==new Integer(annomaxCiclo).intValue()){
                 if(new Integer(meseminCiclo).intValue()>new Integer(mesemaxCiclo).intValue())
                      throw new Exception("La Data Inizio Ciclo di Fatturazione deve essere minore della Data Fine Ciclo di Fatturazione!");
              }

  return  new ActionFactory().getAction("lancioBatchRepricing").esegui(request,response);

  }
}