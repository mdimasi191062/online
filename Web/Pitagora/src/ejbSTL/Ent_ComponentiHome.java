package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_ComponentiHome extends EJBHome 
{
  Ent_Componenti create() throws RemoteException, CreateException;
}