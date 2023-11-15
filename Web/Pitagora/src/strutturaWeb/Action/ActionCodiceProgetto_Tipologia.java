package com.strutturaWeb.Action;

import com.ejbSTL.Ent_CodiceProgettoHome;

import com.strutturaWeb.EjbConnector;
import com.strutturaWeb.Java2JavaScript;
import com.strutturaWeb.View.ViewGenerica;

import com.utl.DB_Servizio;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ActionCodiceProgetto_Tipologia implements ActionInterface  {
    
    public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
    {
        Ent_CodiceProgettoHome home=(Ent_CodiceProgettoHome)EjbConnector.getHome("CodiceProgetto",Ent_CodiceProgettoHome.class);
        
        Vector vec = home.create().getAnagraficaTipologia();
        
        DB_Servizio elem = new DB_Servizio();
        
        elem.setCODE_SERVIZIO("");
        elem.setDESC_SERVIZIO("Selezionare Tipologia");
        
        vec.insertElementAt(elem,0);
          
        ViewGenerica view = new ViewGenerica(vec);
        
        return new Java2JavaScript().execute(view,new String[]{"DESC_SERVIZIO","CODE_SERVIZIO"},new String[]{"text","value"});
    }
}
