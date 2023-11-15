package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.rmi.RemoteException;
import com.utl.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import java.util.Vector;

public class Ent_ExportPerSapBean extends AbstractClassicEJB implements SessionBean 
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

// getDateCicloFattSap
  public Vector getDateCicloFattSap ()
        throws CustomException, RemoteException
  {
   String lstr_StoredProcedureName = "";

    try
    {
      lstr_StoredProcedureName = StaticContext.PKG_CONTRATTI + "getDateCicloFattSap" ;
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_ExportPerSap.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getDateCicloFattSap",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

// getDataFinePeriodoSap
  public Vector getDataFinePeriodoSap ()
        throws CustomException, RemoteException
  {
   String lstr_StoredProcedureName = "";

    try
    {
      lstr_StoredProcedureName = StaticContext.PKG_CONTRATTI + "getDataFinePeriodoSap" ;
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_ExportPerSap.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getDataFinePeriodoSap",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

  
// getClientiValidiSap
  public Vector getClientiValidiSap ()
        throws CustomException, RemoteException
  {
   String lstr_StoredProcedureName = "";

    try
    {
      lstr_StoredProcedureName = StaticContext.PKG_CONTRATTI + "getClientiValidiSap" ;
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Clienti.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getClientiValidiSap",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }
   
  // getElabBatchVerificaSpAccorp
public Vector getElabBatchVerificaSpAccorp (String pstr_CodeFunz,String pstr_CodeFunzPkg)

    throws CustomException, RemoteException
{
    String lstr_StoredProcedureName = "";
    try
    {
    
        lstr_StoredProcedureName = StaticContext.PKG_CLASSISCONTO + "getElabBatchVerificaSpAccorp";
        
        String[][] larr_CallSP =
                    {{lstr_StoredProcedureName},
                     {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeFunz},
					 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeFunzPkg}
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Batch.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getElabBatchVerificaSpAccorp",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}

// getElabBatchVerificaImport
public Vector getElabBatchVerificaImport (String pstr_CodeFunz,String pstr_CodeFunzPkg)
    throws CustomException, RemoteException
{
  String lstr_StoredProcedureName = "";
  try
    {
      lstr_StoredProcedureName = StaticContext.PKG_CLASSISCONTO + "getElabBatchVerificaSpAccorp";

      String[][] larr_CallSP =
                 {{lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeFunz},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeFunzPkg}};

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Batch.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  							"",
									"getElabBatchVerificaImport",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
  	}
}

//getPopolamentoCsv

  public Integer countTestCsvSap()
        throws CustomException, RemoteException
  {
   String lstr_StoredProcedureName = "";

    try
    {
      lstr_StoredProcedureName = StaticContext.PKG_CONTRATTI + "countTestCsvSap" ;
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                   };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Batch.class);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"countTestCsvSap",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }
  
}
