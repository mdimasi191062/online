package com.strutturaWeb.Action;

import com.ejbSTL.Ent_ListinoOpereSpecialiHome;

import com.strutturaWeb.EjbConnector;

import com.strutturaWeb.Java2JavaScript;
import com.strutturaWeb.View.ViewLancioBatch;

import com.utl.CustomException;

import java.rmi.RemoteException;

import java.util.Enumeration;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

public class ActionUpdateListinoOpereSpeciali implements ActionInterface
{
  final static Logger logger = Logger.getLogger(ActionUpdateListinoOpereSpeciali.class); 
  
  public String esegui(HttpServletRequest request, 
                       HttpServletResponse response) throws Exception
  {
    logger.debug("START execution");    
    
    Ent_ListinoOpereSpecialiHome home=(Ent_ListinoOpereSpecialiHome)EjbConnector.getHome("ListinoOpereSpeciali",Ent_ListinoOpereSpecialiHome.class);
    String nomeListino = request.getParameter("nomeListino");
    String newListinoDescr = request.getParameter("newListinoDescr");
    
    logger.debug("nomeListino= "+nomeListino+ "newListinoDescr= "+newListinoDescr);
    
    Vector<String> descrTariffaV = new Vector<String>();
    for(int i=0; i<10; i++)
    {
      String index = "descr" + i;
      String descrTariffa = request.getParameter(index);
      descrTariffaV.add(descrTariffa);
      
      logger.debug("descrTariffa= "+descrTariffa);

    }
    
    logger.debug("updateListino("+nomeListino+",42,"+newListinoDescr+","+descrTariffaV.toString()+")"); 

    home.create().updateListino(nomeListino, newListinoDescr, descrTariffaV);
    StringBuffer messaggio = new StringBuffer("Listino ").append(newListinoDescr).append(" aggiornato con successo!");
    
    logger.debug("END execution");
    
    return new Java2JavaScript().execute(messaggio);
  }
}
