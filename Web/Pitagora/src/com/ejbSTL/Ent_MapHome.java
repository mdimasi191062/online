package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_MapHome extends EJBHome 
{
  Ent_Map create() throws RemoteException, CreateException;
}