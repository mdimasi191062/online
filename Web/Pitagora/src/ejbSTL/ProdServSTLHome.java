package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface ProdServSTLHome extends EJBHome 
{
  ProdServSTL create() throws RemoteException, CreateException;
}