package com.strutturaWeb.Action;

import com.ejbSTL.Ent_IntercompanyHome;

import com.strutturaWeb.EjbConnector;
import com.strutturaWeb.Java2JavaScript;

import com.utl.DB_CodiceProgetto;
import com.utl.DB_Intercompany;
import com.utl.Misc;
import com.utl.StoredProcedureResult;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

public class ActionEliminaIntercompany implements ActionInterface
{
  final static Logger logger = Logger.getLogger(ActionEliminaIntercompany.class); 
  
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
    logger.debug("START execution");

    StoredProcedureResult result = new StoredProcedureResult();

    String codeCliente = Misc.nh(request.getParameter("codeCliente"));
      
    Ent_IntercompanyHome home = (Ent_IntercompanyHome)EjbConnector.getHome("Intercompany",Ent_IntercompanyHome.class);

    Vector<StoredProcedureResult> vec = home.create().eliminaIntercompany( codeCliente );
    
    result = vec.lastElement();
    
    if( !result.isOK() )
    {
        logger.debug("ActionEliminaIntercompany() has throw Exception, ErroreSQL: "+result.getErroreSql() +" ErroreMsg: " + result.getErroreMsg());
        // la procedura ha restituito un errore
         throw new Exception(result.getErroreSql() + " " + result.getErroreMsg());
    }
    
    StringBuffer messaggio = new StringBuffer();

    logger.debug( "Success on delete Codice cliente "+codeCliente );
    messaggio.append("Eliminato con successo CODICE CLIENTE: "+codeCliente);    
    logger.debug("END execution");
    return new Java2JavaScript().execute(messaggio);
  }
}
