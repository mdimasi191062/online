package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.rmi.RemoteException;
import com.utl.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import java.util.Vector;

public class EntContrattiSTLBean extends AbstractClassicEJB implements SessionBean 
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
  public Vector getAccountStatoProvvisorio (int pint_OperazioneRichiesta,
                                            String pstr_CodeAccount,
											String pstr_CodeGest,
                                            String pstr_TipoContratto,
                                            String pstr_CodeFunz)
        throws CustomException, RemoteException
  {
   String lstr_StoredProcedureName = "";

    try
    {
      switch (pint_OperazioneRichiesta)
      {
          default:
            lstr_StoredProcedureName = StaticContext.PACKAGE_SPECIAL + ".getAccountStatoProvvisorio" ;
            break;
       }
       
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_TipoContratto},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_CodeFunz},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_CodeAccount},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_CodeGest}
                   };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Account.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getAccountStatoProvvisorio",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

  // getAccountXCodeElab ,,,,
  public Vector getAccountXCodeElab ( int pint_OperazioneRichiesta,
                                      String pstr_CodeElab,
                                      String pstr_TipoContratto,
                                      String pstr_TipoFlagErrBloc)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {
        switch (pint_OperazioneRichiesta)
        {
            default :
                lstr_StoredProcedureName = StaticContext.PACKAGE_SPECIAL + ".getAccountXCodeElab" ;
                break;
        }

        String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_CodeElab},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_TipoContratto},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_TipoFlagErrBloc}
                   };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Account.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getAccountXCodeElab",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }
  // getAccountRepricing ,,,,
  public Vector getAccountRepricing (String pstr_TipoContratto,
                              String code_funz)
        throws CustomException, RemoteException
  {
   String lstr_StoredProcedureName = "";

    try
    {
      lstr_StoredProcedureName = StaticContext.PACKAGE_SPECIAL + ".getAccountRepricing" ;
     
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_TipoContratto},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,code_funz}
                   };                   

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Account.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getAccountRepricing",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

}