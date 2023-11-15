package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface SitoSTLHome extends EJBHome 
{
  SitoSTL create() throws RemoteException, CreateException;
}