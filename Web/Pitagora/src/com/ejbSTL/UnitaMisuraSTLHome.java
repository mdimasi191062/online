package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface UnitaMisuraSTLHome extends EJBHome 
{
  UnitaMisuraSTL create() throws RemoteException, CreateException;
}