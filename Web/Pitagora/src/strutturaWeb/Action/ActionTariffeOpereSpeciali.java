package com.strutturaWeb.Action;

import com.ejbSTL.Ent_ListinoOpereSpecialiHome;

import com.strutturaWeb.EjbConnector;
import com.strutturaWeb.Java2JavaScript;
import com.strutturaWeb.View.ViewGenerica;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

public class ActionTariffeOpereSpeciali implements ActionInterface
{
  final static Logger logger = Logger.getLogger(ActionTariffeOpereSpeciali.class); 
  public ActionTariffeOpereSpeciali()
  {
  }

  public String esegui(HttpServletRequest request, 
                       HttpServletResponse response) throws Exception
  {
    logger.debug("START execution");
    Ent_ListinoOpereSpecialiHome home=(Ent_ListinoOpereSpecialiHome)EjbConnector.getHome("ListinoOpereSpeciali",Ent_ListinoOpereSpecialiHome.class);

    String listino = request.getParameter("listino");
    String vuota = request.getParameter("vuota");

    logger.debug("getTariffeByListino("+listino+",42,"+vuota+")");
    
    ViewGenerica view2 = new ViewGenerica(home.create().getTariffeByListino(listino, "42",vuota));
    

    String ret = new Java2JavaScript().execute(view2,new String[]{"idVoce", "descEsSP", "impTariffa", "descTariffa", "unitaMisura", "codeTariffa", "codePrTariffa","dataInizioTariffa","dataFineTariffa"},new String[]{"colonna0", "colonna1", "colonna2", "colonna3", "colonna4", "colonna5", "colonna6", "colonna7", "colonna8"});
    
    logger.debug("getTariffeByListino(), view2= "+ ret);

    logger.debug("END execution");
    return ret;

  }
}
