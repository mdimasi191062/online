package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface UnTerReteSTLHome extends EJBHome 
{
  UnTerReteSTL create() throws RemoteException, CreateException;
}