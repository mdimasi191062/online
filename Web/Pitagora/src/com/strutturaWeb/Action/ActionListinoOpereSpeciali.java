package com.strutturaWeb.Action;

import com.ejbSTL.Ent_ListinoOpereSpecialiHome;
import com.ejbSTL.Ent_TipiContrattoHome;

import com.strutturaWeb.EjbConnector;
import com.strutturaWeb.Java2JavaScript;
import com.strutturaWeb.View.ViewGenerica;

import com.strutturaWeb.View.ViewPs;

import com.strutturaWeb.View.ViewTabella;

import com.utl.DB_ListinoOpereSpeciali;
import com.utl.DB_TipiContratto;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

public class ActionListinoOpereSpeciali implements ActionInterface
{
  final static Logger logger = Logger.getLogger(ActionListinoOpereSpeciali.class); 
  
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
    logger.debug("START execution");
    Ent_ListinoOpereSpecialiHome home=(Ent_ListinoOpereSpecialiHome)EjbConnector.getHome("ListinoOpereSpeciali",Ent_ListinoOpereSpecialiHome.class);
    //ViewTabella view= new ViewTabella(home.create().getListinoOpereSpeciali("42"));
   
    //return new Java2JavaScript().executeTable(view,new String[]{"descListinoApplicato"},new String[]{"colonna0"});
   
    ViewGenerica view2 = new ViewGenerica(home.create().getListinoOpereSpeciali("42"));

    logger.debug("getListinoOpereSpeciali(), view2= " + view2.getVector().toString());
    
    logger.debug("END execution");
    
    return new Java2JavaScript().execute(view2,new String[]{"descListinoApplicato"},new String[]{"colonna0"});
  }

}
