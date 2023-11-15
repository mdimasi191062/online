package com.strutturaWeb.Action;

import com.ejbSTL.Ent_CodiceProgettoHome;

import com.strutturaWeb.EjbConnector;
import com.strutturaWeb.Java2JavaScript;
import com.strutturaWeb.View.ViewGenerica;

import com.utl.DB_Account;

import com.utl.Misc;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ActionCodiceProgetto_Account implements ActionInterface
{
    public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
    {
        String codeServizioLogico = Misc.nh(request.getParameter("codeServizioLogico"));
        Ent_CodiceProgettoHome home=(Ent_CodiceProgettoHome)EjbConnector.getHome("CodiceProgetto",Ent_CodiceProgettoHome.class);
        
        Vector vec = home.create().getAccountByCodeServizioLogico(codeServizioLogico);
        
        DB_Account elem = new DB_Account();
        
        elem.setCODE_ACCOUNT("-9");
        elem.setDESC_ACCOUNT("Nessun Account");
        
        vec.insertElementAt(elem,0);
        
        ViewGenerica view = new ViewGenerica(vec);
        
        return new Java2JavaScript().execute(view,new String[]{"DESC_ACCOUNT","CODE_ACCOUNT"},new String[]{"text","value"});
    }
}
