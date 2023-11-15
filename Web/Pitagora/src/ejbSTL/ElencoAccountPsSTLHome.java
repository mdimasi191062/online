package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface ElencoAccountPsSTLHome extends EJBHome 
{
  ElencoAccountPsSTL create() throws RemoteException, CreateException;
}