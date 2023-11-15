package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.rmi.RemoteException;
import com.utl.*;
import java.util.Vector;


public class Ent_StatisticheBean extends AbstractClassicEJB implements SessionBean  {
    public void ejbCreate() {
    }

    public void ejbActivate() {
    }

    public void ejbPassivate() {
    }

    public void ejbRemove() {
    }

    public void setSessionContext(SessionContext ctx) {
    }

    public Vector getAccountStatistiche(int pint_OperazioneRichiesta, int pint_Funzionalita, String pstr_TipoContratto) 
        throws CustomException, RemoteException {

        String lstr_StoredProcedureName = "";

        try {
        
            switch (pint_Funzionalita) {
                default:
                    switch (pint_OperazioneRichiesta) {
                        default :
                            lstr_StoredProcedureName = StaticContext.PKG_CLIENTI + "getAccountValidi" ;
                            break;
                    }
                    break;
            }

            String[][] larr_CallSP =
                      {{lstr_StoredProcedureName},
                       {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                       {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,pstr_TipoContratto},
                       {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,null}};
                   
            Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Account.class);
            Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

            return lvct_Return;
        
        } catch (Exception lexc_Exception) {
            throw new CustomException(lexc_Exception.toString(),
                                        "",
                                        "getAccountStatistiche",
                                        this.getClass().getName(),
                                        StaticContext.FindExceptionType(lexc_Exception));
    
        }
    }
    
}