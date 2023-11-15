package com.strutturaWeb.Action;

import com.ejbSTL.Ent_IntercompanyHome;

import com.strutturaWeb.EjbConnector;
import com.strutturaWeb.Java2JavaScript;
import com.strutturaWeb.View.ViewGenerica;

import com.utl.Misc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;


public class ActionIntercompany implements ActionInterface
{
  final static Logger logger = Logger.getLogger(ActionIntercompany.class);  
  
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {   
    logger.debug("START execution");
    Ent_IntercompanyHome home = (Ent_IntercompanyHome)EjbConnector.getHome("Intercompany",Ent_IntercompanyHome.class);
    ViewGenerica view2 = null;
    
    view2 = new ViewGenerica(home.create().getIntercompany());
    
    logger.debug("END execution");

    return new Java2JavaScript().execute(view2,new String[]{"codiceCliente","denominazione"},new String[]{"colonna0","colonna1"});
  }
}
