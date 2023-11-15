package com.strutturaWeb.Action;

import com.ejbSTL.Ent_PromoAreeHome;

import com.strutturaWeb.EjbConnector;
import com.strutturaWeb.Java2JavaScript;
import com.strutturaWeb.View.ViewGenerica;

import com.utl.DB_AreeRaccolta;
import com.utl.DB_Servizio;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ActionPromoAree_AreeRaccolta implements ActionInterface
    {
  
    public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
      {

        Ent_PromoAreeHome home=(Ent_PromoAreeHome)EjbConnector.getHome("PromoAree",Ent_PromoAreeHome.class);
        
        Vector vec=home.create().getAreeRaccolta();
        
        DB_AreeRaccolta elem=new DB_AreeRaccolta();
        elem.setCODE_AREERACCOLTA("");
        elem.setDESC_AREERACCOLTA("Selezionare Area Raccolta");
        vec.insertElementAt(elem,0);
        ViewGenerica view=new ViewGenerica(vec);
        return new Java2JavaScript().execute(view,new String[]{"DESC_AREERACCOLTA","CODE_AREERACCOLTA"},new String[]{"text","value"});
        
      }
}
