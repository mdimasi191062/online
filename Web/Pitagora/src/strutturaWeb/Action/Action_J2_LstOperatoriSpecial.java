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
public class Action_J2_LstOperatoriSpecial  implements ActionInterface
{
  public Action_J2_LstOperatoriSpecial()
  {
  }
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
          String lista_servizi = request.getParameter("listaServizi");
          
          /* istanzio l'ejb dove fare le select - inizio */
          Ctr_UtilityHome home=(Ctr_UtilityHome)EjbConnector.getHome("Ctr_Utility",Ctr_UtilityHome.class);
          Vector vec=home.create().getOperatoriSpecial(lista_servizi);
          /* istanzio l'ejb dove fare le select - fine */
          
          DB_GestoriSpecial elem=new DB_GestoriSpecial();
          /* elem.setCODE_GEST(""); */
          /* elem.setDESC_ACCOUNT("Selezionare Gestore"); */
          /* vec.insertElementAt(elem,0); */ 
          View_J2_Gestori view=new View_J2_Gestori(vec);
          return new Java2JavaScript().execute(view,new String[]{"DESC_ACCOUNT","CODE_GEST"},new String[]{"text","value"});
  }
}
