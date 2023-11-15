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

import javax.swing.JOptionPane;

public class ActionVerificaBatch implements ActionInterface
{
  public ActionVerificaBatch()
  {
  }
  
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
      String mb;
      String messaggio=StrutturaWebStaticUtil.creaClobLancioBatch(request);
  try{
      int flagTipoContr=Integer.parseInt(request.getParameter("codiceTipoContratto"));
      String codeTipoContr = Misc.nh(request.getParameter("codeTipoContr"));
      String codeFunz= Misc.nh(request.getParameter("codeFunz"));
      int numElabInCorsoAcc = 0;
      int operazioniManuali =0;
      String Accounts=messaggio.split("\\$_")[1];
      String[] account=Accounts.split("\\$");
          
      ElaborBatchBMPHome homeEB=(ElaborBatchBMPHome)EjbConnector.getHome("ElaborBatchBMP",ElaborBatchBMPHome.class);
      if(codeTipoContr != null && !codeTipoContr.equals(""))
       {
       
           operazioniManuali= (homeEB.findManualUpdateCodeFunz(account)).getElabUguali();
            if (operazioniManuali>0){
              operazioniManuali=0;
           

              //   return new Java2JavaScript().execute( window.confirm("Si è scelto di inviare questo modulo al destinatario. Interrompere l'esecuzione?"); )
            } else 
        numElabInCorsoAcc = (homeEB.findElabBatchCodeTipoContrUguali(codeTipoContr)).getElabUguali();
       }
      else
        numElabInCorsoAcc = (homeEB.findElabBatchUguali((new Integer(flagTipoContr)).intValue())).getElabUguali();
        
      //int numElabInCorsoAcc = (homeEB.findElabBatchUguali((new Integer(flagTipoContr)).intValue())).getElabUguali();
      if (numElabInCorsoAcc==0) //CASO 0
       {
          LancioBatch lb=new LancioBatch();
          int res=lb.Esecuzione(messaggio);
          
          if(res==0)
          {
              mb="Batch lanciato con successo!";
          }
          else if(res==1)
          {
              mb="Batch schedulato con successo!";
          }
          else
          {
              mb="Errore nel lancio del batch";
          }
       }
       else
       {
            mb="Impossibile lanciare il batch. Ci sono elaborazioni in corso!";
       }
        return new Java2JavaScript().execute(new ViewLancioBatch(mb),new String[]{"_messaggio"},new String[]{"messaggio"});

        }
  catch (Exception e)
        {
              mb="Impossibile lanciare il batch per problemi tecnici!";
              return new Java2JavaScript().execute(new ViewLancioBatch(mb),new String[]{"_messaggio"},new String[]{"messaggio"});
        }
  }
}
