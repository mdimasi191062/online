package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.rmi.RemoteException;
import com.utl.*;
import java.util.Vector;


public class Ent_PrestazioniAggiuntiveBean extends AbstractClassicEJB implements SessionBean 
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

  // getPrestazioniAggiuntive
  public Vector getPrestazioniAggiuntive(int pint_OperazioneRichiesta,
                                         int pint_Funzionalita,
                                         String pstr_CodePS,
                                         String pstr_CodeContr,
                                         String pstr_CodeTipoContr,
                                         String pstr_CodeGest)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {
      Vector lvct_SPReturn = null;
      switch (pint_Funzionalita)
      {
          case StaticContext.FN_TARIFFA:
          case StaticContext.FN_TARIFFA_PS_FIGLI_CDN:
          case StaticContext.FN_ASS_TAR_SCO:
               switch (pint_OperazioneRichiesta)
               {
                case StaticContext.LIST :
                lstr_StoredProcedureName = StaticContext.PKG_PRESTAZIONIAGGIUNTIVE + "getPrestAggiunOFPS" ;
                break;
                          
                case StaticContext.INSERT :
                case StaticContext.DELETE :
                lstr_StoredProcedureName = StaticContext.PKG_PRESTAZIONIAGGIUNTIVE + "getPrestAggiunValidiTariffe" ;                  
                break;

               }
               break;
           
            
          case StaticContext.FN_ASS_OFPS:
            lstr_StoredProcedureName = StaticContext.PKG_PRESTAZIONIAGGIUNTIVE + "getPrestAggiunOFPS" ;
          break;
      }
      String[][] larr_CallSP =
        {{lstr_StoredProcedureName},
        {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoContr},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeGest},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeContr},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePS}};

      lvct_SPReturn = this.callSP(larr_CallSP, DB_PrestazioniAggiuntive.class);
      
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getPrestazioniAggiuntive",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }
}