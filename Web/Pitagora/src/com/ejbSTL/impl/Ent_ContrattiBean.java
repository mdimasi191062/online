package com.ejbSTL.impl;

import java.sql.CallableStatement;

import java.sql.ResultSet;

import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.rmi.RemoteException;
import com.utl.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import java.util.Vector;
/* Martino Marangi 23/02/2004 */
import java.util.*;

import oracle.jdbc.OracleTypes;

public class Ent_ContrattiBean extends AbstractClassicEJB implements SessionBean 
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

  // getContratti
  public Vector getContratti(int pint_OperazioneRichiesta,
                             int pint_Funzionalita,
                             String pstr_CodeGest,
                             String pstr_TipoContratto) 
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";

    try
    {
        switch (pint_Funzionalita)
        {
            default:
                switch (pint_OperazioneRichiesta)
                {
                    default:
                        lstr_StoredProcedureName = StaticContext.PKG_CONTRATTI + "getContrattiValidi" ;
                        break;
                }
                break;
        }

        String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeGest},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_TipoContratto}};

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Contratto.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

/*Martino Marangi 23/02/2004 formattazione appropriata della stringa gestione del caso in cui all'interno
 * della stringa ci sia il carattere " da anomalia di esericizio */
        for(Enumeration e = lvct_Return.elements();e.hasMoreElements();)
        {
            DB_Contratto myelement=new DB_Contratto();
            myelement=(DB_Contratto)e.nextElement();

            String strDescContrPart = myelement.getDESC_CONTR();
            String strDescContr = "";

            for (int i = 0 ; i<strDescContrPart.length(); i++ )   {

               if ('\"' == strDescContrPart.charAt(i) ) {

                 strDescContr += "\\";
                 strDescContr += "\"";
               }
               else
               {
                 strDescContr +=strDescContrPart.charAt(i);
               }

           }
           myelement.setDESC_CONTR(strDescContr);
      }
/*Martino Marangi 23/02/2004 FINE*/ 
        return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getContratti",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }


  // getMaxDateXContratto
  public String getMaxDateXContratto (int pint_OperazioneRichiesta,
                                      String pstr_CodeContr)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {      
      Vector lvct_SPReturn=null;
      switch (pint_OperazioneRichiesta)
      {
          default :          
            lstr_StoredProcedureName = StaticContext.PKG_CONTRATTI + "getMaxDateXContratto" ;
            break;          
      }
      String[][] larr_CallSP =
              {{lstr_StoredProcedureName},
               {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeContr}};      

      lvct_SPReturn = this.callSP(larr_CallSP, DB_Contratto.class);
      String lstr_Return = (String)lvct_SPReturn.get(0);

      return lstr_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getMaxDateXContratto",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }


// getAccountEsistenti
public Vector getAccountEsistenti (DB_Tariffe pDB_Tariffe)
    throws CustomException, RemoteException
{
    String lstr_StoredProcedureName = StaticContext.PKG_CONTRATTI + "getAccountEsistenti";

    try
    {

        System.out.println("tracciatura parametri - inizio");
        System.out.println("pDB_Tariffe.getCODE_TIPO_CONTR() : " + pDB_Tariffe.getCODE_TIPO_CONTR());
        System.out.println("pDB_Tariffe.getCODE_OGG_FATRZ() : " + pDB_Tariffe.getCODE_OGG_FATRZ());
        System.out.println("pDB_Tariffe.getCODE_PREST_AGG() : " + pDB_Tariffe.getCODE_PREST_AGG());
        System.out.println("pDB_Tariffe.getCODE_TIPO_CAUS() : " + pDB_Tariffe.getCODE_TIPO_CAUS());
        System.out.println("pDB_Tariffe.getCODE_PS() : " + pDB_Tariffe.getCODE_PS());
        System.out.println("pDB_Tariffe.getCODE_TIPO_OFF() : " + pDB_Tariffe.getCODE_TIPO_OFF());
        System.out.println("tracciatura parametri - fine");

        String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_TIPO_CONTR()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_OGG_FATRZ()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_PREST_AGG()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_TIPO_CAUS()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_PS()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_TIPO_OFF()}};

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Account.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
	throw new CustomException(lexc_Exception.toString(),
	  		"",
			"getAccountEsistenti",
			this.getClass().getName(),
			StaticContext.FindExceptionType(lexc_Exception));
    }
}

// getAccountEsistentiOfPs
public Vector getAccountEsistentiOfPs (DB_OggettoFatturazione pDB_OggFatt)
    throws CustomException, RemoteException
{
    String lstr_StoredProcedureName = StaticContext.PKG_CONTRATTI + "getAccountEsistentiOfPs";

    try
    {
        String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_OggFatt.getCODE_TIPO_CONTR()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_OggFatt.getCODE_OGG_FATRZ()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_OggFatt.getCODE_PREST_AGG()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_OggFatt.getCODE_TIPO_CAUS()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_OggFatt.getCODE_PS()}};

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Account.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
	throw new CustomException(lexc_Exception.toString(),
	  		"",
			"getAccountEsistentiOfPs",
			this.getClass().getName(),
			StaticContext.FindExceptionType(lexc_Exception));
    }
}


// getAccountVerificaSpeCom
public Vector getAccountVerificaSpeCom (int pint_OperazioneRichiesta,
                                            String pstr_CodeTipoContratto,
                                            String pstr_CodeElab)
    throws CustomException, RemoteException
{
    String lstr_StoredProcedureName = "";

    try
    {
        switch (pint_OperazioneRichiesta)
        {
            default:
                lstr_StoredProcedureName = StaticContext.PKG_CONTRATTI + "getAccountXVerSpeCom" ;
                break;
        }

        String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoContratto},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeElab}};

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Account.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getAccountVerificaSpeCom",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}


  // getAccountNDC 
  public Vector getAccountNDC (int pint_OperazioneRichiesta,
                                String pstr_TipoContratto,
                                String pstr_CodeFunzVal,
                                String pstr_CodeFunzNdc)
        throws CustomException, RemoteException
  {
   String lstr_StoredProcedureName = "";

    try
    {
      switch (pint_OperazioneRichiesta)
      {
          default:
            lstr_StoredProcedureName = StaticContext.PKG_CONTRATTI + "getAccountNDC" ;
            break;
       }
       
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_TipoContratto},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_CodeFunzVal},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_CodeFunzNdc}
                   };                   

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Account.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getAccountNDC",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

 // getAccountAnomali
  public Vector getAccountAnomali (int pint_OperazioneRichiesta,
                                   String pstr_TipoContratto,
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
            lstr_StoredProcedureName = StaticContext.PKG_CONTRATTI + "getAccountAnomali" ;
            break;
       }
       
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_TipoContratto},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeAccount},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeFunz}
                   };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Account.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getAccountAnomali",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }


 // getAccountStatoProvvisorio
  public Vector getAccountStatoProvvisorio (int pint_OperazioneRichiesta,
                                            String pstr_CodeAccount,
											String pstr_CodeGest,
                                            String pstr_TipoContratto,
                                            String pstr_CodeFunz)
        throws CustomException, RemoteException
  {
   String lstr_StoredProcedureName = "";

    try
    {
      switch (pint_OperazioneRichiesta)
      {
          default:
            lstr_StoredProcedureName = StaticContext.PKG_CONTRATTI + "getAccountStatoProvvisorio" ;
            break;
       }
       
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_TipoContratto},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_CodeFunz},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_CodeAccount},
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
									"getAccountStatoProvvisorio",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

  // getAccountXCodeElab
  public Vector getAccountXCodeElab ( int pint_OperazioneRichiesta,
                                      String pstr_CodeElab,
                                      String pstr_TipoContratto,
                                      String pstr_TipoFlagErrBloc)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {
        switch (pint_OperazioneRichiesta)
        {
            default :
                lstr_StoredProcedureName = StaticContext.PKG_CONTRATTI + "getAccountXCodeElab" ;
                break;
        }

        String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_CodeElab},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_TipoContratto},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_TipoFlagErrBloc}
                   };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Account.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getAccountXCodeElab",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }


// getAccountSpeComAcqImp
public Vector getAccountSpeComAcqImp (int pint_OperazioneRichiesta,
                                            String pstr_CodeTipoContratto,
                                            String pstr_CodeGest,
											String pstr_Mode)
    throws CustomException, RemoteException
{
    String lstr_StoredProcedureName = "";

    try
    {
        switch (pint_OperazioneRichiesta)
        {
            default :
                lstr_StoredProcedureName = StaticContext.PKG_CONTRATTI + "getAccountSpeComAcqImp" ;
                break;
        }

        String[][] larr_CallSP =
                    {{lstr_StoredProcedureName},
                     {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoContratto},
                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeGest},
                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, pstr_Mode},
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Account.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getAccountSpeComAcqImp",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}


// getAccountSpeComCalPar
public Vector getAccountSpeComCalPar (int pint_OperazioneRichiesta,
                                            String pstr_CodeTipoContratto,
                                            String pstr_CodeGest)
    throws CustomException, RemoteException
{
    String lstr_StoredProcedureName = "";

    try
    {
        switch (pint_OperazioneRichiesta)
        {
            default :
                lstr_StoredProcedureName = StaticContext.PKG_CONTRATTI + "getAccountSpeComCalPar" ;
                break;
        }

        String[][] larr_CallSP =
                    {{lstr_StoredProcedureName},
                     {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoContratto},
                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeGest},
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Account.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getAccountSpeComCalPar",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}


  // getAccountSpeComNoCong
  public Vector getAccountSpeComNoCong ( int pint_OperazioneRichiesta,
                                      String pstr_TipoContratto,
                                      String pstr_CodeAccount)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {
        switch (pint_OperazioneRichiesta)
        {
            default :
                lstr_StoredProcedureName = StaticContext.PKG_CONTRATTI + "getAccountSpeComNoCong" ;
                break;
        }

        String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_TipoContratto},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_CodeAccount}
                   };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Account.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getAccountSpeComNoCong",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

  // getAccountSpeCom
  public Vector getAccountSpeCom (int pint_OperazioneRichiesta,
                                    String pstr_CodeTipoContratto,
                                    String pstr_PeriodoRiferimento,
                                    String pstr_PeriodoDataIns)
    throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";

    try
    {
        switch (pint_OperazioneRichiesta)
        {
            default:
                lstr_StoredProcedureName = StaticContext.PKG_CONTRATTI + "getAccountSpeCom" ;
                break;
        }

        String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoContratto},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_PeriodoRiferimento},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_PeriodoDataIns}};

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Account.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getAccountSpeCom",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }


  // getAccountRepricing
  public Vector getAccountRepricing (int pint_OperazioneRichiesta,
                              String pstr_TipoContratto,
                              String pstr_ValorizAttiva,
                              String pstr_ValorizPassiva)
        throws CustomException, RemoteException
  {
   String lstr_StoredProcedureName = "";

    try
    {
      switch (pint_OperazioneRichiesta)
      {
          default:
            lstr_StoredProcedureName = StaticContext.PKG_CONTRATTI + "getAccountRepricing" ;
            break;
       }
       
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_TipoContratto},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_ValorizAttiva},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_ValorizPassiva}
                   };                   

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Account.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getAccountRepricing",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

  // getAccountValAttiva
  public Vector getAccountXParamVal(int pint_OperazioneRichiesta)
       throws CustomException, RemoteException
  {
   String lstr_StoredProcedureName = "";

    try
    {
      switch (pint_OperazioneRichiesta)
      {
          default:
            lstr_StoredProcedureName = StaticContext.PKG_CONTRATTI + "getAccountXParamVal" ;
            break;
       }
       
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Account.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getAccountXParamVal",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

  // getAccountValAttiva
  public Vector getAccountValAttiva (int pint_OperazioneRichiesta,
                         String pstr_TipoContratto,
                         String pstr_CicloFatrz,
                         String pstr_IstanzaCiclo,
                         String pstr_CodeAccount)
       throws CustomException, RemoteException
  {
   String lstr_StoredProcedureName = "";

    try
    {
      switch (pint_OperazioneRichiesta)
      {
          default:
            lstr_StoredProcedureName = StaticContext.PKG_CONTRATTI + "getAccountValAttiva" ;
            break;
       }
       
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_TipoContratto},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CicloFatrz},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_IstanzaCiclo},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeAccount}
                   };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Account.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getAccountValAttiva",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }


  // getAccountFatture
  public Vector getAccountFatture (int pint_OperazioneRichiesta,
                         String pstr_TipoContratto,
                         String pstr_CicloFatrz,
                         String pstr_IstanzaCiclo,
                         String pstr_TipoFattura)
        throws CustomException, RemoteException
  {
   String lstr_StoredProcedureName = "";

    try
    {
      switch (pint_OperazioneRichiesta)
      {
          default:
            if ( pstr_TipoFattura.equalsIgnoreCase(StaticContext.FATTURE_PROVVISORIE) )
              lstr_StoredProcedureName = StaticContext.PKG_CONTRATTI + "getAccountFattureProvvisorie" ;
            else
              lstr_StoredProcedureName = StaticContext.PKG_CONTRATTI + "getAccountFattureDefinitive" ;
            break;
       }
       
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_TipoContratto},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CicloFatrz},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_IstanzaCiclo}
                   };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Account.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getAccountFatture",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

 // getAccountParamClasSconto
  public Vector getAccountParamClasSconto ()
        throws CustomException, RemoteException
  {
   String lstr_StoredProcedureName = "";

    try
    {
      lstr_StoredProcedureName = StaticContext.PKG_CONTRATTI + "getAccountParamClasSconto" ;
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Account.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getAccountParamClasSconto",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

//getPeriodoParamClasSconto
public Vector getPeriodoParamClasSconto ()
        throws CustomException, RemoteException
  {
   String lstr_StoredProcedureName = "";

    try
    {
      lstr_StoredProcedureName = StaticContext.PKG_CONTRATTI + "getPeriodoParamClasSconto" ;
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Account.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getPeriodoParamClasSconto",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }


//countGestoriParamClasSconto
public Integer countGestoriParamClasSconto (String pstr_Mese,
                                            String pstr_Anno,
                                            String pstr_CodeGest)
        throws CustomException, RemoteException
  {
   String lstr_StoredProcedureName = "";

    try
    {
      lstr_StoredProcedureName = StaticContext.PKG_CONTRATTI + "countGestoriParamClasSconto" ;
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_Mese},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_Anno},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeGest}
                   };

      Vector lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"countGestoriParamClasSconto",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

//getSumTotSpesaParamClasSconto
public Double getSumTotSpesaParamClasSconto (String pstr_Mese,
                                              String pstr_Anno,
                                              String pstr_CodeGest)
        throws CustomException, RemoteException
  {
   String lstr_StoredProcedureName = "";

    try
    {
      lstr_StoredProcedureName = StaticContext.PKG_CONTRATTI + "getSumTotSpesaParamClasSconto" ;
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_DOUBLE},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeGest},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_Mese},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_Anno}
                   };

      Vector lvct_SPReturn = this.callSP(larr_CallSP);
      Double ldbl_Return = (Double)lvct_SPReturn.get(0);

      return ldbl_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getSumTotSpesaParamClasSconto",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

//GetlistaAccountParamClasSconto
public Vector GetlistaAccountParamClasSconto (String pstr_Mese,
                                              String pstr_Anno)/*,
                                              String pstr_CodeGest,
                                              String pstr_CodeTipoContr)*/
        throws CustomException, RemoteException
  {
   String lstr_StoredProcedureName = "";

    try
    {
      lstr_StoredProcedureName = StaticContext.PKG_CONTRATTI + "GetlistaAccountParamClasSconto" ;
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   //{AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeGest},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_Mese},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_Anno}//,
                   //{AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoContr}
                   };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Account.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"GetlistaAccountParamClasSconto",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

  public String getVerificaContrattoProvvisorio(String pstr_CodeContr) throws  RemoteException, CustomException
  {
    String lstr_StoredProcedureName = StaticContext.PKG_CONTRATTI + "getTestContrattoProvvisorio";
    try 
    {
      Vector lvct_SPReturn=null;
      
      String[][] larr_CallSP =
              {{lstr_StoredProcedureName},
               {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeContr}};      

      lvct_SPReturn = this.callSP(larr_CallSP, DB_Contratto.class);
      String lstr_Return = (String)lvct_SPReturn.get(0);

      return lstr_Return;
    } 
    catch(Exception lexc_Exception) 
    {
      throw new CustomException(lexc_Exception.toString(),
                                "",
                                "getVerificaContrattoProvvisorio",
                                this.getClass().getName(),
                                StaticContext.FindExceptionType(lexc_Exception));
    }
  }
  
/*ESTRAZIONI CVIDYA - INIZIO*/
  public I52Estrazioni_cvidya_lanci getDatiObjFileEstrazioni(String nomeFileEstrazione) throws  RemoteException,CustomException
  {
    System.out.println("getDatiObjFileEstrazioni - nomeFile ["+nomeFileEstrazione+"]");
    I52Estrazioni_cvidya_lanci riga = null;
    CallableStatement cs = null;
    ResultSet rs = null;
    Vector recs = new Vector();
    int contaRighe = 0;
    String strDatiFile = "{? = call " + StaticContext.PKG_ESTRAZIONI +" getDatiFileEstrazione(?) }";
    try 
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(strDatiFile);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2,nomeFileEstrazione);
      cs.execute();  
      rs = (ResultSet)cs.getObject(1);      
    
      while (rs.next()) 
      { 
        System.out.println("getDatiObjFileEstrazioni - elemento trovato");
        riga =  new I52Estrazioni_cvidya_lanci();
        riga.setCode_tipo_contr(rs.getString("CODE_TIPO_CONTR"));
        riga.setData_inizio_ciclo(rs.getString("DATA_INIZIO_CICLO"));        
        riga.setData_inizio_periodo(rs.getString("DATA_INIZIO_PERIODO"));
        riga.setData_fine_periodo(rs.getString("DATA_FINE_PERIODO"));
        riga.setDescrizione_ciclo(rs.getString("DESCRIZIONE_CICLO"));        
        contaRighe++;
      } 
      
      rs.close();
    }
    catch (Exception e) 
    {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella delle funzionalità","getDatiFileEstrazioni","Ent_ContrattiBean",StaticContext.FindExceptionType(e));      
    } 
    finally 
    {
      try 
      {
         if(rs!=null)
         rs.close();
         cs.close();
      } 
      catch (Exception e){
        throw new CustomException(e.toString(),"Errore di accesso alla tabella delle funzionalità","getDatiFileEstrazioni","Ent_ContrattiBean",StaticContext.FindExceptionType(e));      
      }
      try 
      {
         conn.close();
      } 
      catch (Exception e){
        throw new CustomException(e.toString(),"Errore di accesso alla tabella delle funzionalità","getDatiFileEstrazioni","Ent_ContrattiBean",StaticContext.FindExceptionType(e));          
      }
    }
    if (contaRighe > 1)
    {
      throw new CustomException("Too many rows returned","Errore di accesso alla tabella delle funzionalità","getDatiFileEstrazioni","Ent_ContrattiBean","SqlException");                
    }
    return riga;
  }
  
/*ESTRAZIONI CVIDYA - FINE*/

}