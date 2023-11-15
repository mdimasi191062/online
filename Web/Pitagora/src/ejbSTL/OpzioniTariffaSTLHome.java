package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface OpzioniTariffaSTLHome extends EJBHome 
{
  OpzioniTariffaSTL create() throws RemoteException, CreateException;
}