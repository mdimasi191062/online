package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_ClassiScontoNewHome extends EJBHome 
{
  Ent_ClassiScontoNew create() throws RemoteException, CreateException;
}