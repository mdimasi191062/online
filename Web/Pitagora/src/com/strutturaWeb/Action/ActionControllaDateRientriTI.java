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
public class ActionControllaDateRientriTI implements ActionInterface
{
  public ActionControllaDateRientriTI()
  {
  }
   public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
      String i_code_utente=((clsInfoUser)request.getSession().getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName();
   //   String i_flag=request.getParameter("codiceTipoContratto");
      //String i_request=request.getParameter("parametri");
      //String parametri[]=i_request.indexOf(" ");
     // String i_Code_tipo_contr=request.getParameter("codeTipoContr");
      //String i_Code_Account=request.getParameter("codeAccount");
      String i_minCiclo=request.getParameter("minCiclo");
      String i_maxCiclo=request.getParameter("maxCiclo");
      String i_minCess=request.getParameter("minCess");
      String i_maxCess=request.getParameter("maxCess");

    SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy"); 
    try
    {
       Date minCiclo = df.parse(i_minCiclo);
       Date maxCiclo = df.parse(i_maxCiclo);
       if(minCiclo.after(maxCiclo))
       {
         throw new Exception("La data Min ciclo di fatturazione deve essere minore della data Max ciclo di fatturazione!");          
       }       
    }catch (ParseException e)
    {
      throw new Exception("Controllare le date del ciclo di valorizzazione! (dd/mm/yyyy)");
    }

    SimpleDateFormat dfCess = new SimpleDateFormat("dd/MM/yyyy"); 
    try
    {
       Date minCess = dfCess.parse(i_minCess);
       Date maxCess = dfCess.parse(i_maxCess);
       if(minCess.after(maxCess))
       {
         throw new Exception("La Min data di cessazione deve essere minore della Max data di cessazione!");          
       }       
    }catch (ParseException e)
    {
      throw new Exception("Controllare le date di cessazione! (dd/mm/yyyy)");
    }


  return  new ActionFactory().getAction("lancioBatchRepricing").esegui(request,response);

  }
}