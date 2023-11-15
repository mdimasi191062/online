package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.rmi.RemoteException;
import com.utl.*;
import java.util.Vector;


public class Ent_ClientiBean extends AbstractClassicEJB implements SessionBean 
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

  // getClienti
  public Vector getClienti(int pint_OperazioneRichiesta,
                           int pint_Funzionalita,
                           String pstr_TipoContratto,
                           String pstr_ClientiSrc)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";

    try
    {
        switch (pint_Funzionalita)
        {
            default:
                switch (pint_OperazioneRichiesta)
                {
                    default :
                        lstr_StoredProcedureName = StaticContext.PKG_CLIENTI + "getClientiValidi" ;
                        break;
                }
                break;
        }

        String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_TipoContratto},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_ClientiSrc}};
        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Clienti.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getClienti",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

  // getClientiIspOlo
  public Vector getClientiIspOlo ( int pint_OperazioneRichiesta,
                                   String pstr_TipoContratto,
                                   String pstr_Codetipocaus,
                                   String pstr_Codeps,
                                   String pstr_CodeOggfatrz,
                                   String pstr_codeprestagg)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {
        switch (pint_OperazioneRichiesta)
        {
            default :
                lstr_StoredProcedureName = StaticContext.PKG_CLIENTI + "getClientiISPOLO" ;
                break;
        }

        String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_TipoContratto},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_Codetipocaus},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_Codeps},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_CodeOggfatrz},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_codeprestagg}};

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Clienti.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getClientiIspOlo",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

// getPeriodoRiferimento
public Vector getPeriodiRiferimento (int pint_OperazioneRichiesta,
                                      String pstr_CodeTipoContratto)
    throws CustomException, RemoteException
{
    String lstr_StoredProcedureName = "";

    try
    {
        switch (pint_OperazioneRichiesta)
        {
            default:
                lstr_StoredProcedureName = StaticContext.PKG_CLIENTI + "getPeriodiRiferimento" ;
                break;
        }

        String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_CodeTipoContratto},
                  };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_ClientiSpeCom.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getPeriodiRiferimento",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}

}