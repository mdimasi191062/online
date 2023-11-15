package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface EstrazioniConfSTLHome extends EJBHome 
{
  EstrazioniConfSTL create() throws RemoteException, CreateException;
}

