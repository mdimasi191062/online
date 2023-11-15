package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import com.utl.*;
import java.rmi.RemoteException;
import java.util.Vector;

public class Ent_SpesaComplessivaBean extends AbstractClassicEJB implements SessionBean 
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


// updDataEstrazioneImpt
public Integer updDataEstrazioneImpt (int pint_OperazioneRichiesta,
                                        String pstr_CodeTestSpesaCompl,
                                        String pstr_DataEstrazioneImpt)
    throws CustomException, RemoteException
{
String lstr_StoredProcedureName = "";

    try
    {
        switch (pint_OperazioneRichiesta)
        {
            default:
                lstr_StoredProcedureName = StaticContext.PKG_SPESACOMPLESSIVA + "updDataEstrazioneImpt" ;
                break;
        }

        String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTestSpesaCompl},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_DataEstrazioneImpt},
                  };

        Vector lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lint_Return = (Integer)lvct_SPReturn.get(0);

        return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"updDataEstrazioneImpt",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}


// updDettaglioSpesaCompl
public Integer updDettaglioSpesaCompl (int pint_OperazioneRichiesta,
                                        DB_SpesaComplessiva pdb_SpesaComplessiva)
    throws CustomException, RemoteException
{
String lstr_StoredProcedureName = "";

    try
    {
        switch (pint_OperazioneRichiesta)
        {
            default:
                lstr_StoredProcedureName = StaticContext.PKG_SPESACOMPLESSIVA + "updDettaglioSpesaCompl" ;
                break;
        }

        String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pdb_SpesaComplessiva.getCODE_DETT_SPESA_COMPL()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pdb_SpesaComplessiva.getCODE_TEST_SPESA_COMPL()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pdb_SpesaComplessiva.getCODE_PROC_EMITT()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_DOUBLE, pdb_SpesaComplessiva.getIMPT_SPESA_COMPL()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pdb_SpesaComplessiva.getDATA_ESTRAZIONE_IMPT()},
                  };

        Vector lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lint_Return = (Integer)lvct_SPReturn.get(0);

        return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"updDettaglioSpesaCompl",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}


// insDettaglioSpesaCompl
public Integer insDettaglioSpesaCompl (int pint_OperazioneRichiesta,
                                        DB_SpesaComplessiva pdb_SpesaComplessiva)
    throws CustomException, RemoteException
{
String lstr_StoredProcedureName = "";

    try
    {
        switch (pint_OperazioneRichiesta)
        {
            default:
                lstr_StoredProcedureName = StaticContext.PKG_SPESACOMPLESSIVA + "insDettaglioSpesaCompl" ;
                break;
        }

        String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pdb_SpesaComplessiva.getCODE_TEST_SPESA_COMPL()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pdb_SpesaComplessiva.getCODE_PROC_EMITT()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_DOUBLE, pdb_SpesaComplessiva.getIMPT_SPESA_COMPL()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pdb_SpesaComplessiva.getDATA_ESTRAZIONE_IMPT()},
                  };

        Vector lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lint_Return = (Integer)lvct_SPReturn.get(0);

        return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insDettaglioSpesaCompl",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}


// updTotaleSpesaCompl
public Integer updTotaleSpesaCompl (int pint_OperazioneRichiesta,
                                        String pstr_CodeTestSpesaCompl,
                                        String pstr_ImptTotSpesaCompl,
                                        String pstr_DataRicezTotSpesa)
    throws CustomException, RemoteException
{
String lstr_StoredProcedureName = "";

    try
    {
        switch (pint_OperazioneRichiesta)
        {
            default:
                lstr_StoredProcedureName = StaticContext.PKG_SPESACOMPLESSIVA + "updTotaleSpesaCompl" ;
                break;
        }

        String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTestSpesaCompl},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_DOUBLE, pstr_ImptTotSpesaCompl},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_DataRicezTotSpesa},
                  };

        Vector lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lint_Return = (Integer)lvct_SPReturn.get(0);

        return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"updTotaleSpesaCompl",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}


// delDettSpesaCompl
public Integer delDettSpesaCompl (int pint_OperazioneRichiesta,
                                        String pstr_CodeTestSpesaCompl)
    throws CustomException, RemoteException
{
String lstr_StoredProcedureName = "";

    try
    {
        switch (pint_OperazioneRichiesta)
        {
            default:
                lstr_StoredProcedureName = StaticContext.PKG_SPESACOMPLESSIVA + "delDettSpesaCompl" ;
                break;
        }

        String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTestSpesaCompl}
                  };

        Vector lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lint_Return = (Integer)lvct_SPReturn.get(0);

        return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"delDettSpesaCompl",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}


// getProcedureEmittenti
public Vector getProcedureEmittenti (int pint_OperazioneRichiesta,
                                        String pstr_CodeTipoContratto,
                                        DB_Account pdb_Account)
    throws CustomException, RemoteException
{
    String lstr_StoredProcedureName = "";

    try
    {
        switch (pint_OperazioneRichiesta)
        {
            default:
                lstr_StoredProcedureName = StaticContext.PKG_SPESACOMPLESSIVA + "getProcedureEmittenti" ;
                break;
        }

        String[][] larr_CallSP =
                    {{lstr_StoredProcedureName},
                     {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoContratto},
                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pdb_Account.getCODE_TEST_SPESA_COMPL()}
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_SpesaComplessiva.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getProcedureEmittenti",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}


// getPeriodoAutomTLD
public Vector getPeriodoAutomTLD (String pstr_CodeTipoContratto)
    throws CustomException, RemoteException
{
    String lstr_StoredProcedureName = "";

    try
    {

        lstr_StoredProcedureName = StaticContext.PKG_SPESACOMPLESSIVA + "getPeriodoAutomTLD" ;
        
        String[][] larr_CallSP =
                    {{lstr_StoredProcedureName},
                     {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoContratto}
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Account.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getPeriodoAutomTLD",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}


// CountDettSpComplNoPit
public Integer CountDettSpComplNoPit (String pstr_MeseRiferimento,
                           String pstr_AnnoRiferimento,
                           String pstr_CodeTipoContratto)
    throws CustomException, RemoteException
{
String lstr_StoredProcedureName = "";

    try
    {
        lstr_StoredProcedureName = StaticContext.PKG_SPESACOMPLESSIVA + "CountDettSpComplNoPit" ;

        String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_MeseRiferimento},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_AnnoRiferimento},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoContratto}
                  };

        Vector lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lint_Return = (Integer)lvct_SPReturn.get(0);

        return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"CountDettSpComplNoPit",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}



// GetElabBatchVerificaxTLD
public Vector GetElabBatchVerificaxTLD (String pstr_CodeFunz,
                                        String pstr_CodiceTipoContratto)
    throws CustomException, RemoteException
{
    String lstr_StoredProcedureName = "";

    try
    {
        lstr_StoredProcedureName = StaticContext.PKG_SPESACOMPLESSIVA + "GetElabBatchVerificaxTLD" ;
        
        String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_CodeFunz},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_CodiceTipoContratto}
                  };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Batch.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"GetElabBatchVerificaxTLD",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}


   // getScartiTLD
   public Vector getScartiTLD (String pstr_CodeFunz)
   throws CustomException, RemoteException
   {
    try{

      String lstr_StoredProcedureName = "";
      lstr_StoredProcedureName = StaticContext.PKG_SCARTI + "getScartiTLD" ;

       String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeFunz}
                   };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Scarti.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getScartiTLD",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }  
}