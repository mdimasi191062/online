package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_ClassiScontoHome extends EJBHome 
{
  Ent_ClassiSconto create() throws RemoteException, CreateException;
}