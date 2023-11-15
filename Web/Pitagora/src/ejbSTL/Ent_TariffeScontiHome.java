package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_TariffeScontiHome extends EJBHome 
{
  Ent_TariffeSconti create() throws RemoteException, CreateException;
}