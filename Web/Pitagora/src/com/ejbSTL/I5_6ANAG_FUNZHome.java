package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface I5_6ANAG_FUNZHome extends EJBHome 
{
  I5_6ANAG_FUNZ create() throws RemoteException, CreateException;
}