package com.strutturaWeb.Action;

//import com.ejbSTL.Ent_ListinoOpereSpecialiHome;

import com.ejbSTL.Ent_PromoProgetto;

import com.ejbSTL.Ent_PromoProgettoHome;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonParser;

import com.strutturaWeb.EjbConnector;
import com.strutturaWeb.Java2JavaScript;

import com.usr.clsInfoUser;

import com.utl.Misc;
import com.utl.StaticContext;
import com.utl.StoredProcedureResult;
import com.utl.TariffaOpereSpecialiPar;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

public class ActionInserisciPromoProgetto implements ActionInterface{
    final static Logger logger = Logger.getLogger(ActionInserisciPromoProgetto.class); 
  
    public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
    {
        logger.debug("START execution");
        StoredProcedureResult result = new StoredProcedureResult();
        
        String codeAccount =  Misc.nh(request.getParameter("codeAccount"));
        String codeProgetto = Misc.nh(request.getParameter("codeProgetto"));
           
        Ent_PromoProgettoHome home = (Ent_PromoProgettoHome)EjbConnector.getHome("PromoProgetto",Ent_PromoProgettoHome.class);
        Vector<StoredProcedureResult> vec = null;
        StringBuffer messaggio = new StringBuffer();
        
        ////PASSSSS  
        //vec = home.create().insertPromozioneProgetto(codeAccount, codeProgetto);    
        String codePromozione = Misc.nh(request.getParameter("codePromozione"));
        String dataIni = Misc.nh(request.getParameter("dataIni"));
        String dataFin = Misc.nh(request.getParameter("dataFin"));
        
        vec = home.create().insertPromozioneProgettoNew(codeAccount, codeProgetto, codePromozione, dataIni, dataFin); 
        
        result = vec.lastElement(); 
        
        if( !result.isOK() ){
            logger.debug("insertPromozioneProgetto() has throw Exception, ErroreSQL: "+result.getErroreSql() +" ErroreMsg: " + result.getErroreMsg());
            // la procedura ha restituito un errore
            throw new Exception(result.getErroreSql() + " " + result.getErroreMsg());
        }
        logger.debug("Success on insert Code Account "+codeAccount+" Code Progetto "+codeProgetto.toUpperCase());
        messaggio.append("Promozione Progetto inserita con successo per CODE ACCOUNT: "+codeAccount+" e CODE PROGETTO: "+codeProgetto.toUpperCase());    
        logger.debug("END execution");
        
        return new Java2JavaScript().execute(messaggio);
    }
}
