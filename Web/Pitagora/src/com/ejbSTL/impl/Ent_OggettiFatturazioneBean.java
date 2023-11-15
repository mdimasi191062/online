package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.util.Vector;
import java.rmi.RemoteException;
import com.utl.*;


public class Ent_OggettiFatturazioneBean extends AbstractClassicEJB implements SessionBean 
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

  // getOggFatturazione
  public Vector getOggFatturazione(int pint_OperazioneRichiesta,
                                    int pint_Funzionalita,
                                    String pstr_CodeTipoContr,
                                    String pstr_CodeGest,
                                    String pstr_CodeContr,
                                    String pstr_CodePS,
                                    String pstr_CodePrestAgg,
                                    String pstr_CodeClasse)
    throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {
        Vector lvct_SPReturn = null;

        switch (pint_Funzionalita)
        {
            case StaticContext.FN_TARIFFA:
            case StaticContext.FN_ASS_TAR_SCO:
                switch (pint_OperazioneRichiesta)
                {
                    case StaticContext.LIST :
                        lstr_StoredProcedureName = StaticContext.PKG_OGGETTIFATTURAZIONE + "getOggFatrzListaTariffe" ;
                        String[][] larr_CallSP1 =
                                {{lstr_StoredProcedureName},
                                 {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePrestAgg},
                                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeContr},
                                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePS}
                                };
                        
                        lvct_SPReturn = this.callSP(larr_CallSP1, DB_OggettoFatturazione.class);
                        break;
                    case StaticContext.INSERT :
                    case StaticContext.DELETE :
                        lstr_StoredProcedureName = StaticContext.PKG_OGGETTIFATTURAZIONE + "getOggFattValidiXPSPA" ;
                        String[][] larr_CallSP2 =
                                {{lstr_StoredProcedureName},
                                 {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePS},
                                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePrestAgg},
                                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeContr},
                                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoContr}
                                };
                        lvct_SPReturn = this.callSP(larr_CallSP2, DB_OggettoFatturazione.class);
                        break;
                }
                break;
            case StaticContext.FN_ASS_OFPS :
                switch (pint_OperazioneRichiesta)
                {
                    case StaticContext.LIST:
                        lstr_StoredProcedureName = StaticContext.PKG_OGGETTIFATTURAZIONE + "getOggFattListaOfPs";
                        String[][] larr_CallSP1 =
                                {{lstr_StoredProcedureName},
                                 {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoContr},
                                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeContr},
                                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeGest},
                                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePS},
                                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePrestAgg}
                                };
                        lvct_SPReturn = this.callSP(larr_CallSP1, DB_OggettoFatturazione.class);
                        break;

                    case StaticContext.INSERT :
                        lstr_StoredProcedureName = StaticContext.PKG_OGGETTIFATTURAZIONE + "getOggFattValidiXClassePS" ;
                        String[][] larr_CallSP2 =
                                {{lstr_StoredProcedureName},
                                 {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeClasse}
                                };
                        lvct_SPReturn = this.callSP(larr_CallSP2, DB_OggettoFatturazione.class);
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
									"getOggFatturazione",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }



  // countOFPSValidiXContratto
  public Integer countOFPSValidiXContratto ( int pint_OperazioneRichiesta,
                                            String pstr_CodeContr,
                                            String pstr_CodePs,
                                            String pstr_CodePrestAgg,
                                            String pstr_CodeOggFatrz)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {      
      Vector lvct_SPReturn=null;
      switch (pint_OperazioneRichiesta)
      {
          default :
          
            lstr_StoredProcedureName = StaticContext.PKG_OGGETTIFATTURAZIONE + "countOFPSValidiXContratto" ;
            break;
          
      }
      String[][] larr_CallSP =
              {{lstr_StoredProcedureName},
               {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeContr},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePs},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePrestAgg},      
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeOggFatrz}};      

      lvct_SPReturn = this.callSP(larr_CallSP, DB_OggettoFatturazione.class);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"countOFPSValidiXContratto",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

  // countOFPSXContratto
  public Integer countOFPSXContratto ( int pint_OperazioneRichiesta,
                                       String pstr_CodeContr,
                                       String pstr_CodePs,
                                       String pstr_CodePrestAgg,
                                       String pstr_CodeOggFatrz)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {
      Vector lvct_SPReturn=null;
      switch (pint_OperazioneRichiesta)
      {
          default :
          
            lstr_StoredProcedureName = StaticContext.PKG_OGGETTIFATTURAZIONE + "countOFPSXContratto" ;
            break;
          
      }
      String[][] larr_CallSP =
              {{lstr_StoredProcedureName},
               {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeContr},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePs},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePrestAgg},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeOggFatrz}};      

      lvct_SPReturn = this.callSP(larr_CallSP, DB_OggettoFatturazione.class);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"countOFPSXContratto",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }





  // getMaxDateXOF
  public String getMaxDateXOF (int pint_OperazioneRichiesta,
                            String pstr_CodeOF)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {      
      Vector lvct_SPReturn=null;
      switch (pint_OperazioneRichiesta)
      {
         default :
          
            lstr_StoredProcedureName = StaticContext.PKG_OGGETTIFATTURAZIONE + "getMaxDateXOF" ;
            break;
          
      }
      String[][] larr_CallSP =
              {{lstr_StoredProcedureName},
               {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeOF}};      

      lvct_SPReturn = this.callSP(larr_CallSP, DB_OggettoFatturazione.class);
      String lstr_Return = (String)lvct_SPReturn.get(0);

      return lstr_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getMaxDateXOF",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

  // getOggFattValidiXOfPsCorneli
  public Vector getOggFattValidiXOfPsCorneli ( int pint_OperazioneRichiesta,
                                               String pstr_CodePS,
                                               String pstr_CodePrestAgg,
                                               String pstr_CodeTipoContr,
                                               String pstr_CodeTipoCausale,
                                               String pstr_CodeOggFatrz)
          throws CustomException, RemoteException
    {
      String lstr_StoredProcedureName = "";
      try
      {      
        Vector lvct_SPReturn=null;
        switch (pint_OperazioneRichiesta)
        {
           default :
          
              lstr_StoredProcedureName = StaticContext.PKG_OGGETTIFATTURAZIONE + "getOggFattValidiXOfPsCorneli" ;
              break;
          
        }
        String[][] larr_CallSP =
                {{lstr_StoredProcedureName},
                 {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePS},
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePrestAgg},
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoContr},
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoCausale},
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeOggFatrz}
                 };      

        lvct_SPReturn = this.callSP(larr_CallSP, DB_OggettoFatturazione.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
      }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getOggFattValidiXOfPsCorneli",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
    }

  // countOFXOggFatrz
  public Integer countOFXOggFatrz ( int pint_OperazioneRichiesta,
                                    String pstr_CodeOF )
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {      
      Vector lvct_SPReturn=null;
      switch (pint_OperazioneRichiesta)
      {
          default :
          
            lstr_StoredProcedureName = StaticContext.PKG_OGGETTIFATTURAZIONE + "countOFXOggFatrz" ;
            break;
          
      }
      String[][] larr_CallSP =
              {{lstr_StoredProcedureName},
               {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeOF}};      

      lvct_SPReturn = this.callSP(larr_CallSP, DB_OggettoFatturazione.class);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"countOFXOggFatrz",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

  // getDataValidaXOF
  public String getDataValidaXOF (int pint_OperazioneRichiesta,
                                  String pstr_CodeOF)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {      
      Vector lvct_SPReturn=null;
      switch (pint_OperazioneRichiesta)
      {
         default :
          
            lstr_StoredProcedureName = StaticContext.PKG_OGGETTIFATTURAZIONE + "getDataValidaXOF" ;
            break;
          
      }
      String[][] larr_CallSP =
              {{lstr_StoredProcedureName},
               {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeOF}};      

      lvct_SPReturn = this.callSP(larr_CallSP, DB_OggettoFatturazione.class);
      String lstr_Return = (String)lvct_SPReturn.get(0);

      return lstr_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getDataValidaXOF",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }
}