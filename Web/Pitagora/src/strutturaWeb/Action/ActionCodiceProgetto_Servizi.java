package com.strutturaWeb.Action;

import com.ejbSTL.Ent_CodiceProgettoHome;

import com.strutturaWeb.EjbConnector;
import com.strutturaWeb.Java2JavaScript;
import com.strutturaWeb.View.ViewGenerica;

import com.utl.DB_Servizio;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class ActionCodiceProgetto_Servizi implements ActionInterface
    {
    public ActionCodiceProgetto_Servizi() {
    }
    public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
      {
        Ent_CodiceProgettoHome home=(Ent_CodiceProgettoHome)EjbConnector.getHome("CodiceProgetto",Ent_CodiceProgettoHome.class);
        
        Vector vec = home.create().getServiziLogici();
        
        //DB_Servizio elem = new DB_Servizio();
        DB_Servizio elem2 = new DB_Servizio();
        
        //elem.setCODE_SERVIZIO("");
        //elem.setDESC_SERVIZIO("Selezionare Servizio");
        
        //vec.insertElementAt(elem,0);

        elem2.setCODE_SERVIZIO("-9");
        elem2.setDESC_SERVIZIO("Nessun Servizio Logico");
        
          //vec.insertElementAt(elem2,1);
          vec.insertElementAt(elem2,0);
          
        ViewGenerica view = new ViewGenerica(vec);
        
        return new Java2JavaScript().execute(view,new String[]{"DESC_SERVIZIO","CODE_SERVIZIO"},new String[]{"text","value"});
      }
}
