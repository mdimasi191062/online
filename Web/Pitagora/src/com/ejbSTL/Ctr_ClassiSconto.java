package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ctr_ClassiSconto extends EJBObject 
{
    // insParamClasSconto
    String insParamClasSconto (Vector pvct_ParamClasSconto)
        throws CustomException, RemoteException;

    // getAccountSpeComNoCong
    Vector getClassiScontoCalPar (String pstr_CodeTipoContratto,
                                        Vector pvct_AccountSelezionati)
        throws CustomException, RemoteException;
}