package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.rmi.RemoteException;
import com.utl.*;
import java.util.Vector;

public class EntBatchSTLBean extends AbstractClassicEJB implements SessionBean 
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


// lancioBatch
public Integer lancioBatch (String pstr_Parametri)
	throws CustomException, RemoteException
{
	try
	{

		String[][] larr_CallSP =
				{{StaticContext.PKG_LANCIOBATCH + "Send_Request"},
				 {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
				 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, "0"},
				 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_Parametri}
				};
       
		Vector lvct_SPReturn = this.callSP(larr_CallSP);
		Integer lint_Return = (Integer)lvct_SPReturn.get(0);

//Integer lint_Return = new Integer(StaticContext.RIBES_INFR_NOT_OK);
		return lint_Return;
	}
	catch(Exception lexc_Exception)
	{
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"lancioBatch",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}
// getElabBatchVerifica
public Vector getElabBatchVerifica (int pint_OperazioneRichiesta,
                                        String pstr_TipoContratto,
                                        String pstr_CodeFunz)
    throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";

    try
    {
    switch (pint_OperazioneRichiesta)
      {
         default :
             lstr_StoredProcedureName = StaticContext.PACKAGE_SPECIAL + ".getElabBatchVerifica" ;
            break;
       }
       
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_TipoContratto},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_CodeFunz}
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Batch.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getElabBatchVerifica",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

  // insParamValoriz ,,,,
  public Integer insParamValoriz(int pint_OperazioneRichiesta,DB_Account pDB_Account )
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {
      switch (pint_OperazioneRichiesta)
      {
         default :
            lstr_StoredProcedureName = StaticContext.PACKAGE_SPECIAL + ".insParamValoriz" ;
            break;
      }

      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Account.getCODE_ACCOUNT()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, ""},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Account.getDATA_INIZIO_PERIODO()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Account.getDATA_FINE_PERIODO()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Account.getDATA_INIZIO_CICLO_FATRZ()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Account.getDATA_FINE_CICLO_FATRZ()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Account.getDATA_CONG()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, ""},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Account.getTIPO_FLAG_ERR_BLOCC()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Account.getTIPO_FLAG_STATO_CONG()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_DOUBLE, ""}
                   };

      Vector lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insParamValoriz",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }


}