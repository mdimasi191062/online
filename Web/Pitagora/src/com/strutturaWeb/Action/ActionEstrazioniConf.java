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

public class ActionEstrazioniConf implements ActionInterface
{
  public ActionEstrazioniConf()
  {
  } 

 public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
      EstrazioniConfSTLHome home=(EstrazioniConfSTLHome)EjbConnector.getHome("EstrazioniConf",EstrazioniConfSTLHome.class);
      String funzCruscotto = request.getParameter("funzioneCruscotto");
      ViewGenerica view= null;
      if ( !"".equals(funzCruscotto) && funzCruscotto != null )
      {
        view = new ViewGenerica(home.create().getEstrazioniCruscottoConf());
      }else
      {
        view=new ViewGenerica(home.create().getEstrazioniConf());
      }

      return new Java2JavaScript().execute(view,new String[]{"nome_estrazione","nome_file","path_download"},new String[]{"text","value","path"});

  }
}