package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface CmbUtentiSTLHome extends EJBHome 
{
  CmbUtentiSTL create() throws RemoteException, CreateException;
}