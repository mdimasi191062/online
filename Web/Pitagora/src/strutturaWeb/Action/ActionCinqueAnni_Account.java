package com.strutturaWeb.Action;

import com.ejbSTL.Ent_CinqueAnniHome;
import com.ejbSTL.Ent_PromoAreeHome;

import com.strutturaWeb.EjbConnector;
import com.strutturaWeb.Java2JavaScript;
import com.strutturaWeb.View.ViewGenerica;

import com.utl.DB_Account;
import com.utl.DB_Servizio;

import com.utl.Misc;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ActionCinqueAnni_Account implements ActionInterface
{
       
        public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
          {

              String codeServizio = Misc.nh(request.getParameter("codeServizio"));
              Ent_CinqueAnniHome home=(Ent_CinqueAnniHome)EjbConnector.getHome("CinqueAnni",Ent_CinqueAnniHome.class);
              
              Vector vec=home.create().getAccountByCodeServizio(codeServizio);
              
              DB_Account elem=new DB_Account();
              elem.setCODE_ACCOUNT("");
              elem.setDESC_ACCOUNT("Selezionare Account");
              vec.insertElementAt(elem,0);
              ViewGenerica view=new ViewGenerica(vec);
              return new Java2JavaScript().execute(view,new String[]{"DESC_ACCOUNT","CODE_ACCOUNT"},new String[]{"text","value"});
              
            
          }
}
