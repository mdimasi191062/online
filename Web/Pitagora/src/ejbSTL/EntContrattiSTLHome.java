package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface EntContrattiSTLHome extends EJBHome 
{
  EntContrattiSTL create() throws RemoteException, CreateException;
}