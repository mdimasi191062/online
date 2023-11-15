package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface CmbStatiBatchSTLHome extends EJBHome 
{
  CmbStatiBatchSTL create() throws RemoteException, CreateException;
}