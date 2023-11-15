package com.strutturaWeb.Action;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.naming.*;
import javax.rmi.*;
import java.io.*;
import java.util.*;
import com.ejbBMP.*;
import com.ejbSTL.*;
import java.text.*;
import com.utl.*;
import com.strutturaWeb.View.*;
import com.strutturaWeb.Action.*;
import com.strutturaWeb.*;
public class Action_J2_LstAccountAccorpanti  implements ActionInterface
{
  public Action_J2_LstAccountAccorpanti()
  {
  }
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
          String code_servizio = request.getParameter("code_servizio");
          String code_gestore = request.getParameter("code_gestore");
          
          /* istanzio l'ejb dove fare le select - inizio */
          Ent_CatalogoHome home=(Ent_CatalogoHome)EjbConnector.getHome("Ent_Catalogo",Ent_CatalogoHome.class);
          Vector vec=home.create().getPreAccorpanti(code_servizio,code_gestore);
          /* istanzio l'ejb dove fare le select - fine */
          
          DB_AccountNew elem=new DB_AccountNew();
          elem.setCODE_ACCOUNT("");
          elem.setDESC_ACCOUNT("Selezionare Account Accorpante");
          vec.insertElementAt(elem,0);
          View_J2_Servizi view=new View_J2_Servizi(vec);
          return new Java2JavaScript().execute(view,new String[]{"DESC_ACCOUNT","CODE_ACCOUNT"},new String[]{"text","value"});
  }
}
