package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface ControlliSTLHome extends EJBHome 
{
  ControlliSTL create() throws RemoteException, CreateException;
}