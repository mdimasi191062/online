package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.rmi.RemoteException;
import com.utl.*;
import java.util.Vector;

public class Ent_TariffeScontiBean extends AbstractClassicEJB implements SessionBean 
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

  public Integer delTariffeSconti(int pint_OperazioneRichiesta,
                                  String pstr_CodeTariffa,
                                  String pstr_CodePrTariffa)
  throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";

    try
    {
    switch (pint_OperazioneRichiesta)
      {
          case StaticContext.LIST :
          case StaticContext.INSERT :
          case StaticContext.DELETE :
            lstr_StoredProcedureName = StaticContext.PKG_TARIFFESCONTI + "delTariffeSconti" ;
            break;
       }
       
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTariffa},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePrTariffa}};


      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_TariffeSconti.class);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"delTariffeSconti",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }


 public Integer chkTariffeSconti(int pint_OperazioneRichiesta,
                                  String pstr_CodeTariffa,
                                  String pstr_CodePrTariffa)
  throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";

    try
    {
    switch (pint_OperazioneRichiesta)
      {
          default:
            lstr_StoredProcedureName = StaticContext.PKG_TARIFFESCONTI + "chkTariffeSconti" ;
            break;
       }
       
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTariffa},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePrTariffa}};


      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_TariffeSconti.class);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"chkTariffeSconti",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

  public Integer updTariffeSconti(int pint_OperazioneRichiesta,
                                 String pstr_CodeTariffa,
                                 String pstr_CodePrTariffa,
                                 String pstr_CodePrTariffaOld)
  throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";

    try
    {
    switch (pint_OperazioneRichiesta)
      {
        default :

            lstr_StoredProcedureName = StaticContext.PKG_TARIFFESCONTI + "updTariffeSconti" ;
            break;
       }
       
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTariffa},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePrTariffa},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePrTariffaOld}};


      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_TariffeSconti.class);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"updTariffeSconti",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

  // delTariffeScontiTipoContr 
  public Integer delTariffeScontiTipoContr (int pint_OperazioneRichiesta,
                                             DB_Tariffe pDB_Tariffe)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";

    try
    {
       switch (pint_OperazioneRichiesta)
       {
          default :
            lstr_StoredProcedureName = StaticContext.PKG_TARIFFESCONTI + "delTariffeScontiTipoContr" ;
            break;
       }
       
      String[][] larr_CallSP =
                {{lstr_StoredProcedureName},
                 {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_PS()}, 
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_PREST_AGG()},
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_TIPO_CONTR()},
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_OGG_FATRZ()},
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_TIPO_CAUS()},
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getTIPO_FLAG_MODAL_APPL_TARIFFA()},
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_FASCIA()},
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_CLAS_SCONTO()},
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_TIPO_OFF()}
                };         

      Vector lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"delTariffeScontiTipoContr",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

  // getDettaglioTariffaSconto
  public Vector getDettaglioTariffaSconto( int pint_OperazioneRichiesta,
                                            int pint_Funzionalita,
                                            String pstr_CODE_TARIFFA,
                                            String pstr_CODE_PR_TARIFFA,
                                            String pstr_CODE_SCONTO,
                                            String pstr_DATA_INIZIO_VALID)
                              throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    Vector lvct_Return = null;

    try
    {
      Vector lvct_SPReturn = null;
      switch (pint_Funzionalita)
      {
        case StaticContext.FN_ASS_TAR_SCO :
        switch (pint_OperazioneRichiesta)
          {
            case StaticContext.LIST:
              lstr_StoredProcedureName = StaticContext.PKG_TARIFFESCONTI + "getDettaglioTariffaSconto" ;

              String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CODE_TARIFFA},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CODE_PR_TARIFFA},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CODE_SCONTO},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_DATA_INIZIO_VALID}};
                  lvct_SPReturn = this.callSP(larr_CallSP, DB_TariffeSconti.class);
                  lvct_Return = (Vector)lvct_SPReturn.get(0);
            break;
         }
       break;
      }
     return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		 throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getDettaglioTariffaSconto",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

// getTariffeSconti
  public Vector getTariffeSconti( int pint_OperazioneRichiesta,
                                  int pint_Funzionalita,
                                  String pstr_CodeGest,
                                  String pstr_CodeContr,
                                  String pstr_CodeTipoContr,
                                  String pstr_FlagFiltro)
                    throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    Vector lvct_Return = null;

    try
    {
      Vector lvct_SPReturn = null;
      switch (pint_Funzionalita)
      {
        case StaticContext.FN_ASS_TAR_SCO :
        switch (pint_OperazioneRichiesta)
          {
            case StaticContext.LIST:
              lstr_StoredProcedureName = StaticContext.PKG_TARIFFESCONTI + "getTariffeSconti" ;

              String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoContr},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeContr},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeGest},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, pstr_FlagFiltro}};
                  lvct_SPReturn = this.callSP(larr_CallSP, DB_TariffeSconti.class);
                  lvct_Return = (Vector)lvct_SPReturn.get(0);
            break;
         }
       break;
      }
     return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getTariffeSconti",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }


  public Vector getTariffeSconti
      (int pint_operazioneRichiesta
      ,int pint_funzionalita
      ,String pstr_codeTariffa
      ,String pstr_codeSconto)
      throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    Vector lvct_Return = null;

    try
    {
      Vector lvct_SPReturn = null;
      switch (pint_funzionalita)
      {
        default:
          switch (pint_operazioneRichiesta)
          {
            default:
              lstr_StoredProcedureName = StaticContext.PKG_TARIFFESCONTI + "getTariffeScontiXCodeTariffa";

              String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_codeTariffa},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_codeSconto}};
                  lvct_SPReturn = this.callSP(larr_CallSP, DB_TariffeSconti.class);
              break;
          }
          break;
      }

      lvct_Return = (Vector)lvct_SPReturn.get(0);
      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
      throw new CustomException(lexc_Exception.toString()
                ,""
                ,"getTariffeSconti"
                ,this.getClass().getName()
                ,StaticContext.FindExceptionType(lexc_Exception));
    }
  }



  public int insert
      (String pstr_codeTariffa
      ,String pstr_codePrTariffa
      ,String pstr_codeSconto
      ,String pstr_dataInizioValid)
      throws CustomException, RemoteException
  {
    Integer lint_return = new Integer(0);

    try
    {
      Vector lvct_SPReturn = null;
      String lstr_StoredProcedureName = StaticContext.PKG_TARIFFESCONTI + "insTariffeSconti";

      String[][] larr_CallSP =
          {{lstr_StoredProcedureName},
           {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER}
           ,{AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_codeTariffa}
           ,{AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_codePrTariffa}
           ,{AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_codeSconto}
           ,{AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_dataInizioValid}
          };
      lvct_SPReturn = this.callSP(larr_CallSP);
      lint_return = (Integer)lvct_SPReturn.get(0);

      return (lint_return.intValue());
    }
    catch(Exception lexc_Exception)
    {
      throw new CustomException(lexc_Exception.toString()
                ,""
                ,"insert("
                    + pstr_codeTariffa
                    + "," + pstr_codePrTariffa
                    + "," + pstr_codeSconto
                    + "," + pstr_dataInizioValid
                    + ")"
                ,this.getClass().getName()
                ,StaticContext.FindExceptionType(lexc_Exception));
    }
  }


  public int update
      (String pstr_codeTariffa
      ,String pstr_codePrTariffa
      ,String pstr_codeSconto
      ,String pstr_dataInizioValid
      ,String pstr_dataFineValid)
      throws CustomException, RemoteException
  {
    Integer lint_return = new Integer(0);

    try
    {
      Vector lvct_SPReturn = null;
      String lstr_StoredProcedureName = StaticContext.PKG_TARIFFESCONTI + "updTariffaSconto";

      String[][] larr_CallSP =
          {{lstr_StoredProcedureName},
           {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER}
           ,{AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_codeTariffa}
           ,{AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_codePrTariffa}
           ,{AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_codeSconto}
           ,{AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_dataInizioValid}
           ,{AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_dataFineValid}
          };
      lvct_SPReturn = this.callSP(larr_CallSP);
      lint_return = (Integer)lvct_SPReturn.get(0);

      return (lint_return.intValue());
    }
    catch(Exception lexc_Exception)
    {
      throw new CustomException(lexc_Exception.toString()
                ,""
                ,"update("
                    + pstr_codeTariffa
                    + "," + pstr_codePrTariffa
                    + "," + pstr_codeSconto
                    + "," + pstr_dataInizioValid
                    + "," + pstr_dataFineValid
                    + ")"
                ,this.getClass().getName()
                ,StaticContext.FindExceptionType(lexc_Exception));
    }
  }


}
