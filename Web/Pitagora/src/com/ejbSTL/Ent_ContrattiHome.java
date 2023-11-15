package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_ContrattiHome extends EJBHome 
{
  Ent_Contratti create() throws RemoteException, CreateException;
}