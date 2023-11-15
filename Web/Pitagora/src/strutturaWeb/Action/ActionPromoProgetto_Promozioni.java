package com.strutturaWeb.Action;

import com.ejbSTL.Ent_PromoProgettoHome;

import com.strutturaWeb.EjbConnector;
import com.strutturaWeb.Java2JavaScript;
import com.strutturaWeb.View.ViewGenerica;

import com.utl.PromozioniElem;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ActionPromoProgetto_Promozioni implements ActionInterface
{
    public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
      {
        Ent_PromoProgettoHome home=(Ent_PromoProgettoHome)EjbConnector.getHome("PromoProgetto",Ent_PromoProgettoHome.class);
        
        Vector vec=home.create().getPromozioni();
        
        PromozioniElem elem=new PromozioniElem();
        elem.setCodePromozione("");
        elem.setDescPromozione("Selezionare Codice Promozione");
        vec.insertElementAt(elem,0);
        ViewGenerica view=new ViewGenerica(vec);
        return new Java2JavaScript().execute(view,new String[]{"descPromozione","codePromozione"},new String[]{"text","value"});
        
      }
}
