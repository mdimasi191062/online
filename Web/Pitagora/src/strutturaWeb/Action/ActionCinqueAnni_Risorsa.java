package com.strutturaWeb.Action;

import com.ejbSTL.Ent_CinqueAnniHome;
import com.ejbSTL.Ent_PromoAreeHome;

import com.strutturaWeb.EjbConnector;
import com.strutturaWeb.Java2JavaScript;
import com.strutturaWeb.View.ViewGenerica;

import com.utl.CustomException;
import com.utl.DB_Account;
import com.utl.DB_InventProd;
import com.utl.DB_Istanza;
import com.utl.Misc;

import java.rmi.RemoteException;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ActionCinqueAnni_Risorsa implements ActionInterface
{
    public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
      {
        Ent_CinqueAnniHome home=(Ent_CinqueAnniHome)EjbConnector.getHome("CinqueAnni",Ent_CinqueAnniHome.class);
         

        Vector vec=home.create().getRisorse();
        
        DB_Istanza elem=new DB_Istanza();
        elem.setCODE_ISTANZA("");
        elem.setDESC_ISTANZA("Selezionare Risorsa");
        vec.insertElementAt(elem,0);
        ViewGenerica view=new ViewGenerica(vec);
        return new Java2JavaScript().execute(view,new String[]{"DESC_ISTANZA","CODE_ISTANZA"},new String[]{"text","value"});
        
      }
}

