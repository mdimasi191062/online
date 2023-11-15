package com.strutturaWeb.Action;

import com.ejbSTL.Ent_CatalogoHome;

import java.util.StringTokenizer;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.*;
import javax.rmi.PortableRemoteObject;
import com.ejbSTL.Ent_Contratti;
import com.ejbSTL.Ent_ContrattiHome;
import com.utl.*;
import com.strutturaWeb.View.*;
import com.strutturaWeb.*;

import java.util.Vector;

public class ActionAddPromozioniSession implements ActionInterface
{
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
    String user_name=request.getParameter("user_name");
    String codePromozione=request.getParameter("code_promozione");
    String div=request.getParameter("data_da");
    String dfv=request.getParameter("data_a");
    String divc=request.getParameter("data_da_can");
    String dfvc=request.getParameter("data_a_can");
    String cpb=request.getParameter("codice_prog_bill");    
    String numMesi=request.getParameter("num_Mesi");    
    String flagAttiva=request.getParameter("flag_attiva");   
    int ritorno = 0;
    String messaggio = "";
    
    HttpSession session = request.getSession();
    
    String sessionObject = "ElencoPromozioni_"+user_name;
    
    PromozioniDett riga = new PromozioniDett();
    riga.setCodePromozione(codePromozione);
    riga.setDIV(div);
    riga.setDFV(dfv);
    riga.setDIVC(divc);
    riga.setDFVC(dfvc);
    riga.setCODE_PROG_BILL(cpb);
    riga.setNUMC(numMesi);
    
    Vector vec;
    try{
      if(session.getAttribute(sessionObject) != null)
      {
        /*elemento già presente*/
        vec = (Vector)session.getAttribute(sessionObject);
      }else
      {
        vec = new Vector();
        /*elemento non presente*/
      }
        
      //PAS 
      int trovato = -1;
      for (int x=0;x<vec.size();x++) {
          if ( ((PromozioniDett)vec.get(0)).getCodePromozione().equals(codePromozione) ) {
              trovato = x;
              ((PromozioniDett)vec.get(0)).setDIV(div);
              ((PromozioniDett)vec.get(0)).setDFV(dfv);
              ((PromozioniDett)vec.get(0)).setDIVC(divc);
              ((PromozioniDett)vec.get(0)).setDFVC(dfvc);
              ((PromozioniDett)vec.get(0)).setCODE_PROG_BILL(cpb);
              ((PromozioniDett)vec.get(0)).setNUMC(numMesi);
              break;
          }
      } 
      
      if (trovato >= 0) {
          ritorno = 0;
      } else {
          if(vec.add(riga))
            ritorno = 0;
          else
            ritorno = 1;
      }
      
      session.setAttribute(sessionObject,vec);
      
      if (ritorno == 0)
        messaggio = "OK sessione";
      else
        messaggio = "KO sessione";
         
      return new Java2JavaScript().execute(new ViewLancioBatch(messaggio),new String[]{"_messaggio"},new String[]{"messaggio"});
    }catch(Exception e){
      System.out.println(e.getMessage());
      messaggio = "KO sessione";
      return messaggio;
    }
  }
}