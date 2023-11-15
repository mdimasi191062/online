package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_ScontiHome extends EJBHome 
{
  Ent_Sconti create() throws RemoteException, CreateException;
}