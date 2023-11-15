package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_ClassOggFattHome extends EJBHome 
{
  Ent_ClassOggFatt create() throws RemoteException, CreateException;
}