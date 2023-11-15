package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_ClientiHome extends EJBHome 
{
  Ent_Clienti create() throws RemoteException, CreateException;
}