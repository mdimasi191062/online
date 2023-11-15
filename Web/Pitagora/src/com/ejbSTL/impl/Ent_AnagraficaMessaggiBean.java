package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.rmi.RemoteException;
import com.utl.*;
import java.util.Vector;


public class Ent_AnagraficaMessaggiBean extends AbstractClassicEJB implements SessionBean 
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



  public Vector getAnagraficaMessaggi(int pint_OperazioneRichiesta,
                                        Vector pvct_ListaMessaggi)
        throws CustomException, RemoteException
  {
    Vector lvct_Return = new Vector();

    try
    {
      for (int i=0; i<pvct_ListaMessaggi.size(); i++)
      {
        Vector lvct_App =  pri_getAnagraficaMessaggi(pint_OperazioneRichiesta,
                                                          (String)pvct_ListaMessaggi.get(i));

        if (lvct_App.size() > 0)
        {
          lvct_Return.addElement(lvct_App.get(0));
        }
      }

      return (lvct_Return);
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"1",
									"getAnagraficaMessaggi",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

  public String getAnagraficaMessaggi(int pint_OperazioneRichiesta,
                                        String pstr_CodiceMessaggio)
        throws CustomException, RemoteException
  {
    try
    {
      Vector lvct_App = pri_getAnagraficaMessaggi (pint_OperazioneRichiesta, pstr_CodiceMessaggio);
      if (lvct_App.size() > 0)
        {
        DB_AnagraficaMessaggi ldb_App = (DB_AnagraficaMessaggi)lvct_App.get(0);
        return (ldb_App.getDESC_ERR());
        }
      else
        return "";
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"2",
									"getAnagraficaMessaggi",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

  private Vector pri_getAnagraficaMessaggi(int pint_OperazioneRichiesta,
                                                            String pstr_CodiceMessaggio)
        throws Exception
  {
    String lstr_StoredProcedureName = "";

    switch (pint_OperazioneRichiesta)
    {
        default :
          lstr_StoredProcedureName = StaticContext.PKG_ANAGRAFICAMESSAGGI + "getAnagraficaMessaggi";
          break;
    }

    String[][] larr_CallSP =
                {{lstr_StoredProcedureName},
                 {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodiceMessaggio}};

    Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_AnagraficaMessaggi.class);
    Vector lvct_App = (Vector)lvct_SPReturn.get(0);
    return lvct_App;
 }

}