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
import com.usr.clsInfoUser;

import java.util.regex.Pattern;

public class ActionInserisciTariffa implements ActionInterface
{
  public ActionInserisciTariffa()
  {
  }
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
     String i_code_utente=((clsInfoUser)request.getSession().getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName();
    String sessionObject = "ElencoPromozioni_"+i_code_utente;
    
    HttpSession session = request.getSession();
    Vector vec_promozioni;
    
    if(session.getAttribute(sessionObject) != null)
    {
      /*elemento già presente*/
      vec_promozioni = (Vector)session.getAttribute(sessionObject);
    }else
    {
      vec_promozioni = new Vector();
      /*elemento non presente*/
    }
    
    String i_code_ogg_fatrz=request.getParameter("code_ogg_fatrz");
    String i_data_inizio_tariffa_s=request.getParameter("data_inizio_tariffa");
    if(i_data_inizio_tariffa_s.equalsIgnoreCase(""))
       return new Java2JavaScript().execute(new ViewLancioBatch("Impostare la data inizio tariffa"),new String[]{"_messaggio"},new String[]{"messaggio"});
    String i_desc_tariffa=request.getParameter("desc_tariffa");
    if(i_desc_tariffa.equalsIgnoreCase(""))
       throw new Exception("Si deve impostare la descrizione tariffa!");
    String i_impt_tariffa_s=request.getParameter("impt_tariffa");
     if(i_impt_tariffa_s.equalsIgnoreCase(""))
       throw new Exception("Si deve impostare l'importo tariffa!");
    try{
      Double.parseDouble(i_impt_tariffa_s);
    }
    catch(Exception e)
    {
      throw new Exception("Importo non valido!");
    }
    
    String i_tipo_flag_modal_appl_tariffa=request.getParameter("tipo_flag_modal_appl_tariffa");
    if(i_tipo_flag_modal_appl_tariffa.equalsIgnoreCase(""))
      i_tipo_flag_modal_appl_tariffa="F";
      
    String i_code_ps=request.getParameter("code_ps");
    
    String i_code_unita_di_misura=request.getParameter("code_unita_di_misura");
    if(i_code_unita_di_misura.equalsIgnoreCase(""))
      i_code_unita_di_misura=null;

    String i_flag_repricing=request.getParameter("flag_repricing");
    String i_code_tipo_caus=request.getParameter("code_tipo_caus");
    if(i_code_tipo_caus.equalsIgnoreCase(""))
          i_code_tipo_caus=null;
    String i_code_contr=request.getParameter("code_contr");
    
    String i_desc_listino_applicato=request.getParameter("listino_applicato");
    
    if(i_code_contr.equalsIgnoreCase("0"))
      i_code_contr=null;

String i_code_tipo_contr = null;
String i_code_cluster = null;
String i_tipo_cluster = null;

if ( i_code_contr != null && i_code_contr.indexOf("||") >= 0 ) {
          String[] loc_data = i_code_contr.split(Pattern.quote( "||" ) );
          i_code_contr = loc_data[0];
          i_code_tipo_contr = loc_data[3];
          i_code_cluster = loc_data[1];
          i_tipo_cluster = loc_data[2];
}

    TariffaBMPHome home=(TariffaBMPHome)EjbConnector.getHome("TariffaBMP",TariffaBMPHome.class);
    
    TariffeSpecial retInsTariffa = null;
    try{
    
      if (i_code_cluster!= null) {
          retInsTariffa = (TariffeSpecial)home.addTariffaSpecialNewClus(i_code_utente,i_code_ogg_fatrz,
                                                                  i_data_inizio_tariffa_s,i_desc_tariffa,
                                                                  i_impt_tariffa_s,i_tipo_flag_modal_appl_tariffa,
                                                                  i_code_ps,i_code_unita_di_misura,
                                                                  i_flag_repricing,i_code_tipo_caus,i_code_contr,i_desc_listino_applicato,
                                                                  i_code_cluster, i_tipo_cluster, i_code_tipo_contr);
      } else {
        retInsTariffa = (TariffeSpecial)home.addTariffaSpecialNew(i_code_utente,i_code_ogg_fatrz,
                                                                i_data_inizio_tariffa_s,i_desc_tariffa,
                                                                i_impt_tariffa_s,i_tipo_flag_modal_appl_tariffa,
                                                                i_code_ps,i_code_unita_di_misura,
                                                                i_flag_repricing,i_code_tipo_caus,i_code_contr,i_desc_listino_applicato);
      }
      
      if(retInsTariffa.getFLAG_SYS().equals("")){
        if(vec_promozioni.size()>0){
          PromozioniDett promo = null;
          int ritornoAssPromo = 0;
          for(int i=0; i<vec_promozioni.size();i++){
            promo = (PromozioniDett)vec_promozioni.get(i);
            
            if ( i_code_cluster!= null ) {
                ritornoAssPromo = home.addPromozioneTariffaSpecialNewClu(promo.getCodePromozione(),i_code_contr,
                                                                   retInsTariffa.getCODE_TARIFFA(),retInsTariffa.getCODE_PR_TARIFFA(),
                                                                   "1",promo.getDIV(), promo.getDFV(), promo.getDIVC(), promo.getDFVC(),
                                                                   promo.getNUMC(), promo.getCODE_PROG_BILL(),i_code_cluster,i_tipo_cluster,i_code_tipo_contr);
            } else {
               ritornoAssPromo = home.addPromozioneTariffaSpecialNew(promo.getCodePromozione(),i_code_contr,
                                                                  retInsTariffa.getCODE_TARIFFA(),retInsTariffa.getCODE_PR_TARIFFA(),
                                                                  "1",promo.getDIV(), promo.getDFV(), promo.getDIVC(), promo.getDFVC(),
                                                                  promo.getNUMC(), promo.getCODE_PROG_BILL());
            }
            if(ritornoAssPromo != 0)
              return new Java2JavaScript().execute(new ViewLancioBatch("Errore Associazione Promozione ["+promo.getCodePromozione()+"]!!"),new String[]{"_messaggio"},new String[]{"messaggio"});
          }
        }   
      }
      
      if(session.getAttribute(sessionObject) != null)
      {
         session.removeAttribute(sessionObject);
      }
      
      return new Java2JavaScript().execute(new ViewLancioBatch("Inserimento effettuato con successo!!"),new String[]{"_messaggio"},new String[]{"messaggio"});
    }catch(Exception e)
    {
      return new Java2JavaScript().execute(new ViewLancioBatch(e.getMessage()),new String[]{"_messaggio"},new String[]{"messaggio"});
    }
  }
}