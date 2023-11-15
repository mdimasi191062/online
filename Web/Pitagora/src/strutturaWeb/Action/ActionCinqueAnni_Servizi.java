package com.strutturaWeb.Action;

import com.ejbSTL.Ent_CinqueAnniHome;
import com.ejbSTL.Ent_PromoAreeHome;

import com.strutturaWeb.EjbConnector;
import com.strutturaWeb.Java2JavaScript;
import com.strutturaWeb.View.ViewGenerica;

import com.utl.DB_Servizio;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ActionCinqueAnni_Servizi  implements ActionInterface
            {
            public ActionCinqueAnni_Servizi() {
            }
            public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
              {

                Ent_CinqueAnniHome home=(Ent_CinqueAnniHome)EjbConnector.getHome("CinqueAnni",Ent_CinqueAnniHome.class);
                
               Vector vec=home.create().getServizi();
                
                DB_Servizio elem=new DB_Servizio();
                elem.setCODE_SERVIZIO("");
                elem.setDESC_SERVIZIO("Selezionare Servizio");
                vec.insertElementAt(elem,0);
                ViewGenerica view=new ViewGenerica(vec);
                return new Java2JavaScript().execute(view,new String[]{"DESC_SERVIZIO","CODE_SERVIZIO"},new String[]{"text","value"});
                
              }
}
