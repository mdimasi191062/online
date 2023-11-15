package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_TipiServizioHome extends EJBHome 
{
  Ent_TipiServizio create() throws RemoteException, CreateException;
}