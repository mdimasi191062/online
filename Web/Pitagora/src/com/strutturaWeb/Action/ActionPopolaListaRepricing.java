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
public class ActionPopolaListaRepricing implements ActionInterface
{
  public ActionPopolaListaRepricing()
  {
  }

  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {

      String code_tipo_contr=request.getParameter("codiceTipoContratto");
      ElaborBatchBMPHome home=(ElaborBatchBMPHome)EjbConnector.getHome("ElaborBatchBMP",ElaborBatchBMPHome.class);
      Object vect[]=home.findLstVer("26",code_tipo_contr).toArray();
      Vector vettorePK=new Vector();
      for(int i=0;i<vect.length;i++)
        vettorePK.add(((ElaborBatchBMP)vect[i]).getPrimaryKey());
      ViewElabs view=new ViewElabs(vettorePK);
      return new Java2JavaScript().execute(view,new String[]{"codeElab","dataIni","dataFine","stato"},new String[]{"colonna0","colonna1","colonna2","colonna3"});
  }
}
