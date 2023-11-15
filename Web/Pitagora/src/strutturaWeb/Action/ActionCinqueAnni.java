package com.strutturaWeb.Action;

import com.ejbSTL.Ent_CinqueAnniHome;
import com.ejbSTL.Ent_PromoAreeHome;

import com.strutturaWeb.EjbConnector;
import com.strutturaWeb.Java2JavaScript;
import com.strutturaWeb.View.ViewGenerica;

import com.utl.Misc;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

public class ActionCinqueAnni implements ActionInterface
{
  final static Logger logger = Logger.getLogger(ActionCinqueAnni.class); 
  
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
   String codeAccount =  request.getParameter("codeAccount");
   String risorsa = request.getParameter("risorsa");
   String  dataDa= Misc.nh(request.getParameter("dataDa"));

    logger.debug("START execution");
    Ent_CinqueAnniHome home=(Ent_CinqueAnniHome)EjbConnector.getHome("CinqueAnni",Ent_CinqueAnniHome.class);
    ViewGenerica view2= null;
     Vector warning= new Vector();
     if(codeAccount!=null || risorsa!=null || dataDa!=""){
        warning= home.create().getWarningValori(codeAccount,dataDa,risorsa);
     
     }
    view2 = new ViewGenerica(warning);
  
    logger.debug("END execution");    
//    return new Java2JavaScript().execute(view2,new String[]{"descAccount","descArea","codeAccount","codeArea","idPromoAree"},new String[]{"colonna0","colonna1","colonna2","colonna3","colonna4"});
//DOR - Begin - Modifica rimozione colonne OGG_FATRZ, IVA, FLAG_FC_IVA e aggiunta colonna FATT_NDC
   //return new Java2JavaScript().execute(view2,new String[]{"STATO","CODE_RIGA","CODE_OGG_FATRZ","DATA_DA","DATA_A","IMPORTO","CODE_ISTANZA","IVA","FLAG_FC_IVA","NR_FATTURA_SD"},new String[]{"colonna0","colonna1","colonna2","colonna3","colonna4","colonna5","colonna6","colonna7","colonna8","colonna9"});
      return new Java2JavaScript().execute(view2,new String[]{"STATO","CODE_RIGA","DATA_DA","DATA_A","IMPORTO","CODE_ISTANZA","DESC_CLASSE_OGG_FATRZ","FATT_NDC","CODE_ACCOUNT"},new String[]{"colonna0","colonna1","colonna2","colonna3","colonna4","colonna5","colonna6","colonna7","colonna8"});
//DOR - End -
  }
}