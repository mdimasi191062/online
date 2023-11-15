package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ctr_TariffeScontiHome extends EJBHome 
{
  Ctr_TariffeSconti create() throws RemoteException, CreateException;
}