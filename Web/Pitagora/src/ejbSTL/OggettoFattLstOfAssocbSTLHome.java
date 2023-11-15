package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface OggettoFattLstOfAssocbSTLHome extends EJBHome 
{
  OggettoFattLstOfAssocbSTL create() throws RemoteException, CreateException;
}