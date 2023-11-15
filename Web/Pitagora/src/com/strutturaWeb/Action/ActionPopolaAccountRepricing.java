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
public class ActionPopolaAccountRepricing implements ActionInterface
{
  public ActionPopolaAccountRepricing()
  {
  }

  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
      String code_tipo_contr=request.getParameter("codiceTipoContratto");
      AccountElabSTLHome home=(AccountElabSTLHome)EjbConnector.getHome("AccountElabSTL",AccountElabSTLHome.class);
      AccountElabSTL acc=home.create();
      boolean isOk=acc.controllaAccountRepricing(code_tipo_contr);
      if(isOk)
      {
        ViewAccounts view=new ViewAccounts(  home.create().getLstAccRepricingSpecial(code_tipo_contr));
        return new Java2JavaScript().execute(view,new String[]{"account","codeParam"},new String[]{"text","value"});
      }
      else
      {
        throw new Exception("Impossibile lanciare il repricing per questo Tipo Contratto! Ci sono testate non congelate!");
      }
  }
}