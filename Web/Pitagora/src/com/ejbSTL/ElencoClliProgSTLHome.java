package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface ElencoClliProgSTLHome extends EJBHome 
{
  ElencoClliProgSTL create() throws RemoteException, CreateException;
}