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
public class ActionLstOggFatrzXTipoContr implements ActionInterface
{
  public ActionLstOggFatrzXTipoContr()
  {
  }

  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
      String code_tipo_contr=request.getParameter("codeTipoContr");
      VerStrutTariffeSTLHome home=(VerStrutTariffeSTLHome)EjbConnector.getHome("VerStrutTariffeSTL",VerStrutTariffeSTLHome.class); 
      ViewAccounts view=new ViewAccounts(  home.create().getOggFatrzXTipoContr(code_tipo_contr));
      return new Java2JavaScript().execute(view,new String[]{"desc_ogg_fatrz","code_ogg_fatrz"},new String[]{"text","value"});
      
  }
}