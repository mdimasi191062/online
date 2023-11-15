package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_ServiziHome extends EJBHome 
{
  Ent_Servizi create() throws RemoteException, CreateException;
}