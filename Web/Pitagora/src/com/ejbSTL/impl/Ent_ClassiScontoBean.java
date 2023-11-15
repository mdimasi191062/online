package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import com.utl.*;
import java.util.Vector;
import java.rmi.RemoteException;

public class Ent_ClassiScontoBean extends AbstractClassicEJB implements SessionBean 
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


// insDettaglioSpesaCompl
public Integer insParamClasSconto (int pint_OperazioneRichiesta,
                                        DB_ClasseSconto pdb_ClasSconto)
    throws CustomException, RemoteException
{
String lstr_StoredProcedureName = "";

    try
    {
        switch (pint_OperazioneRichiesta)
        {
            default:
                lstr_StoredProcedureName = StaticContext.PKG_CLASSISCONTO + "insParamClasSconto" ;
                break;
        }

        String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pdb_ClasSconto.getCODE_ACCOUNT()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pdb_ClasSconto.getCODE_TEST_SPESA_COMPL()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pdb_ClasSconto.getCODE_CLAS_SCONTO()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pdb_ClasSconto.getCODE_PR_CLAS_SCONTO()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pdb_ClasSconto.getDATA_DECORR_CLAS_SCONTO()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pdb_ClasSconto.getDATA_SCAD_CLAS_SCONTO()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pdb_ClasSconto.getTIPO_FLAG_CONGUAGLIO()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pdb_ClasSconto.getCODE_PARAM_CLAS_SCONTO_RIF()},
                  };

        Vector lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lint_Return = (Integer)lvct_SPReturn.get(0);

        return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insParamClasSconto",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}


  public Vector getClassiSconto( int pint_OperazioneRichiesta )
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {
      switch (pint_OperazioneRichiesta)
      {
          case StaticContext.LIST :
          case StaticContext.INSERT :
            lstr_StoredProcedureName = StaticContext.PKG_CLASSISCONTO + "getClassiSconto" ;
            break;
      }

      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR}};

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_ClasseSconto.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getClassiSconto",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }



  public Vector getDettaglioClassiSconto( int pint_OperazioneRichiesta,
                                          String pstr_CodeClasseSconto)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {
      switch (pint_OperazioneRichiesta)
      {
          case StaticContext.LIST :
          case StaticContext.INSERT :
            lstr_StoredProcedureName = StaticContext.PKG_CLASSISCONTO + "getDettaglioClassiSconto" ;
            break;
      }

      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeClasseSconto}};

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_ClasseSconto.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getDettaglioClassiSconto",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }


// getClassiScontoCalParAll
public Vector getClassiScontoCalParAll (String pstr_Mese,
                                        String pstr_Anno)
    throws CustomException, RemoteException
{
    String lstr_StoredProcedureName = "";
    try
    {
        lstr_StoredProcedureName = StaticContext.PKG_CLASSISCONTO + "getClassiScontoCalParAll" ;
        
        String[][] larr_CallSP =
                    {{lstr_StoredProcedureName},
                     {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_Mese},
                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_Anno}
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_ClasseSconto.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getClassiScontoCalParAll",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}

// getClassiScontoCalPar
public Vector getClassiScontoCalPar (int pint_OperazioneRichiesta,
                                        String pstr_ImptSpesa,
                                        String pstr_CodeGest,
                                        String pstr_Mese,
                                        String pstr_Anno)
    throws CustomException, RemoteException
{
    String lstr_StoredProcedureName = "";
    try
    {
        switch (pint_OperazioneRichiesta)
        {
            default:
                lstr_StoredProcedureName = StaticContext.PKG_CLASSISCONTO + "getClassiScontoCalPar" ;
                break;
        }

        String[][] larr_CallSP =
                    {{lstr_StoredProcedureName},
                     {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_DOUBLE, pstr_ImptSpesa},
                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeGest},
                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_Mese},
                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_Anno}
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_ClasseSconto.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getClassiScontoCalPar",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}


}