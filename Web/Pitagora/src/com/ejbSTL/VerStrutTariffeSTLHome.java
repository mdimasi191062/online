package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface VerStrutTariffeSTLHome extends EJBHome 
{
  VerStrutTariffeSTL create() throws RemoteException, CreateException;
}