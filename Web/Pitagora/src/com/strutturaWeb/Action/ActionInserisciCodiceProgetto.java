package com.strutturaWeb.Action;

import com.ejbSTL.Ent_CodiceProgettoHome;

import com.strutturaWeb.EjbConnector;
import com.strutturaWeb.Java2JavaScript;

import com.utl.Misc;
import com.utl.StoredProcedureResult;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;


public class ActionInserisciCodiceProgetto implements ActionInterface{
    final static Logger logger = Logger.getLogger(ActionInserisciCodiceProgetto.class); 
  
    public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
    {
        String strMessaggio = "";
        
        int codeServizioLogicoInt = 0, codeAccountInt = 0, tipologiaInt = 0;
        logger.debug("START execution");
        StoredProcedureResult result = new StoredProcedureResult();

        String codeServizioLogico =  Misc.nh(request.getParameter("codeServizioLogico"));
        String codeAccount =  Misc.nh(request.getParameter("codeAccount"));
        String tipologia = Misc.nh(request.getParameter("tipologia"));
        String codeProgetto = Misc.nh(request.getParameter("codeProgetto"));
        String dataContrattualizzata = Misc.nh(request.getParameter("dataContrattualizzata"));
        String tipologiaString = Misc.nh(request.getParameter("tipologiaStr"));
        String codeServizioLogicoString = Misc.nh(request.getParameter("codeServizioLogicoStr"));
        String codeAccountString = Misc.nh(request.getParameter("codeAccountStr"));
        
        if ( codeServizioLogico.length() > 0 ){
            codeServizioLogicoInt = Integer.parseInt(codeServizioLogico);
        }
        if ( codeAccount.length() > 0 ){
            codeAccountInt = Integer.parseInt(codeAccount);
        }
        if ( tipologia.length() > 0 ){
            tipologiaInt = Integer.parseInt(tipologia);
        }
        
        Ent_CodiceProgettoHome home = (Ent_CodiceProgettoHome)EjbConnector.getHome("CodiceProgetto",Ent_CodiceProgettoHome.class);
        Vector<StoredProcedureResult> vec = null;
        StringBuffer messaggio = new StringBuffer();
        
        vec = home.create().insertCodiceProgetto(codeServizioLogicoInt, codeAccountInt, tipologiaInt, codeProgetto, dataContrattualizzata);    
        
        result = vec.lastElement(); 
        
        if( !result.isOK() ){
            logger.debug("insertCodiceProgetto() has throw Exception, ErroreSQL: "+result.getErroreSql() +" ErroreMsg: " + result.getErroreMsg());
            // la procedura ha restituito un errore
            throw new Exception(result.getErroreSql() + " " + result.getErroreMsg());
        }
        
        strMessaggio = "Codice Progetto : "+codeProgetto.toUpperCase()+" inserito con successo per "+" TIPOLOGIA: "+tipologiaString;
        
        if ( codeServizioLogico.compareTo("-9") != 0 ) {
            strMessaggio += " e SERVIZIO LOGICO: "+codeServizioLogicoString;
        }
        if ( codeAccount.compareTo("-9") != 0 ) {
            strMessaggio += " e CODE ACCOUNT: " +codeAccountString;
        }
        if ( dataContrattualizzata.compareTo("31/12/2099") != 0 ) {
            strMessaggio += " e DATA CONTRATTUALIZZATA: " + dataContrattualizzata;
        }
        
        logger.debug(strMessaggio);
        messaggio.append(strMessaggio);    
        
        //"Account "+codeAccountInt+"  " Data Contrattualizzata "+dataContrattualizzata);
        //messaggio.append("Codice Progetto inserito con successo per CODE SERVIZIO LOGICO : "+codeServizioLogico+" e CODE ACCOUNT: "+codeAccountInt+" CODE PROGETTO: "+codeProgetto.toUpperCase()+" e DATA CONTRATTUALIZZATA: "+dataContrattualizzata);    
        logger.debug("END execution");
        
        return new Java2JavaScript().execute(messaggio);
    }
}
