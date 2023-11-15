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
public class Action_J2_CheckTariffaRepricing implements ActionInterface
{
  public Action_J2_CheckTariffaRepricing()
  {
  }
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
    String code_tariffa             = request.getParameter("code_tariffa");
    String code_pr_tariffa          = request.getParameter("code_pr_tariffa");
    String data_inizio_validita     = request.getParameter("DataInizioValidita");
    String data_inizio_validita_old = request.getParameter("DataInizioValiditaOld");
    String code_ogg_fatrz           = request.getParameter("CodeOggFatrz");
          
    int ritorno = 0;
    String messaggio = "";
    try
    {
      Ent_TariffeHome home=(Ent_TariffeHome)EjbConnector.getHome("Ent_Tariffe",Ent_TariffeHome.class);
      ritorno = home.create().checkTariffaRepricing(code_tariffa,code_pr_tariffa,data_inizio_validita,data_inizio_validita_old,code_ogg_fatrz);
         
      if (ritorno == 0)
        messaggio = "OK";
      else
        messaggio = "REPRICING";
    }catch(Exception e){
      System.out.println("Action_J2_CheckTariffaRepricing Exception");
      System.out.println(e.getMessage().toString());
    }
          
    return new Java2JavaScript().execute(new ViewLancioBatch(messaggio),new String[]{"_messaggio"},new String[]{"messaggio"});
  }
}
