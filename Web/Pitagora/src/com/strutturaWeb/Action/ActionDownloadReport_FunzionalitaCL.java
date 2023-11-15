package com.strutturaWeb.Action;
import javax.servlet.http.*;
import java.util.*;
import com.ejbSTL.*;
import com.utl.*;
import com.strutturaWeb.View.*;
import com.strutturaWeb.*;

public class ActionDownloadReport_FunzionalitaCL implements ActionInterface
{
  public ActionDownloadReport_FunzionalitaCL()
  {
  }
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
  
    /* istanzio l'ejb dove fare le select - inizio */
    Ent_DownloadReportHome home=(Ent_DownloadReportHome)EjbConnector.getHome("Ent_DownloadReport",Ent_DownloadReportHome.class);
    Vector vec=home.create().getLstFunzionalitaCL();
    /* istanzio l'ejb dove fare le select - fine */
    
    DB_DownloadReport_Funzionalita elem=new DB_DownloadReport_Funzionalita();
    elem.setCODE_FUNZ("");
    elem.setDESC_FUNZ("Selezionare Funzionalita'");
    vec.insertElementAt(elem,0);
    ViewGenerica view=new ViewGenerica(vec);
    return new Java2JavaScript().execute(view,new String[]{"DESC_FUNZ","CODE_FUNZ","TIPO_FUNZ","QUERY_SERVIZI",
                                                           "QUERY_PERIODI","QUERY_ACCOUNT",
                                                           "ESTENSIONE_FILE","ESTENSIONE_FILE_STORICO",
                                                           "PATH_REPORT","PATH_REPORT_STORICI",
                                                           "PATH_FILE_ZIP","FLAG_SYS"
                                                           },
                                              new String[]{"text","value","tipo_funz","query_servizi",
                                                           "query_periodi","query_account",
                                                           "estensione_file","estensione_file_storico",
                                                           "path_report","path_report_storici",
                                                           "path_file_zip","flag_sys"
                                                          }
                                        );
//    return new Java2JavaScript().execute(view,new String[]{"DESC_FUNZ","CODE_FUNZ"},new String[]{"text","value"});
  }
}
