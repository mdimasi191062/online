package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface EntContrattiSTL extends EJBObject 
{
	// getAccountStatoProvvisorio
	Vector getAccountStatoProvvisorio (int pint_OperazioneRichiesta,
										String pstr_CodeAccount,
										String pstr_CodeGest,
										String pstr_TipoContratto,
										String pstr_CodeFunz)
		throws CustomException, RemoteException;


  // getAccountXCodeElab
  Vector getAccountXCodeElab ( int pint_OperazioneRichiesta,
                                      String pstr_CodeElab,
                                      String pstr_TipoContratto,
                                      String pstr_TipoFlagErrBloc)
       throws CustomException, RemoteException;

 // getAccountRepricing
  Vector getAccountRepricing (String pstr_TipoContratto,
                         String code_funz)
        throws CustomException, RemoteException;


}