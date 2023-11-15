package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ctr_Fatture extends EJBObject 
{
    // CambioCicloFatturazione
    String CambioCicloFatturazione (Vector pvct_AccountFatt,
                                     String pstr_TipoContratto,
                                     String pstr_CodeCicloFatrz,
                                     String pstr_IstanzaCiclo)
          throws CustomException, RemoteException;

    // delFattureProvvisorie
    String delFattureProvvisorie (Vector pvct_AccountFattProvv)
        throws CustomException, RemoteException;

}