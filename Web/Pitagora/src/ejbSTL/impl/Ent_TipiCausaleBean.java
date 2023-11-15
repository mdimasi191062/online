package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.util.Vector;
import java.rmi.RemoteException;
import com.utl.*;


public class Ent_TipiCausaleBean extends AbstractClassicEJB implements SessionBean 
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

  // getTipiCausale
  public Vector getTipiCausale(int pint_OperazioneRichiesta,
                               int pint_Funzionalita,
                               String pstr_CodePS,
                               String pstr_CodeGest,
                               String pstr_CodeContr,
                               String pstr_CodePrestAgg,
                               String pstr_CodeTipoContr,
                               String pstr_CodeOggFatrz)
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
                  lstr_StoredProcedureName = StaticContext.PKG_TIPICAUSALE + "getTipiCausaleTariffe" ;

                String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoContr},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeGest},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeContr},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePS},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePrestAgg}};

                 lvct_SPReturn = this.callSP(larr_CallSP, DB_TipoCausale.class);
                break;

                case StaticContext.INSERT :
                case StaticContext.DELETE :
                  lstr_StoredProcedureName = StaticContext.PKG_TIPICAUSALE + "getTipiCausaleValidiTariffe" ;

                String[][] larr_CallSP2 =
                     {{lstr_StoredProcedureName},
                      {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoContr},
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeGest},
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeContr},
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePS},
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePrestAgg},
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeOggFatrz}};

                 lvct_SPReturn = this.callSP(larr_CallSP2, DB_TipoCausale.class);
                break;
            }
            break;
        case StaticContext.FN_ASS_OFPS :
            switch (pint_OperazioneRichiesta)
            {
                default :
                  lstr_StoredProcedureName = StaticContext.PKG_TIPICAUSALE + "getTipiCausaleOFPS" ;

                String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoContr},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeGest},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeContr},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePS},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePrestAgg}};

                lvct_SPReturn = this.callSP(larr_CallSP, DB_TipoCausale.class);
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
									"getTipiCausale",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }
}