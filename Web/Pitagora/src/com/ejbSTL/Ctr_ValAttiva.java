package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ctr_ValAttiva extends EJBObject 
{
    // LancioBatch
    String LancioBatch ( Vector pvct_AccountSelezionati,
                          String pstr_TipoContratto,     
                          String pstr_DataFinePeriodo,
                          String pstr_CodeCicloFatrz,
                          String pstr_IstanzaCicloFatrz ,
                          String pstr_CodeUtente)
        throws CustomException, RemoteException;


    // congela
    String congela (String pstr_CodeTipoContratto,
                                String pstr_CodeUtente,
                                Vector pvct_Account)
        throws CustomException, RemoteException;

}