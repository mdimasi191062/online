package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.rmi.RemoteException;
import com.utl.*;
import java.util.Vector;


public class Ent_ScontiBean extends AbstractClassicEJB implements SessionBean 
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



  // getSconti
  public Vector getSconti
      (int pint_funzionalita
      ,int pint_operazioneRichiesta)
      throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";

    try
    {
      lstr_StoredProcedureName = StaticContext.PKG_SCONTI + "getSconti" ;
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Sconti.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
    throw new CustomException(lexc_Exception.toString(),
                    "",
                  "getSconti",
                  this.getClass().getName(),
                  StaticContext.FindExceptionType(lexc_Exception));
    }
  }



  // getScarti
  public Vector getSconti (String pstrVALO_PERC)
   throws CustomException, RemoteException
   {
    String lstr_StoredProcedureName = "";
    try
    {
      lstr_StoredProcedureName = StaticContext.PKG_SCONTI + "getScontiTn" ;
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, pstrVALO_PERC},
                   };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Sconti.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
    throw new CustomException(lexc_Exception.toString(),
                    "",
                  "getSconti",
                  this.getClass().getName(),
                  StaticContext.FindExceptionType(lexc_Exception));
  }
  }  
  // updSconto
  public Integer updSconto(String pstr_VALO_PERC,
                           String pstr_VALO_LIM_MIN,
                           String pstr_VALO_LIM_MAX)
   throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {
      lstr_StoredProcedureName = StaticContext.PKG_SCONTI + "updScontoTn" ;
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_VALO_PERC},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_VALO_LIM_MIN},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_VALO_LIM_MAX}
                   };

      Vector lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"updSconto",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }
// insSconto
  public Integer insSconto(String pstr_VALO_PERC,
                           String pstr_VALO_LIM_MIN,
                           String pstr_VALO_LIM_MAX)
   throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {
      
      lstr_StoredProcedureName = StaticContext.PKG_SCONTI + "insScontoTn" ;
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_VALO_PERC},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_VALO_LIM_MIN},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_VALO_LIM_MAX}
                   };

      Vector lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insSconto",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }
// delSconto
  public Integer delSconto(String pstr_VALO_PERC)
   throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {
      lstr_StoredProcedureName = StaticContext.PKG_SCONTI + "delScontoTn" ;
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_VALO_PERC}
                   };

      Vector lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insSconto",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }
  //countScontoTnValMinMax
  public Integer countScontoTnValMinMax(String pstr_VALO_PERC,
                           String pstr_VALO_LIM_MIN_MAX)
   throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {
      lstr_StoredProcedureName = StaticContext.PKG_SCONTI + "countScontoTnvalminmax" ;
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_VALO_PERC},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_VALO_LIM_MIN_MAX}
                   };

      Vector lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"countScontoTnValMinMax",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }
  //countScontoTnGiaPresente
 public Integer countScontoTnGiaPresente(String pstr_VALO_PERC)
   throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {
      lstr_StoredProcedureName = StaticContext.PKG_SCONTI + "countScontoTnGiaPresente" ;
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_VALO_PERC}
                   };

      Vector lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"countScontoTnGiaPresente",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }
}