package com.strutturaWeb.Action;

import com.ejbSTL.Ent_PromoProgettoHome;
import com.strutturaWeb.EjbConnector;
import com.strutturaWeb.Java2JavaScript;
import com.strutturaWeb.View.ViewGenerica;
import com.utl.Misc;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

public class ActionPromoProgetto implements ActionInterface
{
  final static Logger logger = Logger.getLogger(ActionPromoProgetto.class);  
  
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
    String codeAccount =  Misc.nh(request.getParameter("codeAccount"));
    String codeProgetto = Misc.nh(request.getParameter("codeProgetto"));
    String codeServizio = Misc.nh(request.getParameter("codeServizio"));
    String codePromozione = Misc.nh(request.getParameter("codePromozione"));
      
    logger.debug("START execution");
    Ent_PromoProgettoHome home = (Ent_PromoProgettoHome)EjbConnector.getHome("PromoProgetto",Ent_PromoProgettoHome.class);
    ViewGenerica view2 = null;
    if(codeAccount == "" && codeProgetto == "" && codeServizio == "" && codePromozione == ""){
/////PASSSSSS
      //view2 = new ViewGenerica(home.create().getCodeProgettoAccount(null,null,null));
       view2 = new ViewGenerica(home.create().getCodeProgettoAccountNew(null,null,null,null));
    }else{
       //view2 = new ViewGenerica(home.create().getCodeProgettoAccount(codeAccount, codeProgetto, codeServizio));
        view2 = new ViewGenerica(home.create().getCodeProgettoAccountNew(codeAccount, codeProgetto, codeServizio, codePromozione));
    }
    logger.debug("END execution");    
    
    return new Java2JavaScript().execute(view2,new String[]{"codeAccount","codeAccountDesc","codeProgetto","codePromozione","dataInizio","dataFine"},new String[]{"colonna0","colonna1","colonna2","colonna3","colonna4","colonna5"});
  }
}
