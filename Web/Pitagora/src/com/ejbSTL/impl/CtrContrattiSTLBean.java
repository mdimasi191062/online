package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.rmi.PortableRemoteObject;
import com.utl.*;
import com.ejbSTL.*;
import java.rmi.RemoteException;
import java.util.Vector;
import java.util.GregorianCalendar;


public class CtrContrattiSTLBean extends AbstractClassicEJB implements SessionBean 
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
  
  // getAccountStatoProvvisorio ,,,,
  public Vector getAccountStatoProvvisorio (Vector pvct_AccountSelezionati,
                                                String pstr_TipoContratto,
                                                String pstr_CodeFunz)
     throws CustomException, RemoteException
  {
    Vector lvct_ElabAccount = new Vector();
    Object homeObject = null;
    Context lcls_Contesto = null;
    EntContrattiSTL lEntContrattiSTL = null;
    EntContrattiSTLHome lEntContrattiSTLHome = null;
    DB_Account lDB_AccountSelezionato = null;
    Vector lvct_AccountFound = null;
    try 
    {
      if ( pvct_AccountSelezionati != null && pvct_AccountSelezionati.size() > 0)
      {
        // Acquisisco il contesto del componente
        lcls_Contesto = new InitialContext();

        // Istanzio una classe EntContrattiSTL
        homeObject = lcls_Contesto.lookup("EntContrattiSTL");
        lEntContrattiSTLHome = (EntContrattiSTLHome)PortableRemoteObject.narrow(homeObject, EntContrattiSTLHome.class);
        lEntContrattiSTL = lEntContrattiSTLHome.create();

        for (int ind=0; ind < pvct_AccountSelezionati.size(); ind++)
        {
          lDB_AccountSelezionato = (DB_Account)pvct_AccountSelezionati.get(ind);
          lvct_AccountFound = lEntContrattiSTL.getAccountStatoProvvisorio(StaticContext.LIST,
                                              lDB_AccountSelezionato.getCODE_ACCOUNT(),
                                              lDB_AccountSelezionato.getCODE_GEST(),
                                              pstr_TipoContratto,
                                              pstr_CodeFunz);
                                              
          if ( lvct_AccountFound!=null && lvct_AccountFound.size() > 0 )
          {
            lvct_ElabAccount.addElement((Object)lvct_AccountFound.get(0));
          }
        }
      }
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getAccountStatoProvvisorio",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}

    return lvct_ElabAccount;
  }

}