package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.rmi.RemoteException;
import com.utl.*;
import java.util.Vector;


public class Ent_ProdottiServiziBean extends AbstractClassicEJB implements SessionBean 
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

  // getProdottiServizi 
  public Vector getProdottiServizi(int pint_OperazioneRichiesta,
                                   int pint_Funzionalita,
                                   String pstr_CodeGest,
                                   String pstr_CodeContr,
                                   String pstr_CodeTipoContr,
                                   String pstr_CodePs)
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
                      lstr_StoredProcedureName = StaticContext.PKG_PRODOTTISERVIZI + "getPSTariffe" ;
                       String[][] larr_CallSP0={{lstr_StoredProcedureName},
                                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoContr},
                                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeGest},
                                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeContr},
                                  };
                      lvct_SPReturn = this.callSP(larr_CallSP0, DB_ProdottiServizi.class);
                      break;
                    case StaticContext.INSERT :
                    case StaticContext.DELETE :
                      lstr_StoredProcedureName = StaticContext.PKG_PRODOTTISERVIZI + "getPSValidiTariffe" ;
                      String[][] larr_CallSP1={{lstr_StoredProcedureName},
                                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoContr},
                                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeGest},
                                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeContr},
                                  };
                      lvct_SPReturn = this.callSP(larr_CallSP1, DB_ProdottiServizi.class);
                      break;
                }
                break;
        case StaticContext.FN_ASS_OFPS :
                switch (pint_OperazioneRichiesta)
                {
                    default :
                      lstr_StoredProcedureName = StaticContext.PKG_PRODOTTISERVIZI + "getPSValidiOFPS" ;
                      String[][] larr_CallSP2={{lstr_StoredProcedureName},
                                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoContr},
                                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeGest},
                                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeContr},
                                  };
                      lvct_SPReturn = this.callSP(larr_CallSP2, DB_ProdottiServizi.class);
                      break;
                }
                break;
        case StaticContext.FN_TARIFFA_CDN:
                 switch (pint_OperazioneRichiesta)
                {
                    default :
                      lstr_StoredProcedureName = StaticContext.PKG_PRODOTTISERVIZI + "getPSRifValidi" ;
                      String[][] larr_CallSP3={{lstr_StoredProcedureName},
                                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoContr},
                                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeGest},
                                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeContr},
                                  };
                      lvct_SPReturn = this.callSP(larr_CallSP3, DB_ProdottiServizi.class);
                      break;
                }
                break;
        case StaticContext.FN_TARIFFA_PS_FIGLI_CDN:
                 switch (pint_OperazioneRichiesta)
                {
                    default :
                      lstr_StoredProcedureName = StaticContext.PKG_PRODOTTISERVIZI + "getPSCompFatt" ;
                      String[][] larr_CallSP4={{lstr_StoredProcedureName},
                                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePs}};
                      lvct_SPReturn = this.callSP(larr_CallSP4, DB_ProdottiServizi.class);
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
									"getProdottiServizi",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

  // countPSXContratto
  public Integer countPSXContratto(int pint_OperazioneRichiesta,
                                   String pstr_CodeContr,
                                   String pstr_CodePs,
                                   String pstr_CodePrestAgg)
   throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {
      switch (pint_OperazioneRichiesta)
      {
        default :
         lstr_StoredProcedureName = StaticContext.PKG_PRODOTTISERVIZI + "countPSXContratto" ;
         break;            
      }
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeContr},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePs},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePrestAgg}};

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_ProdottiServizi.class);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"countPSXContratto",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

  // countIntersectPSXContratto
  public Integer countIntersectPSXContratto(int pint_OperazioneRichiesta,
                                            String pstr_CodeContrOri,
                                            String pstr_CodeContrDest)
   throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {
      switch (pint_OperazioneRichiesta)
      {
          default :
            lstr_StoredProcedureName = StaticContext.PKG_PRODOTTISERVIZI + "countIntersectPSXContratto" ;
          break;            
      }
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeContrOri},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeContrDest}};

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_ProdottiServizi.class);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"countIntersectPSXContratto",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

  // getCodePSPadreGenerale
  public String getCodePSPadreGenerale (int pint_OperazioneRichiesta,
                                        String pstr_CodePS)
  throws CustomException, RemoteException 
  {
    String lstr_StoredProcedureName = "";
    try
    {      
      Vector lvct_SPReturn=null;
      switch (pint_OperazioneRichiesta)
      {
          default :
            lstr_StoredProcedureName = StaticContext.PKG_PRODOTTISERVIZI + "getCodePSPadreGenerale" ;
            break;
          
      }
      String[][] larr_CallSP =
              {{lstr_StoredProcedureName},
               {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePS}};      

      lvct_SPReturn = this.callSP(larr_CallSP, DB_ProdottiServizi.class);
      String lstr_Return = (String)lvct_SPReturn.get(0);

      return lstr_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
  								"",
									"getCodePSPadreGenerale",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
  	}
  }

   // getMaxDateXPs
  public String getMaxDateXPs (int pint_OperazioneRichiesta,
                                String pstr_CodePS)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {      
      Vector lvct_SPReturn=null;
      switch (pint_OperazioneRichiesta)
      {
          default :
            lstr_StoredProcedureName = StaticContext.PKG_PRODOTTISERVIZI + "getMaxDateXPs" ;
            break;
          
      }
      String[][] larr_CallSP =
              {{lstr_StoredProcedureName},
               {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePS}};      

      lvct_SPReturn = this.callSP(larr_CallSP, DB_ProdottiServizi.class);
      String lstr_Return = (String)lvct_SPReturn.get(0);

      return lstr_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getMaxDateXPs",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

   // getPsCompFatt
   public Vector getPsCompFatt (int pint_OperazioneRichiesta,
                                    String pstr_CodePs)
   throws CustomException, RemoteException
   {
    String lstr_StoredProcedureName = "";
    try
    {
      switch (pint_OperazioneRichiesta)
      {
          default :
            lstr_StoredProcedureName = StaticContext.PKG_PRODOTTISERVIZI + "getPsCompFatt" ;
          break;            
      }
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePs}};

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_ProdottiServizi.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getPsCompFatt",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }  


   // getPSRifValidi
   public Vector getPSRifValidi (int pint_OperazioneRichiesta,
                                 String pstr_CodeTipoContr,
                                 String pstr_CodeGest,
                                 String pstr_CodeContr)
   throws CustomException, RemoteException
   {
    String lstr_StoredProcedureName = "";
    try
    {
      switch (pint_OperazioneRichiesta)
      {
          default :
            lstr_StoredProcedureName = StaticContext.PKG_PRODOTTISERVIZI + "getPSRifValidi" ;
          break;            
      }
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoContr},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeGest},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeContr}};

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_ProdottiServizi.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getPSRifValidi",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }  
   // getPS
   public Vector getPS (int pint_OperazioneRichiesta,
                        String pstr_CodePS)
   throws CustomException, RemoteException
   {
    String lstr_StoredProcedureName = "";
    try
    {
      switch (pint_OperazioneRichiesta)
      {
          default :
            lstr_StoredProcedureName = StaticContext.PKG_PRODOTTISERVIZI + "getPS" ;
          break;            
      }
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePS}};

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_ProdottiServizi.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getPS",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }  
}
