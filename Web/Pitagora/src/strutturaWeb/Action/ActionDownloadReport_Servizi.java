package com.strutturaWeb.Action;
import javax.servlet.http.*;
import java.util.*;
import com.ejbSTL.*;
import com.utl.*;
import com.strutturaWeb.View.*;
import com.strutturaWeb.*;

public class ActionDownloadReport_Servizi implements ActionInterface
{
  public ActionDownloadReport_Servizi()
  {
  }
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
    String codeFunz     = Misc.nh(request.getParameter("codeFunz"));
    String tipoBatch    = Misc.nh(request.getParameter("tipoBatch"));
    String flagSys      = Misc.nh(request.getParameter("flagSys"));
    String codeCiclo    = Misc.nh(request.getParameter("codeCiclo"));
    String queryServizi = Misc.nh(request.getParameter("queryServizi"));
    
          
    Ent_DownloadReportHome home=(Ent_DownloadReportHome)EjbConnector.getHome("Ent_DownloadReport",Ent_DownloadReportHome.class);
    
    /*
     * String strCodeFunz, String strTipoBatch, String strQueryServizi, 
     * String strQueryPeriodi, String strQueryAccount, String strEstensioneFile, 
     * String strEstensioneFileStorici, String strPathReport, String strPathReportStorici, 
     * String strPathFileZip, String strFlagSys, String strCodeServizio, 
     * String strCodeCiclo, String strCodeAccount, String strTipoFile
     * 
     */
    
    Vector vec=home.create().getDataDownload(codeFunz,tipoBatch,queryServizi,
                                             "","","",
                                             "","","",
                                             "",flagSys,"",
                                             codeCiclo,"","");
    
    DB_DownloadReport_Servizi elem=new DB_DownloadReport_Servizi();
    elem.setCODE_TIPO_CONTR("");
    elem.setDESC_TIPO_CONTR("Selezionare Servizio");
    vec.insertElementAt(elem,0);
    ViewGenerica view=new ViewGenerica(vec);
    return new Java2JavaScript().execute(view,new String[]{"DESC_TIPO_CONTR","CODE_TIPO_CONTR"},new String[]{"text","value"});
    
  }
}
