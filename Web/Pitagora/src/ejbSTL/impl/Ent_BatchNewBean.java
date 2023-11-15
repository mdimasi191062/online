package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.rmi.RemoteException;
import com.utl.*;
import java.util.Vector;

public class Ent_BatchNewBean extends AbstractClassicEJB implements SessionBean 
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

  public boolean chkElabBatch (String strParCodeFunz) throws CustomException, RemoteException  {
    String lstr_StoredProcedureName = "";

    try
    {
      lstr_StoredProcedureName = StaticContext.PKG_BATCH_NEW + "checkElabBatch" ;
       
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,strParCodeFunz}
                   };

      Vector lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      if (lint_Return.intValue()>0)
        return true;
      else
        return false;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"chkElabBatch",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

}