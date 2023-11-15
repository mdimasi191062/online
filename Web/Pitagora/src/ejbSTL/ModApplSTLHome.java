package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface ModApplSTLHome extends EJBHome 
{
  ModApplSTL create() throws RemoteException, CreateException;
}