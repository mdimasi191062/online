package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface I5_3GEST_TLCejbHome extends EJBHome 
{
  I5_3GEST_TLCejb create() throws RemoteException, CreateException;
}