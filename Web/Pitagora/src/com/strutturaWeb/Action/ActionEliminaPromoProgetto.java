package com.strutturaWeb.Action;

import com.ejbSTL.Ent_PromoProgettoHome;

import com.strutturaWeb.EjbConnector;
import com.strutturaWeb.Java2JavaScript;

import com.utl.Misc;
import com.utl.StoredProcedureResult;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

public class ActionEliminaPromoProgetto implements ActionInterface
{
  final static Logger logger = Logger.getLogger(ActionEliminaPromoProgetto.class); 
  
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
    logger.debug("START execution");
    
    StoredProcedureResult result = new StoredProcedureResult();

    String codeAccount =  Misc.nh(request.getParameter("codeAccount"));
    String codeProgetto = Misc.nh(request.getParameter("codeProgetto"));
    String codePromozione = Misc.nh(request.getParameter("codePromozione"));
    
    Ent_PromoProgettoHome home = (Ent_PromoProgettoHome)EjbConnector.getHome("PromoProgetto",Ent_PromoProgettoHome.class);
    
    Vector<StoredProcedureResult> vec = home.create().eliminaPromozioneProgettoNew(codeAccount, codeProgetto, codePromozione);
    
    result = vec.lastElement();
    
    if(! result.isOK())
    {
        logger.debug("ActionEliminaPromoProgetto() has throw Exception, ErroreSQL: "+result.getErroreSql() +" ErroreMsg: " + result.getErroreMsg());
        // la procedura ha restituito un errore
         throw new Exception(result.getErroreSql() + " " + result.getErroreMsg());
    }
    
    StringBuffer messaggio = new StringBuffer();

    logger.debug("Success on delete Codice Progetto "+codeProgetto+" per Account "+codeAccount);
    messaggio.append("Eliminata con successo per CODE ACCOUNT: "+codeAccount+", CODE PROGETTO: "+codeProgetto+" e CODE_PROMOZIONE:"+codePromozione);    
    logger.debug("END execution");
    return new Java2JavaScript().execute(messaggio);
  }
}
