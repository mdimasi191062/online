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
public class ActionLstContrattiXTariffe  implements ActionInterface
{
  public ActionLstContrattiXTariffe()
  {
  }
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
          String code_tipo_contr=request.getParameter("codiceTipoContratto");
          ContrattoSTLHome home=(ContrattoSTLHome)EjbConnector.getHome("ContrattoSTL",ContrattoSTLHome.class);
          Vector vec=home.create().getContrattiXIns(code_tipo_contr);
          ContrattoElem elem=new ContrattoElem();
          elem.setCodeContratto("0");
          elem.setDescContratto("Listino Standard");
          vec.insertElementAt(elem,0);
          
          Vector vec1=home.create().getContrattiXInsCluster(code_tipo_contr);
          vec.addAll(vec1);
          
          ViewContratti view=new ViewContratti(vec);
          return new Java2JavaScript().execute(view,new String[]{"descContratto","codeContratto"},new String[]{"colonna0","colonna1"});
  }
}
