package com.strutturaWeb.Action;

import com.ejbSTL.Ent_PromoAreeHome;

import com.strutturaWeb.EjbConnector;
import com.strutturaWeb.Java2JavaScript;

import com.utl.Misc;
import com.utl.StoredProcedureResult;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

public class ActionEliminaPromoArea implements ActionInterface
{
  final static Logger logger = Logger.getLogger(ActionEliminaPromoArea.class); 
  
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
    logger.debug("START execution");
      StoredProcedureResult result = new StoredProcedureResult();

    String codeAccount =  Misc.nh(request.getParameter("codeAccount"));
    String codeArea = Misc.nh(request.getParameter("codeArea"));
    
    Ent_PromoAreeHome home = (Ent_PromoAreeHome)EjbConnector.getHome("PromoAree",Ent_PromoAreeHome.class);
    
    Vector<StoredProcedureResult> vec = home.create().eliminaAreaRaccoltaAccount(codeAccount, codeArea);    
    
    result = vec.lastElement(); 
    if(! result.isOK())
      {
        logger.debug("eliminaAreaRaccoltaAccount() has throw Exception, ErroreSQL: "+result.getErroreSql() +" ErroreMsg: " + result.getErroreMsg());
        // la procedura ha restituito un errore
         throw new Exception(result.getErroreSql() + " " + result.getErroreMsg());
      }
    
    StringBuffer messaggio = new StringBuffer();

    logger.debug("success on delete Area Raccolta "+codeArea+" per Account "+codeAccount);
      messaggio.append("Relazione Area Raccolta Account eliminata con successo per CODE AREA: "+codeArea+" e CODE ACCOUNT: "+codeAccount);    
    logger.debug("END execution");
    return new Java2JavaScript().execute(messaggio);
  }
}
