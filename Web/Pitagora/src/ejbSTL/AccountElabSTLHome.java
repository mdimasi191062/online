package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface AccountElabSTLHome extends EJBHome 
{
  AccountElabSTL create() throws RemoteException, CreateException;
}

