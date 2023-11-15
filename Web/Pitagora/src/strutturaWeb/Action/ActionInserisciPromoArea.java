package com.strutturaWeb.Action;

import com.ejbSTL.Ent_ListinoOpereSpecialiHome;

import com.ejbSTL.Ent_PromoAree;

import com.ejbSTL.Ent_PromoAreeHome;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonParser;

import com.strutturaWeb.EjbConnector;
import com.strutturaWeb.Java2JavaScript;

import com.usr.clsInfoUser;

import com.utl.Misc;
import com.utl.StaticContext;
import com.utl.StoredProcedureResult;
import com.utl.TariffaOpereSpecialiPar;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

public class ActionInserisciPromoArea implements ActionInterface
{
  final static Logger logger = Logger.getLogger(ActionInserisciPromoArea.class); 
  
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
    logger.debug("START execution");
    StoredProcedureResult result = new StoredProcedureResult();

     String codeAccount =  Misc.nh(request.getParameter("codeAccount"));
     String codeArea = Misc.nh(request.getParameter("codeArea"));
     boolean checkAllAree = Boolean.parseBoolean(Misc.nh(request.getParameter("checkAllAree")));
       
      Ent_PromoAreeHome home = (Ent_PromoAreeHome)EjbConnector.getHome("PromoAree",Ent_PromoAreeHome.class);
      Vector<StoredProcedureResult> vec= null;
      StringBuffer messaggio = new StringBuffer();

    if(!checkAllAree){
            vec = home.create().insertAreaRaccoltaAccount(codeAccount, codeArea);    
   }
   else{
      vec = home.create().insertAllAreaRaccoltaAccount(codeAccount);    
       
   }
     result = vec.lastElement(); 
     if(! result.isOK())
       {
         logger.debug("insertAreaRaccoltaAccount() has throw Exception, ErroreSQL: "+result.getErroreSql() +" ErroreMsg: " + result.getErroreMsg());
         // la procedura ha restituito un errore
          throw new Exception(result.getErroreSql() + " " + result.getErroreMsg());
       }
      if(!checkAllAree){            
            logger.debug("success on insert Area Raccolta "+codeArea+" per Account "+codeAccount);
            messaggio.append("Relazione Area Raccolta Account inserita con successo per CODE AREA: "+codeArea+" e CODE ACCOUNT: "+codeAccount);    
            logger.debug("END execution");
      }else{      
          logger.debug("success on insert all Area Raccolta ");
          messaggio.append("Inserimento di tutte le Aree Raccolta avvenuto con successo per CODE ACCOUNT: "+codeAccount);    
          logger.debug("END execution");
      }       
      return new Java2JavaScript().execute(messaggio);
  }
}
