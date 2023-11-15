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
public class Action_J2_CheckRettificaSuperRipr implements ActionInterface
{
  public Action_J2_CheckRettificaSuperRipr()
  {
  }
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
    String[] temp;
    String code_istanza_prod             = request.getParameter("srcIstanzaProd");
    
    String appo =  request.getParameter("srcIdEvento");
    temp = appo.split("@",2);

    String idEventoRipr          = temp[0];
    String IdEventoInizile     = temp[1];
   
          
    int ritorno = 0;
    String messaggio = "";
    try
    {
        /* 1 - se nel range di eventi da ripirstinare è compreso una rettifica */
          /* 2 - se nel range di eventi da ripirstinare è compreso un evento già ripistinato */
          /* 3 - se nel range di eventi da ripirstinare è compreso un evento superevento */
         
     Ent_InventariHome home=(Ent_InventariHome)EjbConnector.getHome("Ent_Inventari",Ent_InventariHome.class);
     ritorno = home.create().checkRettificaSuperRipr(code_istanza_prod,idEventoRipr,IdEventoInizile);

     messaggio =String.valueOf(ritorno) ;
        

    }catch(Exception e){
      System.out.println("Action_J2_CheckRettificaSuperRipr Exception");
      System.out.println(e.getMessage().toString());
    }
          
    return new Java2JavaScript().execute(new ViewLancioBatch(messaggio),new String[]{"_messaggio"},new String[]{"messaggio"});
  }
}
