package com.strutturaWeb.Action;

import com.ejbSTL.Ent_CodiceProgettoHome;

import com.strutturaWeb.EjbConnector;
import com.strutturaWeb.Java2JavaScript;

import com.utl.DB_CodiceProgetto;
import com.utl.Misc;
import com.utl.StoredProcedureResult;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

public class ActionEliminaCodiceProgetto implements ActionInterface
{
  final static Logger logger = Logger.getLogger(ActionEliminaPromoProgetto.class); 
  
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
    logger.debug("START execution");

    StoredProcedureResult result = new StoredProcedureResult();

    String codeProgetto = Misc.nh(request.getParameter("codeProgetto"));
      
    Ent_CodiceProgettoHome home = (Ent_CodiceProgettoHome)EjbConnector.getHome("CodiceProgetto",Ent_CodiceProgettoHome.class);

    Vector<StoredProcedureResult> vec = home.create().eliminaCodiceProgetto( codeProgetto );
    
    result = vec.lastElement();
    
    if( !result.isOK() )
    {
        logger.debug("ActionEliminaCodiceProgetto() has throw Exception, ErroreSQL: "+result.getErroreSql() +" ErroreMsg: " + result.getErroreMsg());
        // la procedura ha restituito un errore
         throw new Exception(result.getErroreSql() + " " + result.getErroreMsg());
    }
    
    StringBuffer messaggio = new StringBuffer();

    logger.debug( "Success on delete Codice Progetto "+codeProgetto );
    messaggio.append("Eliminato con successo CODE PROGETTO: "+codeProgetto);    
    logger.debug("END execution");
    return new Java2JavaScript().execute(messaggio);
  }
}
