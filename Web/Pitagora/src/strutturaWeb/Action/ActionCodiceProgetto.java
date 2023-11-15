package com.strutturaWeb.Action;

import com.ejbSTL.Ent_CodiceProgettoHome;

import com.strutturaWeb.EjbConnector;
import com.strutturaWeb.Java2JavaScript;
import com.strutturaWeb.View.ViewGenerica;

import com.utl.Misc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;


public class ActionCodiceProgetto implements ActionInterface
{
  final static Logger logger = Logger.getLogger(ActionCodiceProgetto.class);  
  
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
    int codeServizioInt = 0;
    int codeAccountInt = 0;
    String codeServizio =  Misc.nh(request.getParameter("codeServizioLogico"));
    String codeProgetto = Misc.nh(request.getParameter("codeProgetto"));
    String codeAccount = Misc.nh(request.getParameter("codeAccount"));
    
    if ( codeServizio.length() > 0 ){
        codeServizioInt = Integer.parseInt(codeServizio);
    }
    if ( codeAccount.length() > 0 ){
        codeAccountInt =  Integer.parseInt(codeAccount);
    }
    
    logger.debug("START execution");
    Ent_CodiceProgettoHome home = (Ent_CodiceProgettoHome)EjbConnector.getHome("CodiceProgetto",Ent_CodiceProgettoHome.class);
    ViewGenerica view2 = null;
    
    if( codeServizio.length() == 0 && codeProgetto.length() == 0 && codeAccountInt == 0 ){
      view2 = new ViewGenerica(home.create().getCodeProgettoTable(0,"",0));
    }else{
       view2 = new ViewGenerica(home.create().getCodeProgettoTable(codeServizioInt, codeProgetto, codeAccountInt));
    }
    
    logger.debug("END execution");
       
    //return new Java2JavaScript().execute(view2,new String[]{"codeAccount","codeAccountDesc","tipologia","codeServizioLogicoDesc","codeProgetto","dataDiRiferimento"},new String[]{"colonna0","colonna1","colonna2","colonna3","colonna4","colonna5"});
    return new Java2JavaScript().execute(view2,new String[]{"codeAccountStr","codeAccountDesc","tipologia","codeServizioLogicoDesc","codeProgetto","dataDiRiferimento"},new String[]{"colonna0","colonna1","colonna2","colonna3","colonna4","colonna5"});
  }
}
