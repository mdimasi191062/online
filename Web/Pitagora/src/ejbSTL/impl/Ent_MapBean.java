package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.rmi.RemoteException;
import com.utl.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import java.util.Vector;


public class Ent_MapBean extends AbstractClassicEJB implements SessionBean 
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

  public Vector getMap (int pint_OperazioneRichiesta)
        throws CustomException, RemoteException     
  {
    String lstr_StoredProcedureName = "";
    try
    {
     switch (pint_OperazioneRichiesta)
      {
         default :
            lstr_StoredProcedureName = StaticContext.PKG_MAP + "getMap" ;
            break;
      }
      
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR}};

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Map.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getMap",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

}