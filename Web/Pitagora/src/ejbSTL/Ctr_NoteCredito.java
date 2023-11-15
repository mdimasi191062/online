package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ctr_NoteCredito extends EJBObject 
{

    // congela
    String congela (String pstr_CodeTipoContratto,
                                String pstr_CodeUtente,
                                Vector pvct_Account)
        throws CustomException, RemoteException;

    // lancioBatch
    String lancioBatch (String pstr_CodeTipoContratto,
                                String pstr_CodeUtente,
                                String pstr_DataFinePeriodo,
                                Vector pvct_Account)
        throws CustomException, RemoteException;

}