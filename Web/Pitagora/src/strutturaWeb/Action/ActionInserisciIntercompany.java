package com.strutturaWeb.Action;

import com.ejbSTL.Ent_IntercompanyHome;

import com.strutturaWeb.EjbConnector;
import com.strutturaWeb.Java2JavaScript;

import com.utl.Misc;
import com.utl.StoredProcedureResult;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;


public class ActionInserisciIntercompany implements ActionInterface{
    final static Logger logger = Logger.getLogger(ActionInserisciIntercompany.class); 
  
    public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
    {
        String strMessaggio = "";
        
        logger.debug("START execution");
        StoredProcedureResult result = new StoredProcedureResult();

        String codeCliente =  Misc.nh(request.getParameter("codeCliente"));
        String denominazione =  Misc.nh(request.getParameter("denominazione"));
        
	Ent_IntercompanyHome home = (Ent_IntercompanyHome)EjbConnector.getHome("Intercompany",Ent_IntercompanyHome.class);
 
        Vector<StoredProcedureResult> vec = null;

        StringBuffer messaggio = new StringBuffer();
        
        vec = home.create().insertIntercompany(codeCliente, denominazione);    
        
        result = vec.lastElement(); 
        
        if( !result.isOK() ){
            logger.debug("insertIntercompany() has throw Exception, ErroreSQL: "+result.getErroreSql() +" ErroreMsg: " + result.getErroreMsg());
            // la procedura ha restituito un errore
            throw new Exception(result.getErroreSql() + " " + result.getErroreMsg());
        }
        
        strMessaggio = "Codice Cliente : "+codeCliente+" inserito con successo ";
        
       
        logger.debug(strMessaggio);
        messaggio.append(strMessaggio);    
        
        logger.debug("END execution");
        
        return new Java2JavaScript().execute(messaggio);
    }
}
