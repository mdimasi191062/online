package com.strutturaWeb.Action;

import javax.servlet.http.*;
import com.ejbSTL.*;
import com.strutturaWeb.View.*;
import com.strutturaWeb.*;

public class ActionLstCausaliXTipoContr implements ActionInterface
{
  public ActionLstCausaliXTipoContr()
  {
  }

  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
    String code_tipo_contr=request.getParameter("codeTipoContr");
    String code_ogg_fatrz=request.getParameter("codeOggFatrz");
    VerStrutTariffeSTLHome home=(VerStrutTariffeSTLHome)EjbConnector.getHome("VerStrutTariffeSTL",VerStrutTariffeSTLHome.class); 
    ViewAccounts view=new ViewAccounts(  home.create().getCausaliXTipoContr(code_tipo_contr,code_ogg_fatrz));
    return new Java2JavaScript().execute(view,new String[]{"desc_tipo_caus_fatt","code_tipo_caus_fatt"},new String[]{"text","value"});
  }
}