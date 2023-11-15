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
public class Action_J2_LstGestori  implements ActionInterface
{
  public Action_J2_LstGestori()
  {
  }
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
          String code_servizio = request.getParameter("code_servizio");
          
          /* istanzio l'ejb dove fare le select - inizio */
          Ent_CatalogoHome home=(Ent_CatalogoHome)EjbConnector.getHome("Ent_Catalogo",Ent_CatalogoHome.class);
          Vector vec=home.create().getPreGestori(code_servizio);
          /* istanzio l'ejb dove fare le select - fine */
          
          DB_Gestori elem=new DB_Gestori();
          elem.setCODE_GESTORE("");
          elem.setDESC_GESTORE("Selezionare Gestore");
          vec.insertElementAt(elem,0);
          View_J2_Gestori view=new View_J2_Gestori(vec);
          return new Java2JavaScript().execute(view,new String[]{"DESC_GESTORE","CODE_GESTORE"},new String[]{"text","value"});
  }
}
