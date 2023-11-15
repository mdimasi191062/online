package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface SecurityHome extends EJBHome 
{
  Security create() throws RemoteException, CreateException;
}

