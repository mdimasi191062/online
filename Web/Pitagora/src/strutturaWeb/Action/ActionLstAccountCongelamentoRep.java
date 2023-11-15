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
public class ActionLstAccountCongelamentoRep implements ActionInterface
{
  public ActionLstAccountCongelamentoRep()
  {
  }

  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
      String code_elab=request.getParameter("code_elab");
      AccountElabSTLHome home=(AccountElabSTLHome)EjbConnector.getHome("AccountElabSTL",AccountElabSTLHome.class);
      ViewAccounts view=new ViewAccounts(  home.create().getLstAccXCongRepricing(code_elab));
      return new Java2JavaScript().execute(view,new String[]{"account","codeParam","flagErrore","flagErroreReport"},new String[]{"colonna0","colonna1","colonna2","colonna3"});
   
  }
}
