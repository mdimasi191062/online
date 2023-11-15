package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface EntBatchSTLHome extends EJBHome 
{
  EntBatchSTL create() throws RemoteException, CreateException;
}