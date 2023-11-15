package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface AssOfPsSTLHome extends EJBHome 
{
  AssOfPsSTL create() throws RemoteException, CreateException;
}