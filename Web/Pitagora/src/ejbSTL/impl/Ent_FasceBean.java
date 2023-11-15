package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import com.utl.*;
import java.util.Vector;
import java.rmi.RemoteException;

public class Ent_FasceBean extends AbstractClassicEJB implements SessionBean 
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

  public Vector getFasce( int pint_OperazioneRichiesta )
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {
      switch (pint_OperazioneRichiesta)
      {
          case StaticContext.LIST :
          case StaticContext.INSERT :
            lstr_StoredProcedureName = StaticContext.PKG_FASCE + "getFasce" ;
            break;
      }

      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR}};

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Fascia.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getFasce",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }



  public Vector getDettaglioFasce( int pint_OperazioneRichiesta,
                                    String pstr_CodeFascia)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {
      switch (pint_OperazioneRichiesta)
      {
          case StaticContext.LIST :
          case StaticContext.INSERT :
            lstr_StoredProcedureName = StaticContext.PKG_FASCE + "getDettaglioFasce" ;
            break;
      }

      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeFascia}};

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Fascia.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getDettaglioFasce",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

}