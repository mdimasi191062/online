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
public class ActionLstAccountXTipoContr implements ActionInterface
{
  public ActionLstAccountXTipoContr()
  {
  }

  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
      String code_tipo_contr=request.getParameter("codeTipoContr");
      ElencoAccountPsSTLHome home=(ElencoAccountPsSTLHome)EjbConnector.getHome("ElencoAccountPsSTL",ElencoAccountPsSTLHome.class); 
      ViewAccounts view=new ViewAccounts(  home.create().getAccCol(code_tipo_contr));
      return new Java2JavaScript().execute(view,new String[]{"desc_account","code_account"},new String[]{"text","value"});
      
  }
}