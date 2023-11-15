package com.strutturaWeb.Action;

import com.ejbSTL.*;

import com.google.gson.*;
import com.google.gson.reflect.*;

import com.strutturaWeb.*;

import com.usr.*;

import com.utl.*;

import java.lang.reflect.Array;

import java.util.*;

import javax.servlet.http.*;

import org.apache.log4j.Logger;


public class ActionInsertListinoOpereSpeciali implements ActionInterface
{
	final static Logger logger = Logger.getLogger(ActionInsertListinoOpereSpeciali.class); 
  
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
    logger.debug("START execution");
    Ent_ListinoOpereSpecialiHome home = (Ent_ListinoOpereSpecialiHome)EjbConnector.getHome("ListinoOpereSpeciali",Ent_ListinoOpereSpecialiHome.class);

    String newListinoDescr = request.getParameter("newListinoDescr");
    String txtDataInizio = request.getParameter("txtDataInizio");
    String tariffe = request.getParameter("tariffe");
    
    logger.debug("newListinoDescr= "+newListinoDescr+ ", txtDataInizio= "+txtDataInizio + ", tariffe= "+tariffe);

    if(home.create().checkListinoExsists(newListinoDescr,"42"))
    {
      logger.debug("checkListinoExsists - Listino esistente");

      throw new Exception("Esiste un listino con la stessa descrizione");
    }
    logger.debug("parse tariffe json to java");

    JsonParser jsonParser = new JsonParser();
    JsonArray jo = (JsonArray)jsonParser.parse(tariffe);                
    Gson googleJson = new Gson();

    clsInfoUser infoUser = (clsInfoUser)request.getSession().getAttribute(StaticContext.ATTRIBUTE_USER);
    StoredProcedureResult result = new StoredProcedureResult();
    List<TariffaOpereSpecialiPar> listTarOSP = new ArrayList<TariffaOpereSpecialiPar>();
    for (int i =0; i<jo.size();i++)
    {             
      TariffaOpereSpecialiPar jsonObj = googleJson.fromJson(jo.get(i), TariffaOpereSpecialiPar.class);
      //colonna0:"idVoce", colonna1:"descEsSP", colonna2:"impTariffa", colonna3:"descTariffa", colonna4:"unitaMisura"
      int idVoce = Integer.valueOf(jsonObj.getColonna0());
      String impTariffa = jsonObj.getColonna2();
      String descTariffa = jsonObj.getColonna3();
      String unitaMisura = jsonObj.getColonna4();
      
      logger.debug("insertTariffa("+infoUser.getUserName()+","+ idVoce+","+ txtDataInizio+","+descTariffa+","+ impTariffa+","+ unitaMisura+","+ newListinoDescr + ")");
          listTarOSP.add(jsonObj);
      }
      Vector<StoredProcedureResult> vec = home.create().insertTariffa(infoUser.getUserName(), txtDataInizio, newListinoDescr,listTarOSP);    
    
      result = vec.lastElement(); 
      if(! result.isOK())
      {
        logger.debug("insertTariffa() has throw Exception, ErroreSQL: "+result.getErroreSql() +" ErroreMsg: " + result.getErroreMsg());
        // la procedura ha restituito un errore
         throw new Exception(result.getErroreSql() + " " + result.getErroreMsg());
      }
    
    StringBuffer messaggio = new StringBuffer();
/*    if(!result.isOK())
    {
          logger.debug("insertTariffa() has throw Exception, ErroreSQL: "+result.getErroreSql() +" ErroreMsg: " + result.getErroreMsg());
          throw new Exception(result.getErroreSql() + " " + result.getErroreMsg());
    }
    else
    {
*/    logger.debug("success on insert Listino :"+newListinoDescr);
      messaggio.append("Listino ").append(newListinoDescr).append(" inserito con successo!");
//    }
  
    logger.debug("END execution");
    return new Java2JavaScript().execute(messaggio);
  }
}

