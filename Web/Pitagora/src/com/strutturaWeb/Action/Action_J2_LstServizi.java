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
public class Action_J2_LstServizi implements ActionInterface
{
  public Action_J2_LstServizi()
  {
  }
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
          String code_tipo_contr=request.getParameter("codiceTipoContratto");
          
          /* istanzio l'ejb dove fare le select - inizio */
          Ent_CatalogoHome home=(Ent_CatalogoHome)EjbConnector.getHome("Ent_Catalogo",Ent_CatalogoHome.class);
          Vector vec=home.create().getPreServizi();
          /* istanzio l'ejb dove fare le select - fine */
          
          DB_Servizio elem=new DB_Servizio();
          elem.setCODE_SERVIZIO("");
          elem.setDESC_SERVIZIO("Selezionare Servizio");
          vec.insertElementAt(elem,0);
          View_J2_Servizi view=new View_J2_Servizi(vec);
          return new Java2JavaScript().execute(view,new String[]{"DESC_SERVIZIO","CODE_SERVIZIO"},new String[]{"text","value"});
  }
}
