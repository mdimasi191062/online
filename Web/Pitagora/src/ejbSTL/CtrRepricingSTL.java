package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface CtrRepricingSTL extends EJBObject 
{
 
    // lancioBatch
    String lancioBatch (String pstr_CodeTipoContratto,
                                String pstr_CodeUtente,
                                Vector pvct_Account,
                                String code_funz,
                                String code_funz_batch)
        throws CustomException, RemoteException;
}