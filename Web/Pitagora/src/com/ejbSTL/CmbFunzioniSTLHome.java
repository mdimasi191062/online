package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface CmbFunzioniSTLHome extends EJBHome 
{
  CmbFunzioniSTL create() throws RemoteException, CreateException;
}