package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface CausaleSTLHome extends EJBHome 
{
  CausaleSTL create() throws RemoteException, CreateException;
}