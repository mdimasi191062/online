package com.strutturaWeb.Action;

import com.ejbSTL.Ent_CinqueAnniHome;

import com.strutturaWeb.EjbConnector;
import com.strutturaWeb.Java2JavaScript;
import com.strutturaWeb.View.ViewGenerica;

import com.utl.DB_DataDa;
import com.utl.DB_Istanza;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ActionCinqueAnni_DataDa implements ActionInterface
{
    public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
      {
        Ent_CinqueAnniHome home=(Ent_CinqueAnniHome)EjbConnector.getHome("CinqueAnni",Ent_CinqueAnniHome.class);
         

        Vector vec=home.create().getDataDa();        
        DB_DataDa elem=new DB_DataDa();
        elem.setCODE_DATADA("");
        //DOR -Modifico primo item combo-
        //elem.setDESC_DATADA("Selezionare Data Da");
        elem.setDESC_DATADA("Selezionare fino a Data Da");
        vec.insertElementAt(elem,0);
        ViewGenerica view=new ViewGenerica(vec);
        return new Java2JavaScript().execute(view,new String[]{"DESC_DATADA","CODE_DATADA"},new String[]{"text","value"});
        
      }
}