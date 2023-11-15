package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.rmi.PortableRemoteObject;
import java.rmi.RemoteException;
import java.util.Vector;
import java.util.GregorianCalendar;
import com.utl.*;
import com.ejbSTL.*;

public class Ctr_ScontiBean implements SessionBean 
{
  public void ejbCreate()
  {
  }

  public void ejbActivate()
  {
  }

  public void ejbPassivate()
  {
  }

  public void ejbRemove()
  {
  }

  public void setSessionContext(SessionContext ctx)
  {
  }

  // insSconto
  public String insSconto(String pstr_VALO_PERC,
                           String pstr_VALO_LIM_MIN,
                           String pstr_VALO_LIM_MAX)
   throws CustomException, RemoteException
  {
    try
    {
      Object homeObject = null;
      Context lcls_Contesto = null;
      Ent_Sconti lEnt_Sconti = null;
      Ent_ScontiHome lEnt_ScontiHome = null;
      String lstr_Messagge = "";
      Integer lint_Result = null;

      // Acquisisco il contesto del componente
      lcls_Contesto = new InitialContext();
      // Istanzio una classe Ent_Sconti
      homeObject = lcls_Contesto.lookup("Ent_Sconti");
      lEnt_ScontiHome = (Ent_ScontiHome)PortableRemoteObject.narrow(homeObject, Ent_ScontiHome.class);
      lEnt_Sconti = lEnt_ScontiHome.create();

      //Conteggio già presenti
      lint_Result = (Integer)lEnt_Sconti.countScontoTnGiaPresente(pstr_VALO_PERC);
      if(lint_Result.intValue()>0)
      {
        lstr_Messagge = "Impossibile procedere con l'inserimento dei dati. Il valore percentuale selezionato è già presente in archivio!";
      }else{ 
        //Conteggio Limite Minimo
        lint_Result = (Integer)lEnt_Sconti.countScontoTnValMinMax(pstr_VALO_PERC, pstr_VALO_LIM_MIN);
        if(lint_Result.intValue()>0)
        {
          lstr_Messagge = "Attenzione, Il Limite Minimo è già presente in altre fasce di sconto!<br>";
        }
        //Conteggio Limite Massimo
        lint_Result = (Integer)lEnt_Sconti.countScontoTnValMinMax(pstr_VALO_PERC, pstr_VALO_LIM_MAX);
        if(lint_Result.intValue()>0)
        {
          lstr_Messagge += "Attenzione, Il Limite Massimo è già presente in altre fasce di sconto!<br>";
        }
        if(lstr_Messagge.equals(""))
        {
          //procedo con l'inserimento.
          lint_Result = (Integer)lEnt_Sconti.insSconto(pstr_VALO_PERC, pstr_VALO_LIM_MIN, pstr_VALO_LIM_MAX);
        }
      }      
      return lstr_Messagge;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insSconto",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }
}