package com.strutturaWeb.Action;

import com.ejbSTL.Ent_PromoAreeHome;
import com.strutturaWeb.EjbConnector;
import com.strutturaWeb.Java2JavaScript;
import com.strutturaWeb.View.ViewGenerica;
import com.utl.Misc;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

public class ActionPromoAree implements ActionInterface
{
  final static Logger logger = Logger.getLogger(ActionPromoAree.class); 
  
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
   String codeAccount =  Misc.nh(request.getParameter("codeAccount"));
   String descArea = Misc.nh(request.getParameter("descArea"));

    logger.debug("START execution");
    Ent_PromoAreeHome home=(Ent_PromoAreeHome)EjbConnector.getHome("PromoAree",Ent_PromoAreeHome.class);
    ViewGenerica view2= null;
    if(codeAccount=="" && descArea ==""){
     view2 = new ViewGenerica(home.create().getAreeRaccoltaAccount(null,null));
   // logger.debug("getListinoOpereSpeciali(), view2= " + view2.getVector().toString());
    }else{
       view2 = new ViewGenerica(home.create().getAreeRaccoltaAccount(codeAccount,descArea));
    }
    logger.debug("END execution");    
//    return new Java2JavaScript().execute(view2,new String[]{"descAccount","descArea","codeAccount","codeArea","idPromoAree"},new String[]{"colonna0","colonna1","colonna2","colonna3","colonna4"});
 return new Java2JavaScript().execute(view2,new String[]{"idPromoAree","descAccount","descArea","codeArea"},new String[]{"colonna0","colonna1","colonna2","colonna3"});

  }
}
