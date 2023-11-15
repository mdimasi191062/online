package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface I5_2INIBIZIONE_INVIO_SAPHome extends EJBHome 
{
  I5_2INIBIZIONE_INVIO_SAP create() throws RemoteException, CreateException;
}