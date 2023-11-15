package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.rmi.RemoteException;
import com.utl.*;
import java.util.Vector;

public class Ent_Batch_PREBean extends AbstractClassicEJB implements SessionBean 
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


// getAnagBatchPre
public Vector getAnagBatchPre ()
    throws CustomException, RemoteException
{
    String lstr_StoredProcedureName = "";

    try
    {
        lstr_StoredProcedureName = StaticContext.PKG_BATCH + "getAnagBatchPre" ;
        
        String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR}
                  };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Batch_Pre.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getAnagBatchPre",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}


// getElabBatchVerificaPreFatt
public Vector getElabBatchVerificaPreFatt (String pstr_CodeFunz)
    throws CustomException, RemoteException
{
    String lstr_StoredProcedureName = "";
    try
    {
    
      if (pstr_CodeFunz.equalsIgnoreCase(StaticContext.RIBES_TOOL_AUTOMATISMO) || 
          pstr_CodeFunz.equalsIgnoreCase(StaticContext.RIBES_EXPORT_PER_SAP) ||
          pstr_CodeFunz.equalsIgnoreCase(StaticContext.RIBES_LANCIO_PKG) ||
          pstr_CodeFunz.equalsIgnoreCase(StaticContext.RIBES_STORICIZ_NDC_FATT))
      {
        lstr_StoredProcedureName = StaticContext.PKG_CLASSISCONTO + "getElabBatchVerificaPreFatOFPS";
      }else if(pstr_CodeFunz.equalsIgnoreCase(StaticContext.RIBES_TOOL_PREFATTURAZIONE))
      {
        lstr_StoredProcedureName = StaticContext.PKG_CLASSISCONTO + "getElabBatchVerificaPreFatt";
      }
        
        String[][] larr_CallSP =
                    {{lstr_StoredProcedureName},
                     {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeFunz}
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Batch.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getElabBatchVerificaPreFatt",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}
 // getAccountValidi
   public Vector GetAccountValidi (String pstr_TipoContratto,
   							       String pstr_DescAccount)
   throws CustomException, RemoteException
   {
    try{

      String lstr_StoredProcedureName = "";
      lstr_StoredProcedureName = StaticContext.PKG_SCARTI + "getAccountValidi" ;

       String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_TipoContratto},
				   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_DescAccount}
                   };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Account.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getAccountValidi",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

}