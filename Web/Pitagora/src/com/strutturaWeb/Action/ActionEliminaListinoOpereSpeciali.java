package com.strutturaWeb.Action;

import com.ejbSTL.Ent_ListinoOpereSpecialiHome;

import com.strutturaWeb.EjbConnector;

import com.strutturaWeb.Java2JavaScript;

import com.utl.StoredProcedureResult;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

public class ActionEliminaListinoOpereSpeciali implements ActionInterface
{
  final static Logger logger = Logger.getLogger(ActionEliminaListinoOpereSpeciali.class); 
  
  public String esegui(HttpServletRequest request, 
                       HttpServletResponse response) throws Exception
  {
  
    logger.debug("START execution");

    Ent_ListinoOpereSpecialiHome home = (Ent_ListinoOpereSpecialiHome)EjbConnector.getHome("ListinoOpereSpeciali",Ent_ListinoOpereSpecialiHome.class);

    String nomeListino = request.getParameter("listino");
    logger.debug("eliminaListino("+nomeListino+")");
    Vector<StoredProcedureResult> vec = home.create().eliminaListino(nomeListino);
    StringBuffer messaggio = new StringBuffer();
    StoredProcedureResult result = vec.get(0);
    if(!result.isOK())
    {
      logger.debug("eliminaListino() has throw Exception, ErroreSQL: "+result.getErroreSql() +" ErroreMsg: " + result.getErroreMsg());
      throw new Exception(result.getErroreSql() + " " + result.getErroreMsg());
    }
    
      messaggio.append("Listino ").append(nomeListino).append(" eliminato con successo!");
    
    logger.debug("success on eliminaListino()");    
    logger.debug("END execution");

    return new Java2JavaScript().execute(messaggio);
  }
}
