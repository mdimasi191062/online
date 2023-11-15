package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ent_Batch_PRE extends EJBObject 
{
 // getAnagBatchPre
  Vector getAnagBatchPre ()
        throws CustomException, RemoteException;

  // getElabBatchVerificaPreFatt
 Vector getElabBatchVerificaPreFatt (String pstr_CodeFunz)
    throws CustomException, RemoteException;
	
 // getAccountValidi
  Vector GetAccountValidi (String pstr_TipoContratto,
   							String pstr_DescAccount)
   throws CustomException, RemoteException;

}