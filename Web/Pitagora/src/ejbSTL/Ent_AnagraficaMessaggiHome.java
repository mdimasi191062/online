package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_AnagraficaMessaggiHome extends EJBHome 
{
  Ent_AnagraficaMessaggi create() throws RemoteException, CreateException;
}