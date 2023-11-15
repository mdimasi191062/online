package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.rmi.RemoteException;
import com.utl.*;
import java.util.Vector;

public class Ent_BatchBean extends AbstractClassicEJB implements SessionBean 
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
				 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, "SEND"},
				 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_Parametri},
				 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, null},
 				 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, null},
 				 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, null},
				 {AbstractEJBTypes.PARAMETER_OUTPUT, AbstractEJBTypes.TYPE_STRUCT, "EXTERNAL_LIBRARY_OBJ"}
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


  // chkElabBatch
  public Integer chkElabBatch (int pint_OperazioneRichiesta)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";

    try
    {
    switch (pint_OperazioneRichiesta)
      {
         default :
             lstr_StoredProcedureName = StaticContext.PKG_BATCH + "chkElabBatch" ;
            break;
       }
       
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER}};

      Vector lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return;
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

    // getListaBatch

  // getElabBatchXLancio
  public Vector getElabBatchXLancio (int pint_OperazioneRichiesta,
                                     String pstr_TipoContratto,
                                     String pstr_CodeAccount,
                                     String pstr_CodeElab,
									 String pstr_CodeGest)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";

    try
    {
    switch (pint_OperazioneRichiesta)
      {
         default :
             lstr_StoredProcedureName = StaticContext.PKG_BATCH + "getElabBatchXLancio" ;
            break;
       }
       
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_TipoContratto},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_CodeAccount},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_CodeElab},
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
									"getElabBatchXLancio",
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
             lstr_StoredProcedureName = StaticContext.PKG_BATCH + "getElabBatchVerifica" ;
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


// getElabBatchVerificaSpeCom
public Vector getElabBatchVerificaSpeCom (int pint_OperazioneRichiesta,
                                            String pstr_CodeTipoContratto,
                                            String pstr_CodeFunz)
    throws CustomException, RemoteException
{
    String lstr_StoredProcedureName = "";

    try
    {
        switch (pint_OperazioneRichiesta)
        {
            default:
                lstr_StoredProcedureName = StaticContext.PKG_BATCH + "getElabBatchVerificaSpeCom" ;
                break;
        }

        String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoContratto},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeFunz}};

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Batch.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getElabBatchVerificaSpeCom",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}

// getCodeParamXAccount
public String getCodeParamXAccount (int pint_OperazioneRichiesta,
                                            String pstr_CodeAccount,
                                            String pstr_CodeFunz)
    throws CustomException, RemoteException
{
    String lstr_StoredProcedureName = "";

    try
    {
        switch (pint_OperazioneRichiesta)
        {
            default:
                lstr_StoredProcedureName = StaticContext.PKG_BATCH + "getCodeParamXAccount" ;
                break;
        }

        String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeAccount},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeFunz}
                  };

        Vector lvct_SPReturn = this.callSP(larr_CallSP);
        String lstr_Return = (String)lvct_SPReturn.get(0);

        return lstr_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getCodeParamXAccount",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}


  // insParamValoriz
  public Integer insParamValoriz(int pint_OperazioneRichiesta,DB_Account pDB_Account )
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {
      switch (pint_OperazioneRichiesta)
      {
         default :
            lstr_StoredProcedureName = StaticContext.PKG_BATCH + "insParamValoriz" ;
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

  // updParamValoriz
  public Integer updParamValoriz(int pint_OperazioneRichiesta, DB_Account pDB_Account )
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {
      switch (pint_OperazioneRichiesta)
      {
         default :
            lstr_StoredProcedureName = StaticContext.PKG_BATCH + "updParamValoriz" ;
            break;
      }

      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Account.getCODE_PARAM()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Account.getCODE_ACCOUNT()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Account.getCODE_ELAB()},
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
									"updParamValoriz",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }
        
  // getElabBatchXRunning
  public Vector getElabBatchRunning (int pint_OperazioneRichiesta,
                               String pstr_CodeRibesAttivo,
                               String pstr_CodeRibesPassivo)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {
      switch (pint_OperazioneRichiesta)
      {
         default :
            lstr_StoredProcedureName = StaticContext.PKG_BATCH + "getElabBatchRunning" ;
            break;
      }

      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeRibesAttivo},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeRibesPassivo},
                   {AbstractEJBTypes.PARAMETER_OUTPUT, AbstractEJBTypes.TYPE_STRING},
                   };

      Vector lvct_SPReturn = this.callSP(larr_CallSP);

      return lvct_SPReturn;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getElabBatchRunning",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }


  // insElabBatch
  public Integer insElabBatch(int pint_OperazioneRichiesta, DB_Batch pDB_Batch )
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {
      switch (pint_OperazioneRichiesta)
      {
         default :
            lstr_StoredProcedureName = StaticContext.PKG_BATCH + "insElabBatch" ;
            break;
      }

      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Batch.getCODE_UTENTE()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Batch.getCODE_STATO_BATCH()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, pDB_Batch.getVALO_NR_PS_ELAB()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Batch.getDATA_ORA_INIZIO_ELAB_BATCH()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Batch.getDATA_ORA_FINE_ELAB_BATCH()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, pDB_Batch.getVALO_PROCESS_ID()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Batch.getCODE_USCITA()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Batch.getCODE_FUNZ()}
                   };

      Vector lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insElabBatch",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

    public Vector getListaBatch(int pint_Funzionalita, 
                                            int pint_OperazioneRichiesta) 
        throws  RemoteException, CustomException {

        String lstr_StoredProcedureName = "";

        try {
            
            switch (pint_Funzionalita) {
                case (StaticContext.FN_PROVISIONING):
                    lstr_StoredProcedureName = StaticContext.PKG_PROVISIONING + "getListaBatchProvisioning" ;
                    break;
            }
            
            String[][] larr_CallSP =
                      {{lstr_StoredProcedureName},
                       {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR}};

            Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_AnagFunz.class);
            Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

            return lvct_Return;
            
        } catch(Exception lexc_Exception) {
                throw new CustomException(lexc_Exception.toString(),
                                                            "",
                                                            "getListaBatch",
                                                            this.getClass().getName(),
                                                            StaticContext.FindExceptionType(lexc_Exception));
        }

    }

    public Vector getElabBatchVerificaProvisioning(int pint_Funzionalita, 
                                                                     int pint_OperazioneRichiesta) 
        throws  RemoteException, CustomException {

        String lstr_StoredProcedureName = "";

        try {
            
            switch (pint_Funzionalita) {
                case (StaticContext.FN_PROVISIONING):
                    lstr_StoredProcedureName = StaticContext.PKG_BATCH + "getVerificaBatchProvisioning" ;
                    break;
            }

            String[][] larr_CallSP =
                      {{lstr_StoredProcedureName},
                       {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR}};

            Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Batch.class);
            Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

            return lvct_Return;
        } catch(Exception lexc_Exception) {
                throw new CustomException(lexc_Exception.toString(),
                                                            "",
                                                            "getElabBatchVerificaProvisioning",
                                                            this.getClass().getName(),
                                                            StaticContext.FindExceptionType(lexc_Exception));
        }
    }

  // chkI5_6SysParamXElabBatch
  public Vector getI5_6SysParamValue(String pstr_ChiaveSysParam)
        throws CustomException, RemoteException {

        String lstr_StoredProcedureName = "";

        try {

            lstr_StoredProcedureName = StaticContext.PKG_BATCH + "getI5_6SysParamValue" ;

            String[][] larr_CallSP =
                      {{lstr_StoredProcedureName},
                       {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                       {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_ChiaveSysParam}};

            Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_I5_6SysParam.class);
            Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

            return lvct_Return;
        }
        catch(Exception lexc_Exception) {
            throw new CustomException(lexc_Exception.toString(),
                                        "",
                                        "getI5_6SysParamValue",
                                        this.getClass().getName(),
                                        StaticContext.FindExceptionType(lexc_Exception));
        }
  }

    // chkStatoElaborazioneBatch
    public Integer chkStatoElaborazioneBatch (int pint_Funzionalita)
        throws CustomException, RemoteException {

        String lstr_StoredProcedureName = "";

        try {
        
            switch (pint_Funzionalita) {
                 case (StaticContext.FN_PROVISIONING) :
                     lstr_StoredProcedureName = StaticContext.PKG_BATCH + "chkElabBatchProvisioning" ;
                    break;
            }

            String[][] larr_CallSP =
                      {{lstr_StoredProcedureName},
                       {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER}};

            Vector lvct_SPReturn = this.callSP(larr_CallSP);
            Integer lint_Return = (Integer)lvct_SPReturn.get(0);

            return lint_Return;
            
        } catch(Exception lexc_Exception) {
            throw new CustomException(lexc_Exception.toString(),
                                                        "",
                                                        "chkStatoElaborazioneBatch",
                                                        this.getClass().getName(),
                                                        StaticContext.FindExceptionType(lexc_Exception));
        }

    }

    // chkElabBatchSpecial
  public Integer chkElabBatchSpecial (int pint_OperazioneRichiesta)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";

    try
    {
    switch (pint_OperazioneRichiesta)
      {
         default :
             lstr_StoredProcedureName = StaticContext.PKG_BATCH + "chkElabBatchSpecial" ;
            break;
       }
       
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER}};

      Vector lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"chkElabBatchSpecial",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }
    
}