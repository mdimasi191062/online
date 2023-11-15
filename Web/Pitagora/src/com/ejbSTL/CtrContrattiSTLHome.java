package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface CtrContrattiSTLHome extends EJBHome 
{
  CtrContrattiSTL create() throws RemoteException, CreateException;
}