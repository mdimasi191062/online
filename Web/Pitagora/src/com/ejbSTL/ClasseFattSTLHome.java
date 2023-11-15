package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface ClasseFattSTLHome extends EJBHome 
{
  ClasseFattSTL create() throws RemoteException, CreateException;
}