package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface CtrContrattiSTL extends EJBObject 
{
  // getClientiStatoProvvisorio
  Vector getAccountStatoProvvisorio (Vector pvct_AccountSelezionati, 
                                     String pstr_TipoContratto,
                                     String pstr_CodeFunz)
    throws CustomException, RemoteException;

}