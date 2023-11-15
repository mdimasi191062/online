package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_TipiOfferteHome extends EJBHome 
{
  Ent_TipiOfferte create() throws RemoteException, CreateException;
}