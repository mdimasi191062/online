package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_FattureHome extends EJBHome 
{
  Ent_Fatture create() throws RemoteException, CreateException;
}