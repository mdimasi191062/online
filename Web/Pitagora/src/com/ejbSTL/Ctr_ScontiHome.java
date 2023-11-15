package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ctr_ScontiHome extends EJBHome 
{
  Ctr_Sconti create() throws RemoteException, CreateException;
}