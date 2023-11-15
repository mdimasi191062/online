package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface FunzionalitaSTLHome extends EJBHome 
{
  FunzionalitaSTL create() throws RemoteException, CreateException;
}