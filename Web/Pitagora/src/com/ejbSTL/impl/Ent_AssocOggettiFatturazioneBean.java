package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public class Ent_AssocOggettiFatturazioneBean extends AbstractClassicEJB implements SessionBean 
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


  // countOFPSAperti
  public Integer countOFPSAperti (int pint_OperazioneRichiesta,
                                    String pstr_CodeTipoContr,
                                    String pstr_CodeContr,
                                    String pstr_CodeOggFatrz,
                                    String pstr_CodePrestAgg,
                                    String pstr_CodeTipoCaus,
                                    String pstr_CodePs,
                                    String pstr_AccountDaEliminare)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    { 
      Vector lvct_SPReturn=null;
      switch (pint_OperazioneRichiesta)
      {
        default:
            lstr_StoredProcedureName = StaticContext.PKG_ASSOCOGGETTIFATTURAZIONE + "countOFPSAperti" ;
            break;
      }

      String[][] larr_CallSP =
              {{lstr_StoredProcedureName},
               {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoContr},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeContr},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeOggFatrz},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePrestAgg},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoCaus},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePs},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_AccountDaEliminare}};

      lvct_SPReturn = this.callSP(larr_CallSP, DB_OggettoFatturazione.class);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"countOFPSAperti",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }


  // getMinMaxDateOFPS
  public Vector getMinMaxDateOFPS ( int pint_OperazioneRichiesta,
                                    String pstr_CodeTipoContr,
                                    String pstr_CodeContr,
                                    String pstr_CodeOggFatrz,
                                    String pstr_CodePrestAgg,
                                    String pstr_CodeTipoCaus,
                                    String pstr_CodePs,
                                    String pstr_AccountDaEliminare)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {      
      Vector lvct_SPReturn=null;
      switch (pint_OperazioneRichiesta)
      {
        default:
            lstr_StoredProcedureName = StaticContext.PKG_ASSOCOGGETTIFATTURAZIONE + "getMinMaxDateOFPS" ;
            break;
      }

      String[][] larr_CallSP =
              {{lstr_StoredProcedureName},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoContr},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeContr},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeOggFatrz},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePrestAgg},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoCaus},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePs},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_AccountDaEliminare},
               {AbstractEJBTypes.PARAMETER_OUTPUT, AbstractEJBTypes.TYPE_STRING},
               {AbstractEJBTypes.PARAMETER_OUTPUT, AbstractEJBTypes.TYPE_STRING}
               };      

      lvct_SPReturn = this.callSP(larr_CallSP, DB_OggettoFatturazione.class);

      return lvct_SPReturn;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getMinMaxDateOFPS",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }


  // countOFPSGiaPresenti
  public Integer countOFPSGiaPresenti (int pint_OperazioneRichiesta,
                                String pstr_CodeTipoContr,
                                String pstr_CodeContr,
                                String pstr_CodeOggFatrz,
                                String pstr_CodePrestAgg,
                                String pstr_CodeTipoCaus,
                                String pstr_CodePs,
                                String pstr_AccountDaEliminare)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    { 
      Vector lvct_SPReturn=null;
      switch (pint_OperazioneRichiesta)
      {
          default :
          
            lstr_StoredProcedureName = StaticContext.PKG_ASSOCOGGETTIFATTURAZIONE + "countOFPSGiaPresenti" ;
            break;
          
      }
      String[][] larr_CallSP =
              {{lstr_StoredProcedureName},
               {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoContr},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeContr},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeOggFatrz},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePrestAgg},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoCaus},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePs},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_AccountDaEliminare}};

      lvct_SPReturn = this.callSP(larr_CallSP, DB_OggettoFatturazione.class);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"countOFPSGiaPresenti",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }


  // chkPreDisattivazioneAssociazione  
  public Integer chkPreDisattivazioneAssociazione(int pint_OperazioneRichiesta,
                                                  DB_OggettoFatturazione pDB_OggettoFatturazione)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {
      Vector lvct_SPReturn = null;
      switch (pint_OperazioneRichiesta)
      {
          default :
            lstr_StoredProcedureName = StaticContext.PKG_ASSOCOGGETTIFATTURAZIONE + "chkPreDisAssoc" ;
            break;
      }

      String[][] larr_CallSP =
              {{lstr_StoredProcedureName},
               {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_OggettoFatturazione.getCODE_PR_PS_PA_CONTR()},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_OggettoFatturazione.getCODE_OGG_FATRZ()},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_OggettoFatturazione.getDATA_INIZIO_VALID_OF_PS()},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_OggettoFatturazione.getCODE_TIPO_CAUS()}
               };      

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"chkPreDisattivazioneAssociazione",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }


  // chkPostDisattivazioneAssociazione
  public Integer chkPostDisattivazioneAssociazione (int pint_OperazioneRichiesta,
                                                    DB_OggettoFatturazione pDB_OggettoFatturazione)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {
      Vector lvct_SPReturn = null;
      switch (pint_OperazioneRichiesta)
      {
         default :
            lstr_StoredProcedureName = StaticContext.PKG_ASSOCOGGETTIFATTURAZIONE + "chkPostDisAssoc" ;
            break;
      }

      String[][] larr_CallSP =
              {{lstr_StoredProcedureName},
               {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_OggettoFatturazione.getCODE_TIPO_CONTR()},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_OggettoFatturazione.getCODE_CONTR()},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_OggettoFatturazione.getCODE_OGG_FATRZ()},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_OggettoFatturazione.getCODE_PREST_AGG()},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_OggettoFatturazione.getCODE_TIPO_CAUS()},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_OggettoFatturazione.getCODE_PS()},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_OggettoFatturazione.getDATA_INIZIO_VALID()},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_OggettoFatturazione.getDATA_FINE_VALID()}
               };      

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"chkPostDisattivazioneAssociazione",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }


  // getAssocOggFatturazione
  public Vector getAssocOggFatturazione(int pint_OperazioneRichiesta,
                                          int pint_Funzionalita,
                                          String pstr_CodeTipoContr,
                                          String pstr_CodeGest,
                                          String pstr_CodeContr,
                                          String pstr_CodePS,
                                          String pstr_CodePrestAgg,
                                          String pstr_CodeTipoCaus,
                                          String pstr_CodeOggFatrz,
                                          boolean pbln_AssociazioniDisattive,
					  String pstr_CodeAccountDaEliminare)
    throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {
        Vector lvct_SPReturn = null;

        switch (pint_Funzionalita)
        {
          default:
                switch (pint_OperazioneRichiesta)
                {
                    default:
                        if (pbln_AssociazioniDisattive == false)
                        {
                            lstr_StoredProcedureName = StaticContext.PKG_ASSOCOGGETTIFATTURAZIONE + "getAssocValidiOfPs";
                            String[][] larr_CallSP1 =
                                    {{lstr_StoredProcedureName},
                                     {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoContr},
                                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeContr},
                                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeGest},
                                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePS},
                                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePrestAgg},
                                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoCaus},
                                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeOggFatrz},
                                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeAccountDaEliminare}
                                    };
                            lvct_SPReturn = this.callSP(larr_CallSP1, DB_OggettoFatturazione.class);
                        }
                        else
                        {
                            lstr_StoredProcedureName = StaticContext.PKG_ASSOCOGGETTIFATTURAZIONE + "getAssoOfPs";
                            String[][] larr_CallSP2 =
                                  {{lstr_StoredProcedureName},
                                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoContr},
                                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeContr},
                                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeGest},
                                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePS},
                                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePrestAgg},
                                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoCaus},
                                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeOggFatrz}
                                  };
                            lvct_SPReturn = this.callSP(larr_CallSP2, DB_OggettoFatturazione.class);
                        }
                        break;
                }
                break;
        }

        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);  
        return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getAssocOggFatturazione",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }


  // insAssociazioneOfPs
  public Integer insAssociazioneOfPs (int pint_OperazioneRichiesta,
                                      DB_OggettoFatturazione pDB_OggettoFatturazione)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {
      Vector lvct_SPReturn = null;
      switch (pint_OperazioneRichiesta)
      {
          default :
            lstr_StoredProcedureName = StaticContext.PKG_ASSOCOGGETTIFATTURAZIONE + "insAssocOfPs" ;
            break;
      }

      String[][] larr_CallSP =
              {{lstr_StoredProcedureName},
               {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_OggettoFatturazione.getCODE_PR_PS_PA_CONTR()},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_OggettoFatturazione.getCODE_OGG_FATRZ()},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_OggettoFatturazione.getCODE_TIPO_CAUS()},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_OggettoFatturazione.getDATA_INIZIO_VALID_OF_PS()},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_OggettoFatturazione.getDATA_INIZIO_VALID_OF()},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_OggettoFatturazione.getDATA_FINE_VALID_OF_PS()},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_OggettoFatturazione.getCODE_MODAL_APPL()},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_OggettoFatturazione.getCODE_FREQ_APPL()},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_OggettoFatturazione.getCODE_UTENTE()},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_DOUBLE, pDB_OggettoFatturazione.getQNTA_SHIFT_CANONI()},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_OggettoFatturazione.getTIPO_FLAG_ANTTO_POSTTO()}
               };      

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insAssociazioneOfPs",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

  // updAssociazioneOfPs
  public Integer updAssociazioneOfPs (int pint_OperazioneRichiesta,
                                      DB_OggettoFatturazione pDB_OggettoFatturazione)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {
      Vector lvct_SPReturn = null;
      switch (pint_OperazioneRichiesta)
      {
          default :
            lstr_StoredProcedureName = StaticContext.PKG_ASSOCOGGETTIFATTURAZIONE + "updAssocOfPs" ;
            break;
      }

      String[][] larr_CallSP =
              {{lstr_StoredProcedureName},
               {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_OggettoFatturazione.getCODE_PR_PS_PA_CONTR()},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_OggettoFatturazione.getCODE_OGG_FATRZ()},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_OggettoFatturazione.getDATA_INIZIO_VALID_OF_PS()},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_OggettoFatturazione.getCODE_TIPO_CAUS()},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_OggettoFatturazione.getDATA_INIZIO_VALID_OF()},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_OggettoFatturazione.getDATA_FINE_VALID_OF_PS()}
               };      

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"updAssociazioneOfPs",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

  // getMinDataValidaOFPS
  public String getMinDataValidaOFPS ( int pint_OperazioneRichiesta,
                                       String pstr_CodeTipoContr,
                                       String pstr_CodeContr,
                                       String pstr_CodeOggFatrz,
                                       String pstr_CodePrestAgg,
                                       String pstr_CodeTipoCaus,
                                       String pstr_CodePs)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {      
      Vector lvct_SPReturn=null;
      switch (pint_OperazioneRichiesta)
      {
        default:
            lstr_StoredProcedureName = StaticContext.PKG_ASSOCOGGETTIFATTURAZIONE + "getMinDataValidaOFPS" ;
            break;
      }

      String[][] larr_CallSP =
              {{lstr_StoredProcedureName},
               {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoContr},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeContr},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeOggFatrz},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePrestAgg},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoCaus},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePs}};      

      lvct_SPReturn = this.callSP(larr_CallSP);
      String lstr_SPReturn = (String)lvct_SPReturn.get(0);

      return lstr_SPReturn;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getMinDataValidaOFPS",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

  // getCampiInsOFPS
  public Vector getCampiInsOFPS (int pint_OperazioneRichiesta,                          
                                 String pstr_CodeTipoContr,
                                 String pstr_CodeContr,
                                 String pstr_CodePrestAgg,
                                 String pstr_CodePs,
                                 String pstr_AccountDaEliminare)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {      
      Vector lvct_SPReturn = null;
      switch (pint_OperazioneRichiesta)
      {
         default :
          
            lstr_StoredProcedureName = StaticContext.PKG_ASSOCOGGETTIFATTURAZIONE + "getCampiInsOFPS" ;
            break;
          
      }
      String[][] larr_CallSP =
              {{lstr_StoredProcedureName},
               {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoContr},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeContr},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePrestAgg},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePs},      
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_AccountDaEliminare}};

      lvct_SPReturn = this.callSP(larr_CallSP, DB_OggettoFatturazione.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getCampiInsOFPS",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

}