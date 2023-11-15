package com.strutturaWeb.Action;

import com.ejbSTL.Ent_CinqueAnniHome;
import com.ejbSTL.Ent_PromoAreeHome;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import com.strutturaWeb.EjbConnector;
import com.strutturaWeb.Java2JavaScript;

import com.utl.Misc;
import com.utl.StoredProcedureResult;

import java.util.Iterator;
import java.util.Map;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

public class ActionCinqueAnni_Update implements ActionInterface{
    public ActionCinqueAnni_Update() {
    }

     final static Logger logger = Logger.getLogger(ActionCinqueAnni_Update.class); 
    
     public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
     {
       logger.debug("START execution");      
       
       StoredProcedureResult result = new StoredProcedureResult();
       Ent_CinqueAnniHome home = (Ent_CinqueAnniHome)EjbConnector.getHome("CinqueAnni",Ent_CinqueAnniHome.class);

       String changeStatusMap =  Misc.nh(request.getParameter("changeStatusMap"));
       Vector<StoredProcedureResult> vec;
       if(changeStatusMap!=""){          
           JsonParser jsonParser = new JsonParser();
           JsonObject jo = (JsonObject)jsonParser.parse(changeStatusMap);   
           if(jo.entrySet().size()>0){
            for (Map.Entry<String,JsonElement> entry : jo.entrySet()) {
                String codiceRiga = entry.getKey();
                int stato=entry.getValue().getAsInt();                
                vec = home.create().updateCinqueAnni(codiceRiga, stato);    
                result = vec.lastElement();
                if(! result.isOK())
                {
                       logger.debug("eliminaAreaRaccoltaAccount() has throw Exception, ErroreSQL: "+result.getErroreSql() +" ErroreMsg: " + result.getErroreMsg());
                       // la procedura ha restituito un errore
                        throw new Exception(result.getErroreSql() + " " + result.getErroreMsg());
                }
            }          
            
           }
        } 
        StringBuffer messaggio = new StringBuffer();

        logger.debug("success on update records");
        messaggio.append("Modifica avvenuta con successo");    
        logger.debug("END execution");
        return new Java2JavaScript().execute(messaggio);          
     }
}
