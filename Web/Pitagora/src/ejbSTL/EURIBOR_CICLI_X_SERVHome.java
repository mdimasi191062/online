package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface EURIBOR_CICLI_X_SERVHome extends EJBHome 
{
  EURIBOR_CICLI_X_SERV create() throws RemoteException, CreateException;
}