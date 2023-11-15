package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface EntBatchSTL extends EJBObject 
{
	// lancioBatch
	Integer lancioBatch (String pstr_Parametri)
		throws CustomException, RemoteException;

 // insParamValoriz
  Integer insParamValoriz(int pint_OperazioneRichiesta, DB_Account pDB_Account )
        throws CustomException, RemoteException;

   // getElabBatchVerifica
  Vector getElabBatchVerifica (int pint_OperazioneRichiesta,
                                String pstr_TipoContratto,
                                String pstr_CodeFunz)
    throws CustomException, RemoteException;
      

}