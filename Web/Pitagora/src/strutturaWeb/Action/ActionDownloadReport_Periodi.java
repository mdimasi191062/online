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
public class ActionDownloadReport_Periodi implements ActionInterface
{
  public ActionDownloadReport_Periodi()
  {
  }
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
    String codeFunz     = Misc.nh(request.getParameter("codeFunz"));
    String tipoBatch    = Misc.nh(request.getParameter("tipoBatch"));
    String flagSys      = Misc.nh(request.getParameter("flagSys"));
    String queryPeriodi = Misc.nh(request.getParameter("queryPeriodi"));
    
    
     
    Ent_DownloadReportHome home=(Ent_DownloadReportHome)EjbConnector.getHome("Ent_DownloadReport",Ent_DownloadReportHome.class);
    
    /*
     * String strCodeFunz, String strTipoBatch, String strQueryServizi, 
     * String strQueryPeriodi, String strQueryAccount, String strEstensioneFile, 
     * String strEstensioneFileStorici, String strPathReport, String strPathReportStorici, 
     * String strPathFileZip, String strFlagSys, String strCodeServizio, 
     * String strCodeCiclo, String strCodeAccount, String strTipoFile
     * 
     */
    Vector vec=home.create().getDataDownload(codeFunz,tipoBatch,"",
                                             queryPeriodi,"","",
                                             "","","",
                                             "",flagSys,"",
                                             "","","");
    
    
    DB_DownloadReport_Periodi elem=new DB_DownloadReport_Periodi();
    elem.setCODE_CICLO("0");
    elem.setDESCRIZIONE_CICLO("Selezionare Ciclo");
    vec.insertElementAt(elem,0);
    ViewGenerica view=new ViewGenerica(vec);
    return new Java2JavaScript().execute(view,new String[]{"DESCRIZIONE_CICLO","CODE_CICLO"},new String[]{"text","value"});
  }
}
