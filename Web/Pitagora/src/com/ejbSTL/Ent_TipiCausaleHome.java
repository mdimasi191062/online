package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_TipiCausaleHome extends EJBHome 
{
  Ent_TipiCausale create() throws RemoteException, CreateException;
}