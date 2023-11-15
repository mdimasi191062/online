package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface ContrattoSTLHome extends EJBHome 
{
  ContrattoSTL create() throws RemoteException, CreateException;
}