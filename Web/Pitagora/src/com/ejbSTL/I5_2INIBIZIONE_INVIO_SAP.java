package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.*;
import com.ejbSTL.I5_2INIBIZIONE_INVIO_SAP_ROW;
import java.util.Vector;
import com.utl.*;

public interface I5_2INIBIZIONE_INVIO_SAP extends EJBObject 
{
  public Vector findAllGestore(String flagSys) throws RemoteException,CustomException;
  public String insertInibSap(I5_2INIBIZIONE_INVIO_SAP_ROW row) throws RemoteException,CustomException;
  public Vector getAccount() throws CustomException, RemoteException;
  public Vector getAccountCl() throws CustomException, RemoteException;
  public Boolean modifyInibSap(I5_2INIBIZIONE_INVIO_SAP_ROW row) throws RemoteException,CustomException;
  public Vector findGestore(String descGest,String flagSys) throws RemoteException,CustomException;
  public Boolean eliminaInibSap(int idRegola) throws RemoteException,CustomException;
  public Boolean chiudiInibSap(int idRegola) throws RemoteException,CustomException;
}
