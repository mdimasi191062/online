package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_TipiContrattoHome extends EJBHome 
{
  Ent_TipiContratto create() throws RemoteException, CreateException;
}