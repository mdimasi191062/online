package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface ElencoClliSTLHome extends EJBHome 
{
  ElencoClliSTL create() throws RemoteException, CreateException;
}