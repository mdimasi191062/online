package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ctr_ContrattiHome extends EJBHome 
{
  Ctr_Contratti create() throws RemoteException, CreateException;
}