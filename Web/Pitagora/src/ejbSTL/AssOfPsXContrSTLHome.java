package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface AssOfPsXContrSTLHome extends EJBHome 
{
  AssOfPsXContrSTL create() throws RemoteException, CreateException;
}