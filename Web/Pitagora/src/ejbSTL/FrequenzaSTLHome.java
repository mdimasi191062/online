package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface FrequenzaSTLHome extends EJBHome 
{
  FrequenzaSTL create() throws RemoteException, CreateException;
}